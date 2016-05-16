/*
 * Copyright 2014 cloudmatch.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "CMCloudMatchClient.h"
#import "CMMatchHelper.h"

#import "CMLocation.h"
#import "CMInnerOuterChecker.h"
#import "CMUtilities.h"

//Constants
#import "CMJsonConstants.h"
#import "CMResponsesConstants.h"
#import "CMJsonGeneralLabels.h"

//Models
#import "CMDeliveryInput.h"
#import "CMDeliveryResponse.h"
#import "CMDisconnectInput.h"
#import "CMLeaveGroupInput.h"
#import "CMLeaveGroupResponse.h"
#import "CMMatcheeDelivery.h"
#import "CMMatcheeDeliveryMessage.h"
#import "CMMatcheeLeftMessage.h"
#import "CMMatchInput.h"
#import "CMMatchResponse.h"

//CHUNK SIZE
NSInteger const kCMMaxDeliveryChunkSize = 1024 * 10;

@interface CMCloudMatchClient ()

// api key & app id
@property (nonatomic, strong) NSString* apiKey;
@property (nonatomic, strong) NSString* appId;

//WebSocket connection
@property (nonatomic, strong) SRWebSocket *webSocket;

//Delegates
@property (nonatomic, weak) id<CMOnServerMessageDelegate> onServerMessageDelegate;
@property (nonatomic, weak) id<CMOnServerEventDelegate> onServerEventDelegate;

//Gesture recognizer
@property (nonatomic, strong) CMInnerOuterChecker *innerOuterChecker;

//Transfer
@property (nonatomic, strong) NSMutableArray *sendQueue;
@property (nonatomic, strong) CMServerMessagesHandler *serverMessagesHandler;

// Matcher
@property (nonatomic, strong) CMMatchHelper *matchHelper;

@end

@implementation CMCloudMatchClient

+(CMCloudMatchClient *)sharedInstance {
    static dispatch_once_t pred;
    static CMCloudMatchClient *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[CMCloudMatchClient alloc] init];
    });
    return shared;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.sendQueue = [[NSMutableArray alloc] init];
        self.GMClientShouldStopUpdatingLocationOnDealloc = YES;
        [[CMLocation sharedInstance] startLocationServices];
    }
    return self;
}

- (void)dealloc
{
    //Detected when app is closed?
    if (self.GMClientShouldStopUpdatingLocationOnDealloc) {
        [[CMLocation sharedInstance] stopLocationServices];
    }
}

- (void)setServerEventDelegate:(id<CMOnServerEventDelegate>)serverEventDelegate apiKey:(NSString*)apiKey appId:(NSString*)appId
{
    // trim whitespaces and enter keys
    NSString *apiKeyTrimmed = [apiKey stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *appIdTrimmed = [appId stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    _serverMessagesHandler = [[CMServerMessagesHandler alloc] initWithServerEventDelegate:serverEventDelegate];
    self.onServerMessageDelegate = _serverMessagesHandler;
    self.onServerEventDelegate = serverEventDelegate;
    
    _appId = appIdTrimmed;
    _apiKey = apiKeyTrimmed;
    
    _matchHelper = [[CMMatchHelper alloc] init];
}

-(CMMatchHelper*)getMatcher
{
    return _matchHelper;
}

-(SRWebSocket*)getWebSocket
{
    // TODO: if not connected ...
    return _webSocket;
}

#pragma mark - SDK View methods

- (void)attachToView:(UIView*)view withMovementDelegate:(id<CMOnMovementDelegate>)delegate criteria:(NSString*)criteria
{
    //Initialize the innerOuterChecker (a subclass of PanGestureRecognizer)
    _innerOuterChecker = [[CMInnerOuterChecker alloc] initWithCriteria:criteria];

    //This is the PanGestureRecognizer's delegate
    _innerOuterChecker.delegate = self;
    
    //This is GestureMatch onMovementDelegate
    _innerOuterChecker.movementDelegate = delegate;
    
    //This is the view that the PanGestureRecognizer is attached to
    _innerOuterChecker.attachedView = view;
    
    //Does not cancel touches in the view attached to PanGestureRecognizer so that touch events are forwarded immediately
    _innerOuterChecker.cancelsTouchesInView = NO;
    
    //Does not delay touches
    _innerOuterChecker.delaysTouchesBegan = NO;
    _innerOuterChecker.delaysTouchesEnded = NO;
    
    [view addGestureRecognizer:_innerOuterChecker];
}

- (void)detachFromView:(UIView*)view
{
    _innerOuterChecker.delegate = nil;
    _innerOuterChecker = nil;
    self.onServerEventDelegate = nil;
    [self closeConnection];
}

- (void)move:(id)sender
{
    //Please keep this method for the time being, although movement detection is performed by InnerOuterChecker
//    CGPoint locationInWindow = [_attachedView convertPoint:[_panRecognizer locationInView:_attachedView] toView:[[[UIApplication sharedApplication] delegate] window]];
}

#pragma mark - SRWebSocketDelegate

- (void)webSocketDidOpen:(SRWebSocket *)webSocket;
{
    [self.onServerEventDelegate onConnectionOpen];
    
    //If there's data to send, send it
    [_sendQueue enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSData *data = [_sendQueue objectAtIndex:idx];
        [_webSocket send:data];
        [_sendQueue removeObjectAtIndex:idx];
    }];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error;
{
    _webSocket = nil;
    [self.onServerEventDelegate onConnectionError:error];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message;
{
    NSString *m;
    if([message isKindOfClass:[NSData class]]){
        m = [[NSString alloc] initWithData:message encoding:NSUTF8StringEncoding];
    }
    else{
        m = message;
    }
    [self.onServerMessageDelegate onServerMessage:m];
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean;
{
    _webSocket = nil;
    [self.onServerEventDelegate onConnectionClosedWithWSReason:reason];
}

#pragma mark - GestureMatchConnection public methods

- (void)connect
{
    _webSocket.delegate = nil;
    [_webSocket close];
    
    NSString *deviceID = [CMUtilities getDeviceIdForAppId];
    
    NSURLComponents *components = [[NSURLComponents alloc] init];
    components.scheme = @"wss";
    components.host = @"api.cloudmatch.io";
    components.port = @443;
    components.path = @"/v1/open";
    components.queryItems = @[
                              [NSURLQueryItem queryItemWithName:@"apiKey" value:self.apiKey],
                              [NSURLQueryItem queryItemWithName:@"appId" value:self.appId],
                              [NSURLQueryItem queryItemWithName:@"os" value:@"iOS"],
                              [NSURLQueryItem queryItemWithName:@"deviceId" value:[deviceID stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]]]
                              ];
    NSURL *url1 = [components URL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url1];

    _webSocket = [[SRWebSocket alloc] initWithURLRequest:urlRequest];
    _webSocket.delegate = self;
    
    [_webSocket open];
}

- (void)closeConnection
{
    [_webSocket close];
}

#pragma mark - GestureMatchConnection private methods

- (NSArray*)splitEqually:(NSString*)payload chunkSize:(NSInteger)chunkSize
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSInteger start = 0; start < payload.length; start+=chunkSize) {
        NSRange range = NSMakeRange(start, chunkSize);
        if (start+chunkSize > payload.length) {
            //if range is out of string length, reduce the range
            range = NSMakeRange(start, payload.length - start);
        }
        [array addObject:[payload substringWithRange:range] ];
    }
    return [array copy];
}

- (void)deliverPayload:(NSString*)payload toGroup:(NSString*)groupId
{
    [self deliverPayload:payload ToRecipients:nil inGroup:groupId];
}

- (void)deliverPayload:(NSString *)payload ToRecipients:(NSArray *)recipients inGroup:(NSString *)groupId
{
    //Prepare the array of chunks
    NSArray *chunks = [self splitEqually:payload chunkSize:kCMMaxDeliveryChunkSize];
    NSString *deliveryId = [[CMUtilities generateDeliveryUUID] substringToIndex:3];
    
    //Iterate over the array and send each chunk
    [chunks enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        CMDeliveryInput *deliveryInput = [[CMDeliveryInput alloc] initWithRecipients:recipients deliveryId:deliveryId payload:[chunks objectAtIndex:idx] groupId:groupId totalChunks:[chunks count] chunkNr:idx];

        @try {
            NSError *jsonError;
            NSData *data = [NSJSONSerialization dataWithJSONObject:[deliveryInput dictionaryRepresentation] options:0 error:&jsonError];
            NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

            if (string == nil) {
                @throw [NSException exceptionWithName:@"Error parsing deliverPayload" reason:jsonError.localizedDescription userInfo:nil];
            }
            
            if (_webSocket.readyState != SR_OPEN) {
                [_sendQueue addObject:string];
                [self connect];
            } else{
                [_webSocket send:string];
                //TODO: check that progress update is sent
                NSInteger progress = (NSInteger)(((idx+1) * 100)/[chunks count]);
                [self.onServerEventDelegate onMatcheeDeliveryProgress: progress forDeliveryId:deliveryId];
            }

        }
        @catch (NSException *exception) {
            // TODO: handle exception
        }
        
    }];

}

#pragma mark - PanGestureRecognizer Delegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //maybe use this to disable when client is transmitting?
    return YES;
}

@end

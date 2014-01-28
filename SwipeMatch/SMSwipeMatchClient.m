//
//  SMSwipeMatchClient.m
//  SwipeMatchSDK
//
//  Created by Giovanni on 11/13/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

#import "SMSwipeMatchClient.h"
#import "SMApiConstants.h"

//CHUNK SIZE
NSInteger const kSMMaxDeliveryChunkSize = 1024 * 10;

@interface SMSwipeMatchClient ()

// api key & app id
@property (nonatomic, strong) NSString* apiKey;
@property (nonatomic, strong) NSString* appId;

//WebSocket connection
@property (nonatomic, strong) SRWebSocket *webSocket;

//Delegates
@property (weak) id<SMOnServerMessageDelegate> onServerMessageDelegate;
@property (weak) id<SMOnServerEventDelegate> onServerEventDelegate;

//Gesture recognizer
@property (nonatomic, strong) SMInnerOuterChecker *innerOuterChecker;

//Transfer
@property (nonatomic, strong) NSMutableArray *sendQueue;
@property (nonatomic, strong) SMServerMessagesHandler *serverMessagesHandler;

// Matcher
@property (nonatomic, strong) SMMatchHelper *matchHelper;

@end

@implementation SMSwipeMatchClient

+(SMSwipeMatchClient *)sharedInstance {
    static dispatch_once_t pred;
    static SMSwipeMatchClient *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[SMSwipeMatchClient alloc] init];
    });
    return shared;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.sendQueue = [[NSMutableArray alloc] init];
        self.SMClientShouldStopUpdatingLocationOnDealloc = YES;
        [[SMLocation sharedInstance] startLocationServices];
    }
    return self;
}

- (void)dealloc
{
    //Detected when app is closed?
    if (self.SMClientShouldStopUpdatingLocationOnDealloc) {
        [[SMLocation sharedInstance] stopLocationServices];
    }
}

- (void)setServerEventDelegate:(id<SMOnServerEventDelegate>)serverEventDelegate apiKey:(NSString*)apiKey appId:(NSString*)appId
{
    _serverMessagesHandler = [[SMServerMessagesHandler alloc] initWithServerEventDelegate:serverEventDelegate];
    self.onServerMessageDelegate = _serverMessagesHandler;
    
    _appId = appId;
    _apiKey = apiKey;
    
    _matchHelper = [[SMMatchHelper alloc] init];
}

-(SMMatchHelper*)getMatcher
{
    return _matchHelper;
}

-(SRWebSocket*)getWebSocket
{
    // TODO: if not connected ...
    return _webSocket;
}

#pragma mark - SDK View methods

- (void)attachToView:(UIView*)view withMovementDelegate:(id<SMOnMovementDelegate>)delegate criteria:(NSString*)criteria
{
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    if ([view respondsToSelector:@selector(panAction:)]) {
        _innerOuterChecker = [[SMInnerOuterChecker alloc] initWithTarget:view action:@selector(panAction:) criteria:criteria];
    }
    else
    {
        _innerOuterChecker = [[SMInnerOuterChecker alloc] initWithTarget:nil action:nil criteria:criteria];

    }
#pragma clang diagnostic pop
    //This is the PanGestureRecognizer's delegate
    _innerOuterChecker.delegate = self;
    //This is our custom movementDelegate
    _innerOuterChecker.movementDelegate = delegate;
    _innerOuterChecker.attachedView = view;
    [view addGestureRecognizer:_innerOuterChecker];
    NSLog(@"%@ %@ panrecognizer view: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), _innerOuterChecker.view);
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
//    NSLog(@"move: %@", NSStringFromCGPoint([_innerOuterChecker locationInView:_innerOuterChecker.attachedView]) );
    //Please keep this method for the time being, although movement detection is performed by InnerOuterChecker
//    CGPoint locationInWindow = [_attachedView convertPoint:[_panRecognizer locationInView:_attachedView] toView:[[[UIApplication sharedApplication] delegate] window]];
}

#pragma mark - SRWebSocketDelegate

- (void)webSocketDidOpen:(SRWebSocket *)webSocket;
{
    NSLog(@"Websocket Connected");
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
    NSLog(@":( Websocket Failed With Error %@", error);
    _webSocket = nil;
    [self.onServerEventDelegate onConnectionError:error];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message;
{
    NSString *m;
    NSLog(@"WebSocketDidReceiveMessage");
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
    NSLog(@"WebSocket closed with code: %ld reason: %@", (long)code, reason);
    _webSocket = nil;
    [self.onServerEventDelegate onConnectionClosedWithWSReason:reason];
}

#pragma mark - SwipeMatchConnection public methods

- (void)connect
{
    _webSocket.delegate = nil;
    [_webSocket close];
    
    NSString *deviceID = [SMUtilities getDeviceIdForAppId:_appId];

    NSString* apiUrl = [NSString stringWithFormat:@"%@?%@=%@&%@=%@&%@=%@&%@=%@", kSMApiEndpoint, kSMApiParamApiKey, self.apiKey, kSMApiParamAppId, self.appId, kSMApiParamOS, @"ios", kSMApiParamDeviceId, deviceID];
    
    NSURLRequest *wsRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:apiUrl]];
    _webSocket = [[SRWebSocket alloc] initWithURLRequest:wsRequest];
    _webSocket.delegate = self;
    
    NSLog(@"Opening WebSocket connection");
    [_webSocket open];
}

- (void)closeConnection
{
    [_webSocket close];
}

#pragma mark - SwipeMatchConnection private methods

- (NSArray*)splitEqually:(NSString*)payload chunkSize:(NSInteger)chunkSize
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSInteger start = 0; start < payload.length; start+=chunkSize) {
        NSRange range = NSMakeRange(start, chunkSize);
        if (start+chunkSize > payload.length) {
            //if range is out of string length, reduce the range
            range = NSMakeRange(start, payload.length - start);
        }
        NSLog(@"loop %d range: %@", start, NSStringFromRange(range));
        [array addObject:[payload substringWithRange:range] ];
    }
    return [array copy];
}

- (void)deliverPayload:(NSString *)payload ToRecipients:(NSArray *)recipients inGroup:(NSString *)groupId
{
    //Prepare the array of chunks
    NSArray *chunks = [self splitEqually:payload chunkSize:kSMMaxDeliveryChunkSize];
    NSString *deliveryId = [SMUtilities generateDeliveryUUID];
    
    //Iterate over the array and send each chunk
    [chunks enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        SMDeliveryInput *deliveryInput = [[SMDeliveryInput alloc] initWithRecipients:recipients deliveryId:deliveryId payload:[chunks objectAtIndex:idx] groupId:groupId totalChunks:[chunks count] chunkNr:idx];

        @try {
            SBJson4Writer *writer = [[SBJson4Writer alloc] init];
            NSString *dataToSend = [writer stringWithObject:[deliveryInput dictionaryRepresentation]];

            if (writer.error != nil) {
                @throw [NSException exceptionWithName:@"Error parsing deliverPayload" reason:writer.error userInfo:nil];
            }
            if (_webSocket.readyState != SR_OPEN) {
                [_sendQueue addObject:dataToSend];
                [self connect];
            }
            else{
                [_webSocket send:dataToSend];
                NSInteger progress =(NSInteger)(((idx+1) * 100)/[chunks count]);
                [_onServerEventDelegate onMatcheeDeliveryProgress: progress forDeliveryId:deliveryId];
            }

        }
        @catch (NSException *exception) {
            NSLog(@"[%@] Exception in deliverPayload: %@", [[self class] description], [exception description]);
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

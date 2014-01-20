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

@property (nonatomic, strong) NSString* apiKey;
@property (nonatomic, strong) NSString* appID;

//WebSocket connection
@property (nonatomic, strong) SRWebSocket *webSocket;

//Delegates
@property (weak) id<SMOnServerMessageDelegate> onServerMessageDelegate;
@property (weak) id<SMOnServerEventDelegate> onServerEventDelegate;
@property (weak) id<SMOnMovementDelegate> onMovementDelegate;

//Gesture recognizer
@property (nonatomic, strong) SMInnerOuterChecker *innerOuterChecker;
@property (nonatomic, weak) UIView *attachedView;

//Transfer
@property (nonatomic, strong) NSMutableArray *sendQueue;
@property (nonatomic, strong) SMServerMessagesHandler *serverMessagesHandler;

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
    self.appID = appId;
    self.apiKey = apiKey;
}

#pragma mark - SDK View methods

- (void)attachToView:(UIView*)view withMovementDelegate:(id<SMOnMovementDelegate>)delegate criteria:(NSString*)criteria
{
    //TODO: based on criteria, use a different GestureRecognizer
    _innerOuterChecker = [[SMInnerOuterChecker alloc] initWithTarget:self action:@selector(move:)];
    _innerOuterChecker.delegate = self;
    _innerOuterChecker.movementDelegate = self;
    [view addGestureRecognizer:_innerOuterChecker];
    NSLog(@"%@ %@ panrecognizer view: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), _innerOuterChecker.view);
    _attachedView = view;
    
    self.onMovementDelegate = delegate;
}

- (void)detachFromView:(UIView*)view
{
    _innerOuterChecker.delegate = nil;
    _innerOuterChecker = nil;
    _attachedView = nil;
    self.onServerEventDelegate = nil;
    [self closeConnection];
}

- (void)move:(id)sender
{
    //Please keep this method for the time being, although movement detection is performed by InnerOuterChecker
//    CGPoint locationInWindow = [_attachedView convertPoint:[_panRecognizer locationInView:_attachedView] toView:[[[UIApplication sharedApplication] delegate] window]];
}

- (void)onMovementFromAreaStart:(NSString *)areaStart toAreaEnd:(NSString *)areaEnd movement:(NSString*)movement swipe:(NSInteger)swipe
{
    NSLog(@"%@ %@ got movement from area start %@ to end %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), areaStart, areaEnd);
    [self.onMovementDelegate detectedMovementFromAreaStart:areaStart toAreaEnd:areaEnd];
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
    
    NSString *deviceID = [SMUtilities getDeviceIdForAppId:_appID];

    NSString* apiUrl = [NSString stringWithFormat:@"%@?%@=%@?%@=%@?%@=%@?%@=%@", kSMApiEndpoint, kSMApiParamApiKey, self.apiKey, kSMApiParamAppId, self.appID, kSMApiParamOS, @"ios", kSMApiParamDeviceId, deviceID];
    
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

- (void)matchUsingCriteria:(NSString*)criteria equalityParam:(NSString*)equalityParam areaStart:(NSString *)areaStart areaEnd:(NSString *)areaEnd
{
    if (_appID == nil) {
        @throw [NSException exceptionWithName:@"No app id set in client" reason:nil userInfo:nil];
    }
    if (_apiKey == nil) {
        @throw [NSException exceptionWithName:@"No app id set in client" reason:nil userInfo:nil];
    }
    NSString *deviceID = [SMUtilities getDeviceIdForAppId:_appID];
    double latitude = [SMLocation sharedInstance].currentLocation.coordinate.latitude;
    double longitude = [SMLocation sharedInstance].currentLocation.coordinate.longitude;
    [self matchUsingCriteria:criteria latitude:latitude longitude:longitude apiKey:_apiKey appId:_appID deviceId:deviceID equalityParam:equalityParam areaStart:areaStart areaEnd:areaEnd];
}

- (void)deliverPayload:(NSString *)payload ToRecipients:(NSArray *)recipients inGroup:(NSString *)groupId
{
    [self deliverChunkedPayload:payload ToRecipients:recipients inGroup:groupId];
}

#pragma mark - SwipeMatchConnection private methods

- (void)matchUsingCriteria:(NSString *)criteria latitude:(double)latitude longitude:(double)longitude apiKey:(NSString *)apiKey appId:(NSString *)appId deviceId:(NSString *)deviceId equalityParam:(NSString *)equalityParam areaStart:(NSString *)areaStart areaEnd:(NSString *)areaEnd
{
    //TODO: check for location services enabled
    
    SMMatchInput *matchInput = [[SMMatchInput alloc] initWithCriteria:criteria latitude:latitude longitude:longitude apiKey:apiKey appId:appId deviceId:deviceId equalityParam:equalityParam areaStart:areaStart areaEnd:areaEnd];
    
    @try {
        SBJson4Writer *writer = [[SBJson4Writer alloc] init];
        NSString *dataToSend = [writer stringWithObject:[matchInput dictionaryRepresentation]];
        if (writer.error != nil) {
            @throw [NSException exceptionWithName:@"Error parsing matchInput" reason:writer.error userInfo:nil];
        }
        NSLog(@"%@ Ready to send: %@", [[self class] description], dataToSend);
        if (_webSocket.readyState != SR_OPEN) {
            [_sendQueue addObject:dataToSend];
            [self connect];
        }
        else{
            [_webSocket send:dataToSend];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"[%@] Exception in matchUsingCriteria: %@", [[self class] description], [exception description]);
    }
    
}

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

- (void)deliverChunkedPayload:(NSString *)payload ToRecipients:(NSArray *)recipients inGroup:(NSString *)groupId
{
    //Prepare the array of chunks
    NSArray *chunks = [self splitEqually:payload chunkSize:kSMMaxDeliveryChunkSize];
    NSString *deliveryId = [SMUtilities generateDeliveryUUID];
    
    //Iterate over the array and send each chunk
    [chunks enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        SMDeliveryInput *deliveryInput = [[SMDeliveryInput alloc] initWithRecipients:recipients deliveryId:deliveryId payload:[chunks objectAtIndex:idx] groupId:groupId totalChunks:[chunks count] chunkNr:idx];
        //Check:
        @try {
            SBJson4Writer *writer = [[SBJson4Writer alloc] init];
            NSString *dataToSend = [writer stringWithObject:[deliveryInput dictionaryRepresentation]];

            if (writer.error != nil) {
                @throw [NSException exceptionWithName:@"Error parsing deliverChunkedPayload" reason:writer.error userInfo:nil];
            }
            if (_webSocket.readyState != SR_OPEN) {
                [_sendQueue addObject:dataToSend];
                [self connect];
            }
            else{
                [_webSocket send:dataToSend];
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

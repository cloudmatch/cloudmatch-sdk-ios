//
//  SMSwipeMatchClient.m
//  SwipeMatchSDK
//
//  Created by Giovanni on 11/13/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

#import "SMSwipeMatchClient.h"

//Swipe parameters keys
//NSString *const kParamEqualityParam1 = @"equalityParam1";
//NSString *const kParamMessage = @"message";
//NSString *const kParamMovement = @"movement";
//NSString *const kParamPayload = @"payload";

////WebSocket notifications
//NSString* const kWebSocketOpened = @"kWebSocketOpened";
//NSString* const kWebSocketFailedToOpen = @"kWebSocketFailedToOpen";
//NSString* const kClientReceivedData = @"kClientReceivedData";


//Movement Notification
NSString * const kSMNotificationMovement = @"kNotificationMovement";

//API URL
//NSString* const kScreensAPIBaseURL = @"ws://api.swipemat.ch/open";
NSString* const kScreensAPIBaseURL = @"ws://192.168.1.14:9000/open";

//CHUNK SIZE
NSInteger const kSMMaxDeliveryChunkSize = 1024 * 10;

@interface SMSwipeMatchClient ()

//WebSocket connection
@property (nonatomic, strong) SRWebSocket *webSocket;

//Delegates
@property (weak) id<SMOnServerMessageDelegate> onServerMessageDelegate;
@property (weak) id<SMOnServerEventDelegate> onServerEventDelegate;
@property (weak) id<SMOnMovementDelegate> onMovementDelegate;

//Gesture recognizer
//@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;
@property (nonatomic, strong) SMInnerOuterChecker *innerOuterChecker;
@property (nonatomic, weak) UIView *attachedView;  //WEAK?
//@property (nonatomic, strong) NSMutableArray *matchees;
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
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleMovement:) name:kSMNotificationMovement object:nil];


    }
    return self;
}

- (void)dealloc
{
    //Detected when app is closed?
    if (self.SMClientShouldStopUpdatingLocationOnDealloc) {
        [[SMLocation sharedInstance] stopLocationServices];
    }

    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSMNotificationMovement object:nil];
}

- (void)setServerEventDelegate:(id<SMOnServerEventDelegate>)serverEventDelegate
{
    _serverMessagesHandler = [[SMServerMessagesHandler alloc] initWithServerEventDelegate:serverEventDelegate];
    self.onServerMessageDelegate = _serverMessagesHandler;
}

#pragma mark - SDK View methods

- (void)attachToView:(UIView*)view withDelegate:(id<SMOnMovementDelegate>)delegate
{
    _innerOuterChecker = [[SMInnerOuterChecker alloc] initWithTarget:self action:@selector(move:)];
//    [_innerOuterChecker setMinimumNumberOfTouches:1];
//    [_innerOuterChecker setMaximumNumberOfTouches:1];
    _innerOuterChecker.delegate = self;
    _innerOuterChecker.movementDelegate = self;
    [view addGestureRecognizer:_innerOuterChecker];
    NSLog(@"panrecognizer view: %@", _innerOuterChecker.view);
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
//    NSLog(@"locationinview: %@", NSStringFromCGPoint([_panRecognizer locationInView:_attachedView]));
//    CGPoint locationInWindow = [_attachedView convertPoint:[_panRecognizer locationInView:_attachedView] toView:[[[UIApplication sharedApplication] delegate] window]];
//    NSLog(@"locationinWindow: %@", NSStringFromCGPoint(locationInWindow));
}

- (void)onMovementFromAreaStart:(NSString *)areaStart toAreaEnd:(NSString *)areaEnd movement:(NSString*)movement swipe:(NSInteger)swipe
{
    NSLog(@"%@ got movement from area start %@ to end %@", [[self class] description], areaStart, areaEnd);
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

#pragma mark - SwipeMatchConnection

- (void)connect
{
    _webSocket.delegate = nil;
    [_webSocket close];
    
    NSURLRequest *wsRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:kScreensAPIBaseURL]];
    _webSocket = [[SRWebSocket alloc] initWithURLRequest:wsRequest];
    _webSocket.delegate = self;
    
    NSLog(@"Opening WebSocket connection");
    [_webSocket open];
}

- (void)matchUsingCriteria:(NSString *)criteria latitude:(double)latitude longitude:(double)longitude apiKey:(NSString *)apiKey appId:(NSString *)appId deviceId:(NSString *)deviceId equalityParam:(NSString *)equalityParam areaStart:(NSString *)areaStart areaEnd:(NSString *)areaEnd
{   
    //check for location services enabled
    //check for websocket connected
    
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
    NSString *deliveryId = [SMUtilities generateDeliveryUUID];
    SMDeliveryInput *deliveryInput = [[SMDeliveryInput alloc] initWithRecipients:recipients deliveryId:deliveryId payload:payload groupId:groupId totalChunks:NSNotFound chunkNr:NSNotFound];

    @try {
        SBJson4Writer *writer = [[SBJson4Writer alloc] init];
        NSString *dataToSend = [writer stringWithObject:[deliveryInput dictionaryRepresentation]];

        if (writer.error != nil) {
            @throw [NSException exceptionWithName:@"Error parsing deliveryInput" reason:writer.error userInfo:nil];
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


- (void)closeConnection
{
    [_webSocket close];
}

#pragma mark - Notification handlers

- (void)handleMovement:(NSNotification*)notification
{
    //THIS CAN BE REMOVED
    
//    [self.delegate clientReceivedValidSendSwipeForSendingData:[[notification userInfo] objectForKey:@"movement"]];
    
    NSString *movement =[[notification userInfo] objectForKey:@"movement"];
    
    SwipeType swipe = [SMInnerOuterChecker decodeSwipe:movement];
    switch (swipe) {
        case kSwipeBegin:
        //Swipe begun here, so app should choose whether swipe should be sent or not
        {
            if ([self.onMovementDelegate clientShouldSend]) {
//                [self sendPayloadDataToPeer:[self.onMovementDelegate getDataToSendForMovement:swipe]];
            }
        }
            break;
        case kSwipeIntermediate:
            //We are in a situation where app received an intermediate swipe
            break;
        case kSwipeEnd:
            //We are in a situation where user's swipe ended on this device's screen
            break;
        default:
            break;
    }
}

#pragma mark - PanGestureRecognizer Delegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //maybe use this to disable when client is transmitting?
    return YES;
}




@end

//
//  SMSwipeMatchClient.h
//  SwipeMatchSDK
//
//  Created by Giovanni on 11/13/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRWebSocket.h"
#import "SMLocation.h"
#import "NSData+Base64.h"
#import "SMInnerOuterChecker.h"
#import "SMUtilities.h"
#import "SBJson4.h"

//Constants
#import "SMJsonConstants.h"
#import "SMResponsesConstants.h"
#import "SMJsonGeneralLabels.h"

//Models
#import "SMMatchee.h"
#import "SMDeliveryInput.h"
#import "SMDeliveryResponse.h"
#import "SMDisconnectInput.h"
#import "SMDisconnectResponse.h"
#import "SMLeaveGroupInput.h"
#import "SMLeaveGroupResponse.h"
#import "SMMatcheeDelivery.h"
#import "SMMatcheeDeliveryMessage.h"
#import "SMMatcheeLeftMessage.h"
#import "SMMatchInput.h"
#import "SMMatchResponse.h"

//Handler
#import "SMServerMessagesHandler.h"

//Protocols
#import "SMOnServerEventDelegate.h"

#import "SMMatchHelper.h"

#import "SMOnServerMessageDelegate.h"

extern NSInteger const kSMMaxDeliveryChunkSize;

@interface SMSwipeMatchClient : NSObject <SRWebSocketDelegate, UIGestureRecognizerDelegate>

//Some properties for the client
@property (nonatomic, assign) BOOL SMClientShouldStopUpdatingLocationOnDealloc;

+(SMSwipeMatchClient*)sharedInstance;

//SDK view methods
- (void)attachToView:(UIView*)view withMovementDelegate:(id<SMOnMovementDelegate>)delegate criteria:(NSString*)criteria;
- (void)detachFromView:(UIView*)view;
- (void)setServerEventDelegate:(id<SMOnServerEventDelegate>)serverEventDelegate apiKey:(NSString*)apiKey appId:(NSString*)appId;

// SDK private methods
- (SMMatchHelper*)getMatcher;
- (SRWebSocket*)getWebSocket;

//SDK Methods
- (void)connect;
- (void)closeConnection;
- (void)deliverPayload:(NSString*)payload ToRecipients:(NSArray*)recipients inGroup:(NSString*)groupId;

@end

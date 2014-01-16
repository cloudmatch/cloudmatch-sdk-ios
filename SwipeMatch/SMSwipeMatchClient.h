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

//Delegates Protocols
#import "SMOnMatchEventInitiated.h"
#import "SMOnServerEventDelegate.h"
#import "SMOnServerMessageDelegate.h"

extern NSString* const kSMNotificationMovement;
extern NSString* const kScreensAPIBaseURL;
extern NSInteger const kSMMaxDeliveryChunkSize;


@protocol SMOnMovementDelegate <NSObject>
- (BOOL)clientShouldSend;
- (NSData*)getDataToSendForMovement:(NSInteger)movement;
- (void)detectedMovement:(NSString*)movement swipe:(NSInteger)swipe;
- (void)detectedMovementFromAreaStart:(NSString*)areaStart toAreaEnd:(NSString*)areaEnd;
@end


@interface SMSwipeMatchClient : NSObject <SRWebSocketDelegate, UIGestureRecognizerDelegate, SMInnerOuterCheckerDelegate>

//Some properties for the client
@property (nonatomic, assign) BOOL SMClientShouldStopUpdatingLocationOnDealloc;
@property (nonatomic, strong) NSString* apiKey;
@property (nonatomic, strong) NSString* appID;


+(SMSwipeMatchClient*)sharedInstance;

//SDK view methods
- (void)attachToView:(UIView*)view withDelegate:(id<SMOnMovementDelegate>)delegate;
- (void)detachFromView:(UIView*)view;
- (void)setServerEventDelegate:(id<SMOnServerEventDelegate>)serverEventDelegate;

//SDK Methods
- (void)connect;
- (void)closeConnection;
- (void)matchUsingCriteria:(NSString*)criteria equalityParam:(NSString*)equalityParam areaStart:(NSString*)areaStart areaEnd:(NSString*)areaEnd;
- (void)deliverPayload:(NSString*)payload ToRecipients:(NSArray*)recipients inGroup:(NSString*)groupId;
- (void)deliverChunkedPayload:(NSString*)payload ToRecipients:(NSArray*)recipients inGroup:(NSString*)groupId;

//SwipeMatch Transfer methods
//- (void)leaveGroup;
//- (void)sendMessage:(NSDictionary*)message;
//- (void)sendMatch:(NSDictionary*)message;
//- (void)sendPayloadDataToPeer:(NSData*)data;
//- (void)sendPayloadDataToBroadcast:(NSData*)data;


@end

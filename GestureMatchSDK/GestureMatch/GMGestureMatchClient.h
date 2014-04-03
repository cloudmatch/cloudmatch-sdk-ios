/*
 * Copyright 2014 Fabio Tiriticco, Fabway
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

#import <Foundation/Foundation.h>
#import "SRWebSocket.h"
#import "GMLocation.h"
#import "NSData+Base64.h"
#import "GMInnerOuterChecker.h"
#import "GMUtilities.h"
#import "SBJson4.h"

//Constants
#import "GMJsonConstants.h"
#import "GMResponsesConstants.h"
#import "GMJsonGeneralLabels.h"

// Models
#import "GMDeliveryInput.h"
#import "GMDeliveryResponse.h"
#import "GMDisconnectInput.h"
#import "GMDisconnectResponse.h"
#import "GMLeaveGroupInput.h"
#import "GMLeaveGroupResponse.h"
#import "GMMatcheeDelivery.h"
#import "GMMatcheeDeliveryMessage.h"
#import "GMMatcheeLeftMessage.h"
#import "GMMatchInput.h"
#import "GMMatchResponse.h"
#import "GMIntegerPoint.h"
#import "GMDeviceInScheme.h"
#import "GMPositionScheme.h"

//Handler
#import "GMServerMessagesHandler.h"

//Protocols
#import "GMOnServerEventDelegate.h"

#import "GMMatchHelper.h"

#import "GMOnServerMessageDelegate.h"

extern NSInteger const kGMMaxDeliveryChunkSize;

@interface GMGestureMatchClient : NSObject <SRWebSocketDelegate, UIGestureRecognizerDelegate>

//Some properties for the client
@property (nonatomic, assign) BOOL GMClientShouldStopUpdatingLocationOnDealloc;

+(GMGestureMatchClient*)sharedInstance;

//SDK view methods
- (void)attachToView:(UIView*)view withMovementDelegate:(id<GMOnMovementDelegate>)delegate criteria:(NSString*)criteria;
- (void)detachFromView:(UIView*)view;
- (void)setServerEventDelegate:(id<GMOnServerEventDelegate>)serverEventDelegate apiKey:(NSString*)apiKey appId:(NSString*)appId;

// SDK private methods
- (GMMatchHelper*)getMatcher;
- (SRWebSocket*)getWebSocket;

//SDK Methods
- (void)connect;
- (void)closeConnection;
- (void)deliverPayload:(NSString*)payload ToRecipients:(NSArray*)recipients inGroup:(NSString*)groupId;
- (void)deliverPayload:(NSString*)payload toGroup:(NSString*)groupId;

@end

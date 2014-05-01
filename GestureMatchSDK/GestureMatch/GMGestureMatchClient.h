/*
 * Copyright 2014 Fabio cloudmatch.io
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

/** The GMGestureMatchClient is the interface with the client application. It
 * should be used in its "static" form -- obtaining it through the sharedInstance method.
 *
 */
@interface GMGestureMatchClient : NSObject <SRWebSocketDelegate, UIGestureRecognizerDelegate>

//Some properties for the client
@property (nonatomic, assign) BOOL GMClientShouldStopUpdatingLocationOnDealloc;

/**-----------------------------------------------------------------------------
 * @name Accessing the shared GestureMatch Instance
 * -----------------------------------------------------------------------------
 */

/** Returns the shared `GMGestureMatchClient` instance, creating it if necessary.
 *
 * @return The shared `GMGestureMatchClient` instance.
 */
+(GMGestureMatchClient*)sharedInstance;

/**-----------------------------------------------------------------------------
 * @name Initializing or shutting down the shared GestureMatch Instance
 * -----------------------------------------------------------------------------
 */

/** Passes to the Gesture Match a specific view to attach itself to, a movement criteria and
 * an implementation of the GMOnMovementDelegate protocol.
 *
 */
- (void)attachToView:(UIView*)view withMovementDelegate:(id<GMOnMovementDelegate>)delegate criteria:(NSString*)criteria;

/** Sets the server event delegate to which the Gesture Match will notify all server events.
 * It needs to be an implementation of the GMOnServerEventDelegate protocol.
 *
 */
- (void)setServerEventDelegate:(id<GMOnServerEventDelegate>)serverEventDelegate;

/** Detaches the Gesture Match from the passed view and closes the WebSocket connection.
 *
 */
- (void)detachFromView:(UIView*)view;

/**-----------------------------------------------------------------------------
 * @name Using the shared GestureMatch Instance
 * -----------------------------------------------------------------------------
 */

/** Connects the Gesture Match instance.
 *
 */
- (void)connect;

/** Closes the WebSocket connection.
 *
 */
- (void)closeConnection;

/** Delivers payload to a list of recipient.
 *
 * @param payload The string containing the payload to deliver.
 * @param recipients An array of integer indicating the receipients to which send the payload.
 * @param groupId the id of the group to which the recipients belong.
 */
- (void)deliverPayload:(NSString*)payload ToRecipients:(NSArray*)recipients inGroup:(NSString*)groupId;

/** Delivers payload to an entire group.
 *
 * @param payload The payload to deliver.
 * @param groupId The group to which deliver the payload.
 */
- (void)deliverPayload:(NSString*)payload toGroup:(NSString*)groupId;

// SDK private methods
- (GMMatchHelper*)getMatcher;
- (SRWebSocket*)getWebSocket;


@end

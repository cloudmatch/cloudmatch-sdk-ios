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

#import <Foundation/Foundation.h>
#import "SRWebSocket.h"
#import "CMLocation.h"
#import "NSData+Base64.h"
#import "CMInnerOuterChecker.h"
#import "CMUtilities.h"
#import "SBJson4.h"

//Constants
#import "CMJsonConstants.h"
#import "CMResponsesConstants.h"
#import "CMJsonGeneralLabels.h"

// Models
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
#import "CMIntegerPoint.h"
#import "CMDeviceInScheme.h"
#import "CMPositionScheme.h"

//Handler
#import "CMServerMessagesHandler.h"

//Protocols
#import "CMOnServerEventDelegate.h"

#import "CMMatchHelper.h"

#import "CMOnServerMessageDelegate.h"

extern NSInteger const kCMMaxDeliveryChunkSize;

/** The CMCloudMatchClient is the interface with the client application. It
 * should be used in its "static" form -- obtaining it through the sharedInstance method.
 *
 */
@interface CMCloudMatchClient : NSObject <SRWebSocketDelegate, UIGestureRecognizerDelegate>

//Some properties for the client
@property (nonatomic, assign) BOOL GMClientShouldStopUpdatingLocationOnDealloc;

/**-----------------------------------------------------------------------------
 * @name Accessing the shared CloudMatch Instance
 * -----------------------------------------------------------------------------
 */

/** Returns the shared `CMCloudMatchClient` instance, creating it if necessary.
 *
 * @return The shared `CMCloudMatchClient` instance.
 */
+(CMCloudMatchClient*)sharedInstance;

/**-----------------------------------------------------------------------------
 * @name Initializing or shutting down the shared CloudMatch Instance
 * -----------------------------------------------------------------------------
 */

/** Passes to the CloudMatch a specific view to attach itself to, a movement criteria and
 * an implementation of the CMOnMovementDelegate protocol.
 *
 */
- (void)attachToView:(UIView*)view withMovementDelegate:(id<CMOnMovementDelegate>)delegate criteria:(NSString*)criteria;

/** Sets the server event delegate to which the CloudMatch will notify all server events.
 * It needs to be an implementation of the CMOnServerEventDelegate protocol.
 *
 */
- (void)setServerEventDelegate:(id<CMOnServerEventDelegate>)serverEventDelegate;

/** Detaches the CloudMatch from the passed view and closes the WebSocket connection.
 *
 */
- (void)detachFromView:(UIView*)view;

/**-----------------------------------------------------------------------------
 * @name Using the shared CloudMatch Instance
 * -----------------------------------------------------------------------------
 */

/** Connects the CloudMatch instance.
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
- (CMMatchHelper*)getMatcher;
- (SRWebSocket*)getWebSocket;


@end

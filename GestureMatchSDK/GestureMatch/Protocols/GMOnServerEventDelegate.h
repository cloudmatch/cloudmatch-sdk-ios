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

@class GMMatchee;
@class GMMatchResponse;
@class GMLeaveGroupResponse;
@class GMDisconnectResponse;
@class GMDeliveryResponse;
@class GMMatcheeDelivery;
@class GMMatcheeDeliveryMessage;
@class GMMatcheeLeftMessage;


@protocol GMOnServerEventDelegate <NSObject>
- (void)onMatchResponse:(GMMatchResponse*)response;
- (void)onLeaveGroupResponse:(GMLeaveGroupResponse*)response;
- (void)onDisconnectResponse:(GMDisconnectResponse*)response;
- (void)onDeliveryResponse:(GMDeliveryResponse*)response;
- (void)onMatcheeLeftMessage:(GMMatcheeLeftMessage*)message;
- (void)onMatcheeDelivery:(GMMatcheeDelivery*)delivery;
- (void)onMatcheeDeliveryProgress:(NSInteger)progress forDeliveryId:(NSString*)deliveryId;
- (void)onConnectionOpen;
- (void)onConnectionClosedWithWSReason:(NSString*)WSreason;
- (void)onConnectionError:(NSError*)error;
@end
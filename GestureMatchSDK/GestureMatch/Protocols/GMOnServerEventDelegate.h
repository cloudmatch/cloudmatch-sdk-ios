//
//  GMOnServerEventDelegate.h
//  GestureMatchSDK
//
//  Created by Giovanni on 12/16/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

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
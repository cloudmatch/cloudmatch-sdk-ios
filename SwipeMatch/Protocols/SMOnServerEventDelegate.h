//
//  SMOnServerEventDelegate.h
//  SwipePicture
//
//  Created by Giovanni on 12/16/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SMMatchee;
@class SMMatchResponse;
@class SMLeaveGroupResponse;
@class SMDisconnectResponse;
@class SMDeliveryResponse;
@class SMMatcheeDelivery;
@class SMMatcheeDeliveryMessage;
@class SMMatcheeLeftMessage;


@protocol SMOnServerEventDelegate <NSObject>
- (void)onMatchResponse:(SMMatchResponse*)response;
- (void)onLeaveGroupResponse:(SMLeaveGroupResponse*)response;
- (void)onDisconnectResponse:(SMDisconnectResponse*)response;
- (void)onDeliveryResponse:(SMDeliveryResponse*)response;
- (void)onMatcheeLeftMessage:(SMMatcheeLeftMessage*)message;
- (void)onMatcheeDelivery:(SMMatcheeDelivery*)delivery;
- (void)onMatcheeDeliveryProgress:(NSInteger)progress forDeliveryId:(NSString*)deliveryId;
- (void)onConnectionOpen;
- (void)onConnectionClosedWithWSReason:(NSString*)WSreason;
- (void)onConnectionError:(NSError*)error;
@end
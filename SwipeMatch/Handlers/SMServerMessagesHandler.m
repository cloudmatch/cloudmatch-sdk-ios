//
//  SMServerMessagesHandler.m
//  SwipePicture
//
//  Created by Giovanni on 12/13/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

#import "SMServerMessagesHandler.h"

//Models
#import "SMMatchee.h"
#import "SMDeliveryInput.h"
#import "SMDeliveryResponse.h"
#import "SMDisconnectInput.h"
#import "SMDisconnectResponse.h"
#import "SMLeaveGroupInput.h"
#import "SMLeaveGroupResponse.h"
#import "SMMatcheeDeliveryMessage.h"
#import "SMMatcheeLeftMessage.h"
#import "SMMatchInput.h"
#import "SMMatchResponse.h"

@implementation SMServerMessagesHandler

- (id)initWithServerEventDelegate:(id<SMOnServerEventDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.serverEventDelegate = delegate;
        self.mPartialDeliveries = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)onServerMessage:(NSString *)message
{
    NSLog(@"onMessage: %@", message);
    @try {
        if ([message isEqualToString:@"k"]) {
            // keepalive message
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary* msgJson = [NSJSONSerialization JSONObjectWithData:[message dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&jsonError];
        if ([msgJson objectForKey:KIND] == nil) {
            NSLog(@"%@ error: no Kind specified!", [[self class] description]);
        }
        if ([msgJson objectForKey:TYPE] == nil) {
            NSLog(@"%@ error: no Type specified!", [[self class] description]);
        }
        
        NSString* kind = [msgJson objectForKey:KIND];
        if ([kind isEqualToString:kSMKindResponse]) {
            NSString* inputType = [msgJson objectForKey:TYPE];
            if ([inputType isEqualToString:kSMResponseTypeMatch]){
                SMMatchResponse *matchResponse = [SMMatchResponse modelObjectWithDictionary:msgJson];
                [_serverEventDelegate onMatchResponse:matchResponse];
            }
            else if([inputType isEqualToString:kSMResponseTypeLeaveGroup]){
                SMLeaveGroupResponse *leaveGroupResponse = [SMLeaveGroupResponse modelObjectWithDictionary:msgJson];
                [_serverEventDelegate onLeaveGroupResponse:leaveGroupResponse];
            }
            else if ([inputType isEqualToString:kSMResponseTypeDisconnect]){
                SMDisconnectResponse *disconnectResponse = [SMDisconnectResponse modelObjectWithDictionary:msgJson];
                [_serverEventDelegate onDisconnectResponse:disconnectResponse];
            }
            else if([inputType isEqualToString:kSMResponseTypeDelivery]){
                SMDeliveryResponse *deliveryResponse = [SMDeliveryResponse modelObjectWithDictionary:msgJson];
                [_serverEventDelegate onDeliveryResponse:deliveryResponse];
            }
        }
        else if([kind isEqualToString:kSMKindMessage]){
            NSString* messageType = [msgJson objectForKey:TYPE];
            if ([messageType isEqualToString:kSMInputTypeDelivery]) {
                SMMatcheeDeliveryMessage *deliveryMessage = [SMMatcheeDeliveryMessage modelObjectWithDictionary:msgJson];
                if (deliveryMessage.mChunkNr == NSNotFound && deliveryMessage.mTotalChunks == NSNotFound) {
                    //this is not part of a chunked transfer
                    SMMatcheeDelivery *delivery = [[SMMatcheeDelivery alloc] initWithSenderMatchee:deliveryMessage.mSenderMatchee payload:deliveryMessage.mPayload groupId:deliveryMessage.mGroupId];
                    [_serverEventDelegate onMatcheeDelivery:delivery];
                }
                else{
                    //this is part of a chunked transfer
                    NSString *deliveryId = deliveryMessage.mDeliveryId;
                    if (deliveryId == nil) {
                        //if it's a chunked transfer and DeliveryId is nil, something went wrong
                        @throw [NSException exceptionWithName:@"SMServerMessagesHandler.deliveryId.nil" reason:@"DeliveryID cannot be nil" userInfo:nil];
                    }
                    NSMutableArray *receivedChunks;
                    if ([_mPartialDeliveries objectForKey:deliveryId] == nil) {
                        [_mPartialDeliveries setObject:[[NSMutableArray alloc] init] forKey:deliveryId];
                        
                    }
                    receivedChunks = [[_mPartialDeliveries objectForKey:deliveryId] mutableCopy];
                    
                    [receivedChunks insertObject:deliveryMessage.mPayload atIndex:deliveryMessage.mChunkNr];
                    if ([receivedChunks count] == deliveryMessage.mTotalChunks) {
                        [_serverEventDelegate onMatcheeDeliveryProgress:100];
                        
                        //1. remove object from dictionary
                        [_mPartialDeliveries removeObjectForKey:deliveryId];
                        
                        //2. send whole message to client
                        NSString *completedPayload = @"";
                        for (NSString *chunk in receivedChunks) {
                            completedPayload = [completedPayload stringByAppendingString:chunk];
                        }
                        SMMatcheeDelivery *delivery = [[SMMatcheeDelivery alloc] initWithSenderMatchee:deliveryMessage.mSenderMatchee payload:completedPayload groupId:deliveryMessage.mGroupId];
                        [_serverEventDelegate onMatcheeDelivery:delivery];
                    }
                    else{
                        //1. put object back into dictionary
                        [_mPartialDeliveries setObject:[receivedChunks copy] forKey:deliveryId];
                        
                        //2. deliver progress message to client
                        NSInteger progress = 100 * [receivedChunks count] / deliveryMessage.mTotalChunks;
                        [_serverEventDelegate onMatcheeDeliveryProgress:progress];
                    }
                }
            }
            else if ([messageType isEqualToString:kSMInputTypeMatcheeLeft]){
                SMMatcheeLeftMessage *matcheeLeftMessage = [SMMatcheeLeftMessage modelObjectWithDictionary:msgJson];
                [_serverEventDelegate onMatcheeLeftMessage:matcheeLeftMessage];
            }
        }
        else if([kind isEqualToString:kSMKindError]){
            NSLog(@"%@ server encountered error: %@ ", [[self class] description], [msgJson objectForKey:REASON]);
            //TODO: manage the error
        }
        else{
            //TODO: We should not get here
        }
            
        
    }
    @catch (NSException *exception) {
        //TODO: handle
        NSLog(@"%@ exception: %@", [[self class] description], [exception description]);
    }
    @finally {
        
    }
}

@end

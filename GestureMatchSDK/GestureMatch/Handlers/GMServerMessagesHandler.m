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

#import "GMServerMessagesHandler.h"

#import "GMJsonGeneralLabels.h"
#import "GMJsonConstants.h"
#import "GMResponsesConstants.h"

//Models
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

@implementation GMServerMessagesHandler

- (id)initWithServerEventDelegate:(id<GMOnServerEventDelegate>)delegate
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
        NSError *jsonError = nil;
        NSDictionary* msgJson = [NSJSONSerialization JSONObjectWithData:[message dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&jsonError];
        if ([msgJson objectForKey:KIND] == nil) {
            NSLog(@"%@ error: no Kind specified!", [[self class] description]);
        }
        if ([msgJson objectForKey:TYPE] == nil) {
            NSLog(@"%@ error: no Type specified!", [[self class] description]);
        }
        
        NSString* kind = [msgJson objectForKey:KIND];
        if ([kind isEqualToString:kGMKindResponse]) {
            NSString* inputType = [msgJson objectForKey:TYPE];
            if ([inputType isEqualToString:kGMResponseTypeMatch]){
                GMMatchResponse *matchResponse = [GMMatchResponse modelObjectWithDictionary:msgJson];
                [_serverEventDelegate onMatchResponse:matchResponse];
            }
            else if([inputType isEqualToString:kGMResponseTypeLeaveGroup]){
                GMLeaveGroupResponse *leaveGroupResponse = [GMLeaveGroupResponse modelObjectWithDictionary:msgJson];
                [_serverEventDelegate onLeaveGroupResponse:leaveGroupResponse];
            }
            else if ([inputType isEqualToString:kGMResponseTypeDisconnect]){
                GMDisconnectResponse *disconnectResponse = [GMDisconnectResponse modelObjectWithDictionary:msgJson];
                [_serverEventDelegate onDisconnectResponse:disconnectResponse];
            }
            else if([inputType isEqualToString:kGMResponseTypeDelivery]){
                GMDeliveryResponse *deliveryResponse = [GMDeliveryResponse modelObjectWithDictionary:msgJson];
                [_serverEventDelegate onDeliveryResponse:deliveryResponse];
            }
        }
        else if([kind isEqualToString:kGMKindMessage]){
            NSString* messageType = [msgJson objectForKey:TYPE];
            if ([messageType isEqualToString:kGMInputTypeDelivery]) {
                GMMatcheeDeliveryMessage *deliveryMessage = [GMMatcheeDeliveryMessage modelObjectWithDictionary:msgJson];
                if (deliveryMessage.mChunkNr == NSNotFound && deliveryMessage.mTotalChunks == NSNotFound) {
                    //this is not part of a chunked transfer
                    GMMatcheeDelivery *delivery = [[GMMatcheeDelivery alloc] initWithSenderMatchee:deliveryMessage.mSenderMatchee payload:deliveryMessage.mPayload groupId:deliveryMessage.mGroupId];
                    [_serverEventDelegate onMatcheeDelivery:delivery];
                }
                else{
                    //this is part of a chunked transfer
                    NSString *deliveryId = deliveryMessage.mDeliveryId;
                    if (deliveryId == nil) {
                        //if it's a chunked transfer and DeliveryId is nil, something went wrong
                        @throw [NSException exceptionWithName:@"GMServerMessagesHandler.deliveryId.nil" reason:@"DeliveryID cannot be nil" userInfo:nil];
                    }
                    NSMutableArray *receivedChunks;
                    if ([_mPartialDeliveries objectForKey:deliveryId] == nil) {
                        [_mPartialDeliveries setObject:[[NSMutableArray alloc] init] forKey:deliveryId];
                        
                    }
                    receivedChunks = [[_mPartialDeliveries objectForKey:deliveryId] mutableCopy];
                    
                    [receivedChunks insertObject:deliveryMessage.mPayload atIndex:deliveryMessage.mChunkNr];
                    if ([receivedChunks count] == deliveryMessage.mTotalChunks) {
                        [_serverEventDelegate onMatcheeDeliveryProgress:100 forDeliveryId:deliveryId];
                        
                        //1. remove object from dictionary
                        [_mPartialDeliveries removeObjectForKey:deliveryId];
                        
                        //2. send whole message to client
                        NSString *completedPayload = @"";
                        for (NSString *chunk in receivedChunks) {
                            completedPayload = [completedPayload stringByAppendingString:chunk];
                        }
                        GMMatcheeDelivery *delivery = [[GMMatcheeDelivery alloc] initWithSenderMatchee:deliveryMessage.mSenderMatchee payload:completedPayload groupId:deliveryMessage.mGroupId];
                        [_serverEventDelegate onMatcheeDelivery:delivery];
                    }
                    else{
                        //1. put object back into dictionary
                        [_mPartialDeliveries setObject:[receivedChunks copy] forKey:deliveryId];
                        
                        //2. deliver progress message to client
                        NSInteger progress = 100 * [receivedChunks count] / deliveryMessage.mTotalChunks;
                        [_serverEventDelegate onMatcheeDeliveryProgress:progress forDeliveryId:deliveryId];
                    }
                }
            }
            else if ([messageType isEqualToString:kGMInputTypeMatcheeLeft]){
                GMMatcheeLeftMessage *matcheeLeftMessage = [GMMatcheeLeftMessage modelObjectWithDictionary:msgJson];
                [_serverEventDelegate onMatcheeLeftMessage:matcheeLeftMessage];
            }
        }
        else if([kind isEqualToString:kGMKindError]){
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

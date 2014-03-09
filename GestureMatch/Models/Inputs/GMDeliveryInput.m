//
//  GMDeliveryInput.m
//  GestureMatchSDK
//
//  Created by Giovanni on 12/11/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

#import "GMDeliveryInput.h"

#import "GMJsonGeneralLabels.h"
#import "GMJsonInputLabels.h"
#import "GMJsonConstants.h"

@implementation GMDeliveryInput

- (id)initWithRecipients:(NSArray *)recipients payload:(NSString *)payload groupId:(NSString *)groupId;
{
    self = [self init];
    if (self) {
        self.mRecipients = recipients;
        self.mPayload = payload;
        self.mGroupId = groupId;
    }
    return self;
}

- (id)initWithRecipients:(NSArray *)recipients deliveryId:(NSString*)deliveryId payload:(NSString *)payload groupId:(NSString *)groupId totalChunks:(NSUInteger)totalChunks chunkNr:(NSUInteger)chunkNr
{
    self = [self init];
    if (self) {
        NSMutableArray *recs = [[NSMutableArray alloc] init];
        for (NSNumber *recipient in recipients) {
            [recs addObject:recipient];
        }
        self.mRecipients = [recs copy];
        self.mDeliveryId = deliveryId;
        self.mPayload = payload;
        self.mGroupId = groupId;
        self.mTotalChunks = totalChunks;
        self.mChunkNr = chunkNr;
    }
    return self;
}

+ (instancetype)modelObjectWithDictionary:(NSDictionary*)dict
{
    GMDeliveryInput *instance = [[GMDeliveryInput alloc] initWithDictionary:dict];
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.mChunkNr = NSNotFound;
        self.mTotalChunks = NSNotFound;
    }
    return  self;
}

- (instancetype)initWithDictionary:(NSDictionary*)dict
{
    self = [self init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.mRecipients = [dict objectForKey:INPUT_RECIPIENTS];
        self.mDeliveryId = [dict objectForKey:INPUT_DELIVERY_ID];
        self.mGroupId = [dict objectForKey:GROUP_ID];
        self.mPayload = [dict objectForKey:PAYLOAD];
        if ([dict objectForKey:INPUT_TOTAL_CHUNKS]) {
            self.mTotalChunks = [[dict objectForKey:INPUT_TOTAL_CHUNKS] integerValue];
        }
        if ([dict objectForKey:INPUT_CHUNK_NUMBER]) {
            self.mChunkNr = [[dict objectForKey:INPUT_CHUNK_NUMBER] integerValue];
        }
        
    }
    return self;
    
}

- (NSDictionary*)dictionaryRepresentation
{
    return @{
             TYPE : kGMResponseTypeDelivery,
             INPUT_RECIPIENTS: _mRecipients,
             INPUT_DELIVERY_ID : _mDeliveryId,
             GROUP_ID : _mGroupId,
             PAYLOAD : _mPayload,
             INPUT_TOTAL_CHUNKS : [NSNumber numberWithInteger:_mTotalChunks],
             INPUT_CHUNK_NUMBER : [NSNumber numberWithInteger:_mChunkNr]
             };
}

- (NSDictionary*)proxyForJson
{
    return [self dictionaryRepresentation];
}

@end

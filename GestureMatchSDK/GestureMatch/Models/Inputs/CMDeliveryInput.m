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

#import "CMDeliveryInput.h"

#import "CMJsonGeneralLabels.h"
#import "CMJsonInputLabels.h"
#import "CMJsonConstants.h"

@implementation CMDeliveryInput

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
    CMDeliveryInput *instance = [[CMDeliveryInput alloc] initWithDictionary:dict];
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
             TYPE : kCMResponseTypeDelivery,
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

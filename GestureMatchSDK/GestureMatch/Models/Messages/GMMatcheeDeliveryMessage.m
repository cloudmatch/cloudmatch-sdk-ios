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

#import "GMMatcheeDeliveryMessage.h"
#import "GMJsonGeneralLabels.h"
#import "GMJsonInputLabels.h"

@implementation GMMatcheeDeliveryMessage

+ (instancetype)modelObjectWithDictionary:(NSDictionary*)dict
{
    GMMatcheeDeliveryMessage *instance = [[GMMatcheeDeliveryMessage alloc] initWithDictionary:dict];
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.mChunkNr = NSNotFound;
        self.mTotalChunks = NSNotFound;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary*)dict
{
    self = [self init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.mSenderMatchee = [[dict objectForKey:MATCHEE_ID] integerValue];
        self.mPayload = [dict objectForKey:PAYLOAD];
        self.mGroupId = [dict objectForKey:GROUP_ID];
        self.mDeliveryId = [dict objectForKey:INPUT_DELIVERY_ID];
        if ([dict objectForKey:INPUT_TOTAL_CHUNKS]) {
            self.mTotalChunks = [[dict objectForKey:INPUT_TOTAL_CHUNKS] integerValue];
        }
        if ([dict objectForKey:INPUT_CHUNK_NUMBER]) {
            self.mChunkNr = [[dict objectForKey:INPUT_CHUNK_NUMBER] integerValue];
        }

    }
    return self;
}

@end

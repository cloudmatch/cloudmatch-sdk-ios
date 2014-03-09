//
//  GMMatcheeDeliveryMessage.m
//  GestureMatchSDK
//
//  Created by Giovanni on 12/11/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

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

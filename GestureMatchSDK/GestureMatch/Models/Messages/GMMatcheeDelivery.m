//
//  GMMatcheeDelivery.m
//  GestureMatchSDK
//
//  Created by Giovanni on 12/26/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

#import "GMMatcheeDelivery.h"

@implementation GMMatcheeDelivery

- (id)initWithSenderMatchee:(NSInteger)senderMatchee payload:(NSString*)payload groupId:(NSString*)groupId
{
    self = [super init];
    if (self) {
        self.mSenderMatchee = senderMatchee;
        self.mPayload = payload;
        self.mGroupId = groupId;
    }
    return self;
}

@end

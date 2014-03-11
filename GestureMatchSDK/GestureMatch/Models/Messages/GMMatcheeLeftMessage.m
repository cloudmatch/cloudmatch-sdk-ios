//
//  GMMatcheeLeftMessage.m
//  GestureMatchSDK
//
//  Created by Giovanni on 12/11/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

#import "GMMatcheeLeftMessage.h"
#import "GMJsonGeneralLabels.h"

@implementation GMMatcheeLeftMessage

+ (instancetype)modelObjectWithDictionary:(NSDictionary*)dict
{
    GMMatcheeLeftMessage *instance = [[GMMatcheeLeftMessage alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.mSenderMatchee = [[dict objectForKey:MATCHEE_ID] integerValue];
        self.mReason = [dict objectForKey:REASON];
        self.mGroupId = [dict objectForKey:GROUP_ID];
    }
    return self;
}

@end

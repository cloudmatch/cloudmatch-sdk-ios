//
//  GMLeaveGroupInput.m
//  GestureMatchSDK
//
//  Created by Giovanni on 12/11/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

#import "GMLeaveGroupInput.h"

@implementation GMLeaveGroupInput

- (id)initWithReason:(NSString *)reason groupId:(NSString *)groupId
{
    self = [super init];
    if (self) {
        self.mReason = reason;
        self.mGroupId = groupId;
    }
    return self;
}

+ (instancetype)modelObjectWithDictionary:(NSDictionary*)dict
{
    GMLeaveGroupInput *instance = [[GMLeaveGroupInput alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.mReason = [dict objectForKey:REASON];
        self.mGroupId = [dict objectForKey:GROUP_ID];
    }
    return self;
    
}

- (NSDictionary*)dictionaryRepresentation
{
    return @{TYPE: kGMResponseTypeLeaveGroup,
             REASON : _mReason,
             GROUP_ID : _mGroupId
             };
}

- (NSDictionary*)proxyForJson
{
    return [self dictionaryRepresentation];
}

@end

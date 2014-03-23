//
//  GMLeaveGroupResponse.m
//  GestureMatchSDK
//
//  Created by Giovanni on 12/11/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

#import "GMLeaveGroupResponse.h"
#import "GMJsonGeneralLabels.h"
#import "GMResponsesConstants.h"
#import "GMJsonConstants.h"

@implementation GMLeaveGroupResponse

+ (instancetype)modelObjectWithDictionary:(NSDictionary*)dict
{
    GMLeaveGroupResponse *instance = [[GMLeaveGroupResponse alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.mOutcome = [GMResponsesConstants getOutcomeFromString:[dict objectForKey:OUTCOME]];
        self.mLeaveGroupReason = [GMResponsesConstants getLeaveGroupReasonFromString:[dict objectForKey:REASON]];
        self.mGroupId = [dict objectForKey:GROUP_ID];
    }
    return self;
    
}

@end

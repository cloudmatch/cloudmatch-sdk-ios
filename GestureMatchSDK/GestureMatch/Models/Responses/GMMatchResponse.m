//
//  GMMatchResponse.m
//  GestureMatchSDK
//
//  Created by Giovanni on 12/11/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

#import "GMMatchResponse.h"
#import "GMJsonConstants.h"
#import "GMJsonGeneralLabels.h"
#import "GMResponsesConstants.h"
#import "GMPositionScheme.h"

static NSString* POSITION_SCHEME = @"scheme";
static NSString* MY_ID_IN_GROUP = @"myId";
static NSString* DEVICES_IN_GROUP = @"group";

@implementation GMMatchResponse

+ (instancetype)modelObjectWithDictionary:(NSDictionary*)dict
{
    GMMatchResponse *instance = [[GMMatchResponse alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.mOutcome = [GMResponsesConstants getOutcomeFromString:[dict objectForKey:OUTCOME]];
        self.mResponseReason = [GMResponsesConstants getReasonFromString:[dict objectForKey:REASON]];
        self.mMyIdInGroup = [(NSNumber*)[dict objectForKey:MY_ID_IN_GROUP] integerValue];
        self.mGroupId = [dict objectForKey:GROUP_ID];
        
        NSMutableArray *devices = [[NSMutableArray alloc] init];
        for (NSNumber *did in [dict objectForKey:DEVICES_IN_GROUP]) {
            [devices addObject:did];
        }
        self.mGroupSize = [devices count];
        self.mDevicesInGroup = [devices copy];
        self.mPositionScheme = [GMPositionScheme modelObjectWithDictionary: [dict objectForKey:POSITION_SCHEME]];
    }
    return self;
    
}

@end

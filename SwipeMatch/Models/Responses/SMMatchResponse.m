//
//  SMMatchResponse.m
//  SwipePicture
//
//  Created by Giovanni on 12/11/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

#import "SMMatchResponse.h"

static NSString* ME_IN_GROUP = @"myselfInGroup";
static NSString* OTHERS_IN_GROUP = @"othersInGroup";

@implementation SMMatchResponse

+ (instancetype)modelObjectWithDictionary:(NSDictionary*)dict
{
    SMMatchResponse *instance = [[SMMatchResponse alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.mOutcome = [dict objectForKey:OUTCOME];
        self.mResponseReason = [dict objectForKey:REASON];
        self.mMyselfInGroup = [SMMatchee modelObjectWithDictionary:[dict objectForKey:ME_IN_GROUP]];
        self.mGroupId = [dict objectForKey:GROUP_ID];
        
        NSMutableArray *others = [[NSMutableArray alloc] init];
        for (NSDictionary* matcheeDict in [dict objectForKey:OTHERS_IN_GROUP]) {
            [others addObject:[SMMatchee modelObjectWithDictionary:matcheeDict]];
        }
        self.mOthersInGroup = [others copy];
        
    }
    return self;
    
}

@end

//
//  GMMatchee.m
//  GestureMatchSDK
//
//  Created by Giovanni on 12/11/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

#import "GMMatchee.h"

static NSString* ID_IN_GROUP = @"idInGroup";
static NSString* POSITION_IN_GROUP = @"position";

@implementation GMMatchee

- (id)initWithIdInGroup:(NSInteger)idInGroup screenPosition:(NSString *)screenPosition
{
    self = [super init];
    if (self) {
        self.mScreenPosition = screenPosition;
        self.mIdInGroup = idInGroup;
    }
    return self;
}

+ (instancetype)modelObjectWithDictionary:(NSDictionary*)dict
{
    GMMatchee *instance = [[GMMatchee alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.mScreenPosition = [dict objectForKey:POSITION_IN_GROUP];
        self.mIdInGroup = [[dict objectForKey:ID_IN_GROUP] integerValue];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.mScreenPosition = kGMScreenPositionUndetermined;
    }
    return self;
}

- (NSDictionary*)proxyForJson
{
    return @{POSITION_IN_GROUP: _mScreenPosition,
             ID_IN_GROUP : [NSNumber numberWithInt:_mIdInGroup]
             };
}

@end

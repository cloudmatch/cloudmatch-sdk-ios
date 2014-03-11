//
//  GMDeviceInScheme.m
//  GestureMatchSDK
//
//  Created by Fabio Tiriticco on 8/03/2014.
//  Copyright (c) 2014 LimeBamboo. All rights reserved.
//

#import "GMDeviceInScheme.h"
#import "GMIntegerPoint.h"

static NSString* ID_IN_GROUP = @"id";
static NSString* X = @"x";
static NSString* Y = @"y";

@implementation GMDeviceInScheme

- (id)initWithIdInGroup:(NSInteger)idInGroup AndPosition:(GMIntegerPoint *)position
{
    self = [super init];
    if (self) {
        self.mIdInGroup = idInGroup;
        self.mPosition = position;
    }
    return self;
}

+ (instancetype)modelObjectWithDictionary:(NSDictionary*)dict
{
    GMDeviceInScheme *instance = [[GMDeviceInScheme alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.mIdInGroup = [[dict objectForKey:ID_IN_GROUP] integerValue];
        NSInteger x = [[dict objectForKey:X] integerValue];
        NSInteger y = [[dict objectForKey:Y] integerValue];
        self.mPosition = [[GMIntegerPoint alloc] initWithX:x AndY:y];
    }
    return self;
}

@end

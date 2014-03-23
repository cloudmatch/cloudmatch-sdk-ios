//
//  GMPositionScheme.m
//  GestureMatchSDK
//
//  Created by Fabio Tiriticco on 9/03/2014.
//  Copyright (c) 2014 LimeBamboo. All rights reserved.
//

#import "GMPositionScheme.h"
#import "GMDeviceInScheme.h"

static NSString* WIDTH = @"width";
static NSString* HEIGHT = @"height";
static NSString* DEVICES = @"devices";

@implementation GMPositionScheme

+ (instancetype)modelObjectWithDictionary:(NSDictionary*)dict
{
    GMPositionScheme *instance = [[GMPositionScheme alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.mWidth = [[dict objectForKey:WIDTH] integerValue];
        self.mHeight = [[dict objectForKey:HEIGHT] integerValue];
        
        NSMutableArray *devices = [[NSMutableArray alloc] init];
        for (NSDictionary* deviceDict in [dict objectForKey:DEVICES]) {
            [devices addObject:[GMDeviceInScheme modelObjectWithDictionary:deviceDict]];
        }
        self.mDevices = [devices copy];
    }
    return self;
}

- (GMDeviceInScheme*)getDeviceForId:(NSInteger)deviceId
{
    for (GMDeviceInScheme *dev in self.mDevices) {
        if (dev.mIdInGroup == deviceId) {
            return dev;
        }
    }
    return nil;
}

@end

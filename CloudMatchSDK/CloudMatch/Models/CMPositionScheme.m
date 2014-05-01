/*
 * Copyright 2014 cloudmatch.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "CMPositionScheme.h"
#import "CMDeviceInScheme.h"

static NSString* WIDTH = @"width";
static NSString* HEIGHT = @"height";
static NSString* DEVICES = @"devices";

@implementation CMPositionScheme

+ (instancetype)modelObjectWithDictionary:(NSDictionary*)dict
{
    CMPositionScheme *instance = [[CMPositionScheme alloc] initWithDictionary:dict];
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
            [devices addObject:[CMDeviceInScheme modelObjectWithDictionary:deviceDict]];
        }
        self.mDevices = [devices copy];
    }
    return self;
}

- (CMDeviceInScheme*)getDeviceForId:(NSInteger)deviceId
{
    for (CMDeviceInScheme *dev in self.mDevices) {
        if (dev.mIdInGroup == deviceId) {
            return dev;
        }
    }
    return nil;
}

@end

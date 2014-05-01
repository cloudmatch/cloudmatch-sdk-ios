/*
 * Copyright 2014 Fabio cloudmatch.io
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

#import "CMDeviceInScheme.h"
#import "CMIntegerPoint.h"

static NSString* ID_IN_GROUP = @"id";
static NSString* X = @"x";
static NSString* Y = @"y";

@implementation CMDeviceInScheme

- (id)initWithIdInGroup:(NSInteger)idInGroup AndPosition:(CMIntegerPoint *)position
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
    CMDeviceInScheme *instance = [[CMDeviceInScheme alloc] initWithDictionary:dict];
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
        self.mPosition = [[CMIntegerPoint alloc] initWithX:x AndY:y];
    }
    return self;
}

@end

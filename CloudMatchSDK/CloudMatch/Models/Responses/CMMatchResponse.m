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

#import "CMMatchResponse.h"
#import "CMJsonConstants.h"
#import "CMJsonGeneralLabels.h"
#import "CMResponsesConstants.h"
#import "CMPositionScheme.h"

static NSString* POSITION_SCHEME = @"scheme";
static NSString* MY_ID_IN_GROUP = @"myId";
static NSString* DEVICES_IN_GROUP = @"group";

@implementation CMMatchResponse

+ (instancetype)modelObjectWithDictionary:(NSDictionary*)dict
{
    CMMatchResponse *instance = [[CMMatchResponse alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.mOutcome = [CMResponsesConstants getOutcomeFromString:[dict objectForKey:OUTCOME]];
        self.mResponseReason = [CMResponsesConstants getReasonFromString:[dict objectForKey:REASON]];
        self.mMyIdInGroup = [(NSNumber*)[dict objectForKey:MY_ID_IN_GROUP] integerValue];
        self.mGroupId = [dict objectForKey:GROUP_ID];
        
        NSMutableArray *devices = [[NSMutableArray alloc] init];
        for (NSNumber *did in [dict objectForKey:DEVICES_IN_GROUP]) {
            [devices addObject:did];
        }
        self.mGroupSize = [devices count];
        self.mDevicesInGroup = [devices copy];
        self.mPositionScheme = [CMPositionScheme modelObjectWithDictionary: [dict objectForKey:POSITION_SCHEME]];
    }
    return self;
    
}

@end

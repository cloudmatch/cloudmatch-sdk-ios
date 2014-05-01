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

#import "CMMatcheeLeftMessage.h"
#import "CMJsonGeneralLabels.h"

@implementation CMMatcheeLeftMessage

+ (instancetype)modelObjectWithDictionary:(NSDictionary*)dict
{
    CMMatcheeLeftMessage *instance = [[CMMatcheeLeftMessage alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.mSenderMatchee = [[dict objectForKey:MATCHEE_ID] integerValue];
        self.mReason = [dict objectForKey:REASON];
        self.mGroupId = [dict objectForKey:GROUP_ID];
    }
    return self;
}

@end

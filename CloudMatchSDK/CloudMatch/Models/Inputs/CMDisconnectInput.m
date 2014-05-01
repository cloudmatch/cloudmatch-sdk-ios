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

#import "CMDisconnectInput.h"

#import "CMJsonGeneralLabels.h"
#import "CMJsonConstants.h"

@implementation CMDisconnectInput

- (id)initWithReason:(NSString *)reason
{
    self = [super init];
    if (self) {
        self.mReason = reason;
    }
    return self;
}

+ (instancetype)modelObjectWithDictionary:(NSDictionary*)dict
{
    CMDisconnectInput *instance = [[CMDisconnectInput alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.mReason = [dict objectForKey:REASON];
    }
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    return @{TYPE: kCMResponseTypeDisconnect,
             REASON : _mReason
             };
}

- (NSDictionary*)proxyForJson
{
    return [self dictionaryRepresentation];
}

@end

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

#import "CMMatchInput.h"
#import "CMCloudMatchClient.h"
#import "CMJsonConstants.h"

static NSString* MATCH_INPUT_CRITERIA = @"criteria";
static NSString* MATCH_INPUT_LATITUDE = @"latitude";
static NSString* MATCH_INPUT_LONGITUDE = @"longitude";
static NSString* MATCH_INPUT_AREASTART = @"areaStart";
static NSString* MATCH_INPUT_AREAEND = @"areaEnd";
static NSString* MATCH_INPUT_EQUALITYPARAM = @"equalityParam";

@implementation CMMatchInput

- (id)initWithCriteria:(NSString*)criteria latitude:(double)latitude longitude:(double)longitude equalityParam:(NSString *)equalityParam areaStart:(NSString*)areaStart areaEnd:(NSString*)areaEnd
{
    self = [super init];
    if (self) {
        self.mCriteria = criteria;
        self.mLatitude = latitude;
        self.mLongitude = longitude;
        self.mEqualityParam = equalityParam;
        self.mAreaStart = areaStart;
        self.mAreaEnd = areaEnd;
    }
    return self;
}

+ (instancetype)modelObjectWithDictionary:(NSDictionary*)dict
{
    CMMatchInput *instance = [[CMMatchInput alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.mCriteria = [dict objectForKey:MATCH_INPUT_CRITERIA];
        self.mLatitude = [[dict objectForKey:MATCH_INPUT_LATITUDE] doubleValue];
        self.mLongitude = [[dict objectForKey:MATCH_INPUT_LONGITUDE] doubleValue];
        self.mAreaStart = [dict objectForKey:MATCH_INPUT_AREASTART];
        self.mAreaEnd = [dict objectForKey:MATCH_INPUT_AREAEND];
        self.mEqualityParam = [dict objectForKey:MATCH_INPUT_EQUALITYPARAM];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.mCriteria = kCMCriteriaUndefined;
        self.mAreaStart = kCMAreaInvalid;
        self.mAreaEnd = kCMAreaInvalid;
    }
    return self;
}

- (NSDictionary *)dictionaryRepresentation
{
    return @{
             TYPE : kCMResponseTypeMatch,
             MATCH_INPUT_CRITERIA: _mCriteria,
             MATCH_INPUT_LATITUDE : [NSNumber numberWithDouble:_mLatitude],
             MATCH_INPUT_LONGITUDE : [NSNumber numberWithDouble:_mLongitude],
             MATCH_INPUT_AREASTART : _mAreaStart,
             MATCH_INPUT_AREAEND : _mAreaEnd,
             MATCH_INPUT_EQUALITYPARAM : _mEqualityParam
             };
}

- (NSDictionary*)proxyForJson
{
    return [self dictionaryRepresentation];
}

@end

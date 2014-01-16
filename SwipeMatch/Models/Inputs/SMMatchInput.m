//
//  SMMatchInput.m
//  SwipePicture
//
//  Created by Giovanni on 12/11/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

#import "SMMatchInput.h"


static NSString* MATCH_INPUT_CRITERIA = @"criteria";
static NSString* MATCH_INPUT_APIKEY = @"apiKey";
static NSString* MATCH_INPUT_APPID = @"appId";
static NSString* MATCH_INPUT_LATITUDE = @"latitude";
static NSString* MATCH_INPUT_LONGITUDE = @"longitude";
static NSString* MATCH_INPUT_AREASTART = @"areaStart";
static NSString* MATCH_INPUT_AREAEND = @"areaEnd";
static NSString* MATCH_INPUT_DEVICEID = @"deviceId";
static NSString* MATCH_INPUT_EQUALITYPARAM = @"equalityParam";

@implementation SMMatchInput

- (id)initWithCriteria:(NSString*)criteria latitude:(double)latitude longitude:(double)longitude apiKey:(NSString *)apiKey appId:(NSString *)appId deviceId:(NSString *)deviceId equalityParam:(NSString *)equalityParam areaStart:(NSString*)areaStart areaEnd:(NSString*)areaEnd
{
    self = [super init];
    if (self) {
        self.mCriteria = criteria;
        self.mLatitude = latitude;
        self.mLongitude = longitude;
        self.mApiKey = apiKey;
        self.mAppId = appId;
        self.mDeviceId = deviceId;
        self.mEqualityParam = equalityParam;
        self.mAreaStart = areaStart;
        self.mAreaEnd = areaEnd;
    }
    return self;
}

+ (instancetype)modelObjectWithDictionary:(NSDictionary*)dict
{
    SMMatchInput *instance = [[SMMatchInput alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.mCriteria = [dict objectForKey:MATCH_INPUT_CRITERIA];
        self.mApiKey = [dict objectForKey:MATCH_INPUT_APIKEY];
        self.mAppId = [dict objectForKey:MATCH_INPUT_APPID];
        self.mLatitude = [[dict objectForKey:MATCH_INPUT_LATITUDE] doubleValue];
        self.mLongitude = [[dict objectForKey:MATCH_INPUT_LONGITUDE] doubleValue];
        self.mAreaStart = [dict objectForKey:MATCH_INPUT_AREASTART];
        self.mAreaEnd = [dict objectForKey:MATCH_INPUT_AREAEND];
        self.mDeviceId = [dict objectForKey:MATCH_INPUT_DEVICEID];
        self.mEqualityParam = [dict objectForKey:MATCH_INPUT_EQUALITYPARAM];
    }
    return self;
    
}

- (id)init
{
    self = [super init];
    if (self) {
        self.mCriteria = kSMCriteriaUndefined;
        self.mAreaStart = kSMAreaInvalid;
        self.mAreaEnd = kSMAreaInvalid;
    }
    return self;
}

- (NSDictionary *)dictionaryRepresentation
{
    return @{
             TYPE : kSMResponseTypeMatch,
             MATCH_INPUT_CRITERIA: _mCriteria,
             MATCH_INPUT_APIKEY : _mApiKey,
             MATCH_INPUT_APPID : _mAppId,
             MATCH_INPUT_LATITUDE : [NSNumber numberWithDouble:_mLatitude],
             MATCH_INPUT_LONGITUDE : [NSNumber numberWithDouble:_mLongitude],
             MATCH_INPUT_AREASTART : _mAreaStart,
             MATCH_INPUT_AREAEND : _mAreaEnd,
             MATCH_INPUT_DEVICEID : _mDeviceId,
             MATCH_INPUT_EQUALITYPARAM : _mEqualityParam
             };
}

- (NSDictionary*)proxyForJson
{
    return [self dictionaryRepresentation];
}

@end

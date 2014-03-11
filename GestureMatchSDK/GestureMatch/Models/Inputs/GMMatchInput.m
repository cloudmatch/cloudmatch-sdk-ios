//
//  GMMatchInput.m
//  GestureMatchSDK
//
//  Created by Giovanni on 12/11/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

#import "GMMatchInput.h"
#import "GMGestureMatchClient.h"
#import "GMJsonConstants.h"

static NSString* MATCH_INPUT_CRITERIA = @"criteria";
static NSString* MATCH_INPUT_LATITUDE = @"latitude";
static NSString* MATCH_INPUT_LONGITUDE = @"longitude";
static NSString* MATCH_INPUT_AREASTART = @"areaStart";
static NSString* MATCH_INPUT_AREAEND = @"areaEnd";
static NSString* MATCH_INPUT_EQUALITYPARAM = @"equalityParam";

@implementation GMMatchInput

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
    GMMatchInput *instance = [[GMMatchInput alloc] initWithDictionary:dict];
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
        self.mCriteria = kGMCriteriaUndefined;
        self.mAreaStart = kGMAreaInvalid;
        self.mAreaEnd = kGMAreaInvalid;
    }
    return self;
}

- (NSDictionary *)dictionaryRepresentation
{
    return @{
             TYPE : kGMResponseTypeMatch,
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

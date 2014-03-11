//
//  GMMatchInput.h
//  GestureMatchSDK
//
//  Created by Giovanni on 12/11/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GMMatchInput : NSObject

@property (nonatomic, strong) NSString* mCriteria;
@property (nonatomic, assign) double mLatitude;
@property (nonatomic, assign) double mLongitude;
@property (nonatomic, strong) NSString *mEqualityParam;
@property (nonatomic, strong) NSString* mAreaStart;
@property (nonatomic, strong) NSString* mAreaEnd;

- (id)initWithCriteria:(NSString*)criteria latitude:(double)latitude longitude:(double)longitude equalityParam:(NSString*)equalityParam areaStart:(NSString*)areaStart areaEnd:(NSString*)areaEnd;
+ (instancetype)modelObjectWithDictionary:(NSDictionary*)dict;
- (instancetype)initWithDictionary:(NSDictionary*)dict;
- (NSDictionary*)dictionaryRepresentation;
- (NSDictionary*)proxyForJson;

@end

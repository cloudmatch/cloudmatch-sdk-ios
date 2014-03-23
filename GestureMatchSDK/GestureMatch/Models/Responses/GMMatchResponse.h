//
//  GMMatchResponse.h
//  GestureMatchSDK
//
//  Created by Giovanni on 12/11/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMResponsesConstants.h"

@class GMPositionScheme;

@interface GMMatchResponse : NSObject

@property (nonatomic, assign) Outcomes mOutcome;
@property (nonatomic, assign) MatchReasons mResponseReason;
@property (nonatomic, strong) NSString *mGroupId;
@property (nonatomic, assign) NSInteger mMyIdInGroup;
@property (nonatomic, assign) NSInteger mGroupSize;
@property (nonatomic, strong) NSArray *mDevicesInGroup;
@property (nonatomic, strong) GMPositionScheme* mPositionScheme;

+ (instancetype)modelObjectWithDictionary:(NSDictionary*)dict;
- (instancetype)initWithDictionary:(NSDictionary*)dict;

@end

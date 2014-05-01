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

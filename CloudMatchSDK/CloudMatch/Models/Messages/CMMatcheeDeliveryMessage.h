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

#import <Foundation/Foundation.h>

@interface CMMatcheeDeliveryMessage : NSObject

@property (nonatomic, assign) NSInteger mSenderMatchee;
@property (nonatomic, strong) NSString* mDeliveryId;
@property (nonatomic, strong) NSString* mPayload;
@property (nonatomic, strong) NSString* mGroupId;
@property (nonatomic, assign) NSInteger mTotalChunks;
@property (nonatomic, assign) NSInteger mChunkNr;

+ (instancetype)modelObjectWithDictionary:(NSDictionary*)dict;
- (instancetype)initWithDictionary:(NSDictionary*)dict;

@end

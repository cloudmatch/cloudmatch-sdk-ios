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

extern NSString* const kCMAreaInvalid;
extern NSString* const kCMAreaTop;
extern NSString* const kCMAreaRight;
extern NSString* const kCMAreaLeft;
extern NSString* const kCMAreaInner;
extern NSString* const kCMAreaBottom;

extern NSString* const kCMCriteriaUndefined;
extern NSString* const kCMCriteriaSwipe;
extern NSString* const kCMCriteriaPinch;

extern NSString* const kCMKindResponse;
extern NSString* const kCMKindMessage;
extern NSString* const kCMKindError;

extern NSString* const kCMOutcomeUnknown;
extern NSString* const kCMOutcomeFail;
extern NSString* const kCMOutcomeOk;

extern NSString* const kCMMatchReasonInvalidRequest;
extern NSString* const kCMMatchReasonUnknown;
extern NSString* const kCMMatchReasonTimeout;
extern NSString* const kCMMatchReasonError;
extern NSString* const kCMMatchReasonUncertain;

extern NSString* const kCMResponseTypeUnknown;
extern NSString* const kCMResponseTypeMatch;
extern NSString* const kCMResponseTypeLeaveGroup;
extern NSString* const kCMResponseTypeDisconnect;
extern NSString* const kCMResponseTypeDelivery;

extern NSString* const kCMInputTypeMatcheeLeft;
extern NSString* const kCMInputTypeDelivery;

extern NSString* const kCMDeliveryReasonUnknown;
extern NSString* const kCMDeliveryReasonNotPartOfAnyGroup;
extern NSString* const kCMDeliveryReasonPartiallyDelivered;
extern NSString* const kCMDeliveryReasonNotDelivered;
extern NSString* const kCMDeliveryReasonDelivered;

extern NSString* const kCMLeaveGroupResponseNotPartOfThisGroup;
extern NSString* const kCMLeaveGroupResponseNotPartOfAnyGroup;

@interface CMJsonConstants : NSObject

@end

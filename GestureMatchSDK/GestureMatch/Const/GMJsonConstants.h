/*
 * Copyright 2014 Fabio Tiriticco, Fabway
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

extern NSString* const kGMAreaInvalid;
extern NSString* const kGMAreaTop;
extern NSString* const kGMAreaRight;
extern NSString* const kGMAreaLeft;
extern NSString* const kGMAreaInner;
extern NSString* const kGMAreaBottom;

extern NSString* const kGMCriteriaUndefined;
extern NSString* const kGMCriteriaSwipe;
extern NSString* const kGMCriteriaPinch;

extern NSString* const kGMKindResponse;
extern NSString* const kGMKindMessage;
extern NSString* const kGMKindError;

extern NSString* const kGMOutcomeUnknown;
extern NSString* const kGMOutcomeFail;
extern NSString* const kGMOutcomeOk;

extern NSString* const kGMMatchReasonInvalidRequest;
extern NSString* const kGMMatchReasonUnknown;
extern NSString* const kGMMatchReasonTimeout;
extern NSString* const kGMMatchReasonError;
extern NSString* const kGMMatchReasonUncertain;

extern NSString* const kGMResponseTypeUnknown;
extern NSString* const kGMResponseTypeMatch;
extern NSString* const kGMResponseTypeLeaveGroup;
extern NSString* const kGMResponseTypeDisconnect;
extern NSString* const kGMResponseTypeDelivery;

extern NSString* const kGMInputTypeMatcheeLeft;
extern NSString* const kGMInputTypeDelivery;

extern NSString* const kGMDeliveryReasonUnknown;
extern NSString* const kGMDeliveryReasonNotPartOfAnyGroup;
extern NSString* const kGMDeliveryReasonPartiallyDelivered;
extern NSString* const kGMDeliveryReasonNotDelivered;
extern NSString* const kGMDeliveryReasonDelivered;

extern NSString* const kGMLeaveGroupResponseNotPartOfThisGroup;
extern NSString* const kGMLeaveGroupResponseNotPartOfAnyGroup;

@interface GMJsonConstants : NSObject

@end

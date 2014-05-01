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

#import "CMJsonConstants.h"

NSString* const kCMAreaInvalid = @"invalid";
NSString* const kCMAreaTop = @"top";
NSString* const kCMAreaRight = @"right";
NSString* const kCMAreaLeft = @"left";
NSString* const kCMAreaInner = @"inner";
NSString* const kCMAreaBottom = @"bottom";

NSString* const kCMCriteriaUndefined = @"undefined";
NSString* const kCMCriteriaSwipe = @"swipe";
NSString* const kCMCriteriaPinch = @"pinch";

NSString* const kCMKindResponse = @"response";
NSString* const kCMKindMessage = @"message";
NSString* const kCMKindError = @"error";

NSString* const kCMOutcomeUnknown = @"unknown";
NSString* const kCMOutcomeFail = @"fail";
NSString* const kCMOutcomeOk = @"ok";

NSString* const kCMMatchReasonInvalidRequest = @"invalidRequest";
NSString* const kCMMatchReasonUnknown = @"unknown";
NSString* const kCMMatchReasonTimeout = @"timeout";
NSString* const kCMMatchReasonError = @"error";
NSString* const kCMMatchReasonUncertain = @"uncertain";

NSString* const kCMResponseTypeUnknown = @"unknown";
NSString* const kCMResponseTypeMatch = @"match";
NSString* const kCMResponseTypeLeaveGroup = @"leaveGroup";
NSString* const kCMResponseTypeDisconnect = @"disconnect";
NSString* const kCMResponseTypeDelivery = @"delivery";

NSString* const kCMInputTypeMatcheeLeft = @"matcheeLeft";
NSString* const kCMInputTypeDelivery = @"delivery";

NSString* const kCMDeliveryReasonUnknown = @"unknown";
NSString* const kCMDeliveryReasonNotPartOfAnyGroup = @"notPartOfAnyGroup";
NSString* const kCMDeliveryReasonPartiallyDelivered = @"partiallyDelivered";
NSString* const kCMDeliveryReasonNotDelivered = @"notDelivered";
NSString* const kCMDeliveryReasonDelivered = @"delivered";

NSString* const kCMLeaveGroupResponseNotPartOfThisGroup = @"notPartOfThisGroup";
NSString* const kCMLeaveGroupResponseNotPartOfAnyGroup = @"notPartOfAnyGroup";

@implementation CMJsonConstants

@end

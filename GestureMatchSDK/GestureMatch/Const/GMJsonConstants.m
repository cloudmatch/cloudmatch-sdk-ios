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

#import "GMJsonConstants.h"

NSString* const kGMAreaInvalid = @"invalid";
NSString* const kGMAreaTop = @"top";
NSString* const kGMAreaRight = @"right";
NSString* const kGMAreaLeft = @"left";
NSString* const kGMAreaInner = @"inner";
NSString* const kGMAreaBottom = @"bottom";

NSString* const kGMCriteriaUndefined = @"undefined";
NSString* const kGMCriteriaSwipe = @"swipe";
NSString* const kGMCriteriaPinch = @"pinch";

NSString* const kGMKindResponse = @"response";
NSString* const kGMKindMessage = @"message";
NSString* const kGMKindError = @"error";

NSString* const kGMOutcomeUnknown = @"unknown";
NSString* const kGMOutcomeFail = @"fail";
NSString* const kGMOutcomeOk = @"ok";

NSString* const kGMMatchReasonInvalidRequest = @"invalidRequest";
NSString* const kGMMatchReasonUnknown = @"unknown";
NSString* const kGMMatchReasonTimeout = @"timeout";
NSString* const kGMMatchReasonError = @"error";
NSString* const kGMMatchReasonUncertain = @"uncertain";

NSString* const kGMResponseTypeUnknown = @"unknown";
NSString* const kGMResponseTypeMatch = @"match";
NSString* const kGMResponseTypeLeaveGroup = @"leaveGroup";
NSString* const kGMResponseTypeDisconnect = @"disconnect";
NSString* const kGMResponseTypeDelivery = @"delivery";

NSString* const kGMInputTypeMatcheeLeft = @"matcheeLeft";
NSString* const kGMInputTypeDelivery = @"delivery";

NSString* const kGMDeliveryReasonUnknown = @"unknown";
NSString* const kGMDeliveryReasonNotPartOfAnyGroup = @"notPartOfAnyGroup";
NSString* const kGMDeliveryReasonPartiallyDelivered = @"partiallyDelivered";
NSString* const kGMDeliveryReasonNotDelivered = @"notDelivered";
NSString* const kGMDeliveryReasonDelivered = @"delivered";

NSString* const kGMLeaveGroupResponseNotPartOfThisGroup = @"notPartOfThisGroup";
NSString* const kGMLeaveGroupResponseNotPartOfAnyGroup = @"notPartOfAnyGroup";

@implementation GMJsonConstants

@end

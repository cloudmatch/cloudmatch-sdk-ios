//
//  GMJsonConstants.m
//  GestureMatchSDK
//
//  Created by Giovanni on 12/12/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

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

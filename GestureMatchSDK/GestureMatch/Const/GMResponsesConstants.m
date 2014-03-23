//
//  GMResponsesConstants.m
//  GestureMatchSDK
//
//  Created by Giovanni on 12/11/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

#import "GMResponsesConstants.h"
#import "GMJsonConstants.h"

@implementation GMResponsesConstants

+(Outcomes)getOutcomeFromString:(NSString *)outcome
{
    Outcomes result = OutcomeUnknown;
    if ([outcome isEqualToString:kGMOutcomeFail]) {
        result = OutcomeFail;
    } else if ([outcome isEqualToString:kGMOutcomeOk]) {
        result = OutcomeOk;
    }
    return result;
}

+(MatchReasons)getReasonFromString:(NSString *)reason
{
    MatchReasons result = MatchReasonUnknown;
    if ([reason isEqualToString:kGMMatchReasonError]) {
        result = MatchReasonError;
    } else if ([reason isEqualToString:kGMMatchReasonTimeout]) {
        result = MatchReasonTimeout;
    } else if ([reason isEqualToString:kGMMatchReasonUncertain]) {
        result = MatchReasonUncertain;
    } else if ([reason isEqualToString:kGMMatchReasonInvalidRequest]) {
        result = MatchReasonInvalidRequest;
    }
    return result;
}

+(DeliveryOutcome)getDeliveryOutcomeFromString:(NSString *)deliveryOutcome
{
    DeliveryOutcome result = DeliveryOutcomeUnknown;
    if ([deliveryOutcome isEqualToString:kGMDeliveryReasonNotDelivered]) {
        result = DeliveryOutcomeNotDelivered;
    } else if ([deliveryOutcome isEqualToString:kGMDeliveryReasonDelivered]) {
        result = DeliveryOutcomeDelivered;
    } else if ([deliveryOutcome isEqualToString:kGMDeliveryReasonNotPartOfAnyGroup]) {
        result = DeliveryOutcomeNotPartOfAnyGroup;
    } else if ([deliveryOutcome isEqualToString:kGMDeliveryReasonPartiallyDelivered]) {
        result = DeliveryOutcomePartiallyDelivered;
    }
    return result;
}

+(LeaveGroupReason)getLeaveGroupReasonFromString:(NSString *)leaveGroupReason
{
    LeaveGroupReason result = LeaveGroupReasonUnknown;
    if ([leaveGroupReason isEqualToString:kGMLeaveGroupResponseNotPartOfAnyGroup]) {
        result = LeaveGroupReasonNotPartOfAnyGroup;
    } else if ([leaveGroupReason isEqualToString:kGMLeaveGroupResponseNotPartOfThisGroup]) {
        result = LeaveGroupReasonNotPartOfThisGroup;
    }
    return result;
}

@end

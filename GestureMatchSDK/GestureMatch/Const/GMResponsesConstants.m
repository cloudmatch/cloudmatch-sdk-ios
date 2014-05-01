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

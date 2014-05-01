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

#import "CMResponsesConstants.h"
#import "CMJsonConstants.h"

@implementation CMResponsesConstants

+(Outcomes)getOutcomeFromString:(NSString *)outcome
{
    Outcomes result = OutcomeUnknown;
    if ([outcome isEqualToString:kCMOutcomeFail]) {
        result = OutcomeFail;
    } else if ([outcome isEqualToString:kCMOutcomeOk]) {
        result = OutcomeOk;
    }
    return result;
}

+(MatchReasons)getReasonFromString:(NSString *)reason
{
    MatchReasons result = MatchReasonUnknown;
    if ([reason isEqualToString:kCMMatchReasonError]) {
        result = MatchReasonError;
    } else if ([reason isEqualToString:kCMMatchReasonTimeout]) {
        result = MatchReasonTimeout;
    } else if ([reason isEqualToString:kCMMatchReasonUncertain]) {
        result = MatchReasonUncertain;
    } else if ([reason isEqualToString:kCMMatchReasonInvalidRequest]) {
        result = MatchReasonInvalidRequest;
    }
    return result;
}

+(DeliveryOutcome)getDeliveryOutcomeFromString:(NSString *)deliveryOutcome
{
    DeliveryOutcome result = DeliveryOutcomeUnknown;
    if ([deliveryOutcome isEqualToString:kCMDeliveryReasonNotDelivered]) {
        result = DeliveryOutcomeNotDelivered;
    } else if ([deliveryOutcome isEqualToString:kCMDeliveryReasonDelivered]) {
        result = DeliveryOutcomeDelivered;
    } else if ([deliveryOutcome isEqualToString:kCMDeliveryReasonNotPartOfAnyGroup]) {
        result = DeliveryOutcomeNotPartOfAnyGroup;
    } else if ([deliveryOutcome isEqualToString:kCMDeliveryReasonPartiallyDelivered]) {
        result = DeliveryOutcomePartiallyDelivered;
    }
    return result;
}

+(LeaveGroupReason)getLeaveGroupReasonFromString:(NSString *)leaveGroupReason
{
    LeaveGroupReason result = LeaveGroupReasonUnknown;
    if ([leaveGroupReason isEqualToString:kCMLeaveGroupResponseNotPartOfAnyGroup]) {
        result = LeaveGroupReasonNotPartOfAnyGroup;
    } else if ([leaveGroupReason isEqualToString:kCMLeaveGroupResponseNotPartOfThisGroup]) {
        result = LeaveGroupReasonNotPartOfThisGroup;
    }
    return result;
}

@end

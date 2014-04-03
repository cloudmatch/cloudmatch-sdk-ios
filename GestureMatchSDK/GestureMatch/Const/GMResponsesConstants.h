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

//The possible outcomes
typedef enum {
    OutcomeUnknown,
    OutcomeOk,
    OutcomeFail
} Outcomes;

//The possible delivery reasons
typedef enum {
    DeliveryOutcomeUnknown,
    DeliveryOutcomeNotPartOfAnyGroup,
    DeliveryOutcomePartiallyDelivered,
    DeliveryOutcomeNotDelivered,
    DeliveryOutcomeDelivered
} DeliveryOutcome;

typedef enum {
    MatchReasonUnknown,
    MatchReasonError,
    MatchReasonTimeout,
    MatchReasonUncertain,
    MatchReasonInvalidRequest
} MatchReasons;

typedef enum {
    LeaveGroupReasonUnknown,
    LeaveGroupReasonNotPartOfAnyGroup,
    LeaveGroupReasonNotPartOfThisGroup
} LeaveGroupReason;

@interface GMResponsesConstants : NSObject

+(Outcomes)getOutcomeFromString:(NSString*)outcome;
+(MatchReasons)getReasonFromString:(NSString*)reason;
+(DeliveryOutcome)getDeliveryOutcomeFromString:(NSString*)deliveryOutcome;
+(LeaveGroupReason)getLeaveGroupReasonFromString:(NSString*)leaveGroupReason;

@end

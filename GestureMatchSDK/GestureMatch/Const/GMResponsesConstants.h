//
//  GMResponsesConstants.h
//  GestureMatchSDK
//
//  Created by Giovanni on 12/11/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

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

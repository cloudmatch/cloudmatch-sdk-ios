//
//  GMResponsesConstants.h
//  GestureMatchSDK
//
//  Created by Giovanni on 12/11/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

#import <Foundation/Foundation.h>

//The possible outcomes
extern NSString* const kGMOutcomeUnknown;
extern NSString* const kGMOutcomeFail;
extern NSString* const kGMOutcomeOk;

//The possible delivery reasons
extern NSString* const kGMDeliveryReasonUnknown;
extern NSString* const kGMDeliveryReasonNotPartOfAnyGroup;
extern NSString* const kGMDeliveryReasonPartiallyDelivered;
extern NSString* const kGMDeliveryReasonNotDelivered;
extern NSString* const kGMDeliveryReasonDelivered;

@interface GMResponsesConstants : NSObject

@end

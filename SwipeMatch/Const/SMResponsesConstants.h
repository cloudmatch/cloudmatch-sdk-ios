//
//  SMResponsesConstants.h
//  SwipePicture
//
//  Created by Giovanni on 12/11/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

#import <Foundation/Foundation.h>

//The possible outcomes
extern NSString* const kSMOutcomeUnknown;
extern NSString* const kSMOutcomeFail;
extern NSString* const kSMOutcomeOk;

//The possible delivery reasons
extern NSString* const kSMDeliveryReasonUnknown;
extern NSString* const kSMDeliveryReasonNotPartOfAnyGroup;
extern NSString* const kSMDeliveryReasonPartiallyDelivered;
extern NSString* const kSMDeliveryReasonNotDelivered;
extern NSString* const kSMDeliveryReasonDelivered;

//The possible screen positions
//unknown, undetermined, left, right, top, bottom, topleft, topright, bottomleft, bottomright
extern NSString* const kSMScreenPositionUnknown;
extern NSString* const kSMScreenPositionUndetermined;
extern NSString* const kSMScreenPositionLeft;
extern NSString* const kSMScreenPositionRight;
extern NSString* const kSMScreenPositionTop;
extern NSString* const kSMScreenPositionBottom;
extern NSString* const kSMScreenPositionTopLeft;
extern NSString* const kSMScreenPositionTopRight;
extern NSString* const kSMScreenPositionBottomLeft;
extern NSString* const kSMScreenPositionBottomRight;

@interface SMResponsesConstants : NSObject

@end

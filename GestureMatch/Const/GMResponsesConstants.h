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

//The possible screen positions
//unknown, undetermined, left, right, top, bottom, topleft, topright, bottomleft, bottomright
extern NSString* const kGMScreenPositionUnknown;
extern NSString* const kGMScreenPositionUndetermined;
extern NSString* const kGMScreenPositionLeft;
extern NSString* const kGMScreenPositionRight;
extern NSString* const kGMScreenPositionTop;
extern NSString* const kGMScreenPositionBottom;
extern NSString* const kGMScreenPositionTopLeft;
extern NSString* const kGMScreenPositionTopRight;
extern NSString* const kGMScreenPositionBottomLeft;
extern NSString* const kGMScreenPositionBottomRight;

@interface GMResponsesConstants : NSObject

@end

//
//  GMJsonConstants.h
//  GestureMatchSDK
//
//  Created by Giovanni on 12/12/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* const kGMAreaInvalid;
extern NSString* const kGMAreaTop;
extern NSString* const kGMAreaRight;
extern NSString* const kGMAreaLeft;
extern NSString* const kGMAreaInner;
extern NSString* const kGMAreaBottom;

extern NSString* const kGMCriteriaUndefined;
extern NSString* const kGMCriteriaSwipe;
extern NSString* const kGMCriteriaPinch;

extern NSString* const kGMKindResponse;
extern NSString* const kGMKindMessage;
extern NSString* const kGMKindError;

extern NSString* const kGMOutcomeUnknown;
extern NSString* const kGMOutcomeFail;
extern NSString* const kGMOutcomeOk;

extern NSString* const kGMMatchReasonInvalidRequest;
extern NSString* const kGMMatchReasonUnknown;
extern NSString* const kGMMatchReasonTimeout;
extern NSString* const kGMMatchReasonError;
extern NSString* const kGMMatchReasonUncertain;

extern NSString* const kGMResponseTypeUnknown;
extern NSString* const kGMResponseTypeMatch;
extern NSString* const kGMResponseTypeLeaveGroup;
extern NSString* const kGMResponseTypeDisconnect;
extern NSString* const kGMResponseTypeDelivery;

extern NSString* const kGMInputTypeMatcheeLeft;
extern NSString* const kGMInputTypeDelivery;

extern NSString* const kGMDeliveryReasonUnknown;
extern NSString* const kGMDeliveryReasonNotPartOfAnyGroup;
extern NSString* const kGMDeliveryReasonPartiallyDelivered;
extern NSString* const kGMDeliveryReasonNotDelivered;
extern NSString* const kGMDeliveryReasonDelivered;

extern NSString* const kGMLeaveGroupResponseNotPartOfThisGroup;
extern NSString* const kGMLeaveGroupResponseNotPartOfAnyGroup;

@interface GMJsonConstants : NSObject

@end

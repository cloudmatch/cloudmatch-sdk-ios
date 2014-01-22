//
//  SMJsonConstants.h
//  SwipePicture
//
//  Created by Giovanni on 12/12/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* const kSMAreaInvalid;
extern NSString* const kSMAreaTop;
extern NSString* const kSMAreaRight;
extern NSString* const kSMAreaLeft;
extern NSString* const kSMAreaInner;
extern NSString* const kSMAreaBottom;

extern NSString* const kSMCriteriaUndefined;
extern NSString* const kSMCriteriaPosition;
extern NSString* const kSMCriteriaPresence;
extern NSString* const kSMCriteriaPinch;

extern NSString* const kSMKindResponse;
extern NSString* const kSMKindMessage;
extern NSString* const kSMKindError;

extern NSString* const kSMResponseTypeUnknown;
extern NSString* const kSMResponseTypeMatch;
extern NSString* const kSMResponseTypeLeaveGroup;
extern NSString* const kSMResponseTypeDisconnect;
extern NSString* const kSMResponseTypeDelivery;

extern NSString* const kSMInputTypeMatcheeLeft;
extern NSString* const kSMInputTypeDelivery;

@interface SMJsonConstants : NSObject

@end

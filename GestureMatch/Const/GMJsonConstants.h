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

extern NSString* const kGMResponseTypeUnknown;
extern NSString* const kGMResponseTypeMatch;
extern NSString* const kGMResponseTypeLeaveGroup;
extern NSString* const kGMResponseTypeDisconnect;
extern NSString* const kGMResponseTypeDelivery;

extern NSString* const kGMInputTypeMatcheeLeft;
extern NSString* const kGMInputTypeDelivery;

@interface GMJsonConstants : NSObject

@end

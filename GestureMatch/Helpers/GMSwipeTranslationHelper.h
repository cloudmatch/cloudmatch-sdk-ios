//
//  GMSwipeTranslationUtils.h
//  GestureMatchSDK
//
//  Created by Fabio Tiriticco on 22/01/2014.
//  Copyright (c) 2014 LimeBamboo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMSwipeConstants.h"
#import "GMJsonConstants.h"

@interface GMSwipeTranslationHelper : NSObject

+ (Movement)decodeMovement:(NSString*)movementStr;
+ (SwipeType)decodeSwipe:(Movement)movement;
+ (NSString*)convertViewAreaToString:(ViewArea)viewArea;

@end

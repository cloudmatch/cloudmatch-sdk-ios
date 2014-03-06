//
//  GMSwipeConstants.h
//  GestureMatchSDK
//
//  Created by Fabio Tiriticco on 22/01/2014.
//  Copyright (c) 2014 LimeBamboo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSInteger, ViewArea) {
    kViewAreaTop = 0,
    kViewAreaBottom = 1,
    kViewAreaLeft = 2,
    kViewAreaRight = 3,
    kViewAreaInner = 4,
    kViewAreaInvalid = 5
};

typedef NS_ENUM(NSInteger, Movement){
    kMovementInvalid,
    kMovementInnerTop,
    kMovementInnerLeft,
    kMovementInnerRight,
    kMovementInnerBottom,
    kMovementTopInner,
    kMovementTopLeft,
    kMovementTopRight,
    kMovementTopBottom,
    kMovementBottomInner,
    kMovementBottomLeft,
    kMovementBottomRight,
    kMovementBottomTop,
    kMovementLeftInner,
    kMovementLeftRight,
    kMovementLeftBottom,
    kMovementLeftTop,
    kMovementRightTop,
    kMovementRightInner,
    kMovementRightLeft,
    kMovementRightBottom
};

typedef NS_ENUM(NSInteger, SwipeType) {
    kSwipeIncoming,
    kSwipeOutgoing,
    kSwipeTransitive,
    kSwipeNotSupported
};

@interface GMSwipeConstants : NSObject

@end

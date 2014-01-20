//
//  InnerOuterChecker.h
//  DrawLinesInnerOuter
//
//  Created by Fabio Tiriticco on 30/10/12.
//  Copyright (c) 2012 Fabio Tiriticco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>
#import "SMJsonConstants.h"

typedef NS_ENUM (NSInteger,ViewArea) {
    kViewAreaTop = 0,
    kViewAreaBottom = 1,
    kViewAreaLeft = 2,
    kViewAreaRight = 3,
    kViewAreaInner = 4,
    kViewAreaInvalid = 5
} ;

typedef NS_ENUM(NSInteger, Movement) {
    kMovementNonInitialized = 0,
    kMovementOuterToInner = 1,
    kMovementInnerToOuter = 2,
    kMovementOuterToOuter = 3,
    kMovementInvalidSameArea = 4,
    kMovementInvalidAreaTouched = 5
};

typedef NS_ENUM(NSInteger, SwipeType) {
    kSwipeBegin = 0,
    kSwipeEnd = 1,
    kSwipeIntermediate = 2,
    kSwipeNotSupported = 3
};

@protocol SMInnerOuterCheckerDelegate <NSObject>

- (void)onMovementFromAreaStart:(NSString *)areaStart toAreaEnd:(NSString *)areaEnd movement:(NSString*)movement swipe:(NSInteger)swipe;
@end

@interface SMInnerOuterChecker : UIPanGestureRecognizer {
    ViewArea initialAreaTouched;
    ViewArea finalAreaTouched;
}


//the state property is necessary for subclassing UIGestureRecognizer
@property(nonatomic,readwrite) UIGestureRecognizerState state;

@property(nonatomic, weak) id<SMInnerOuterCheckerDelegate> movementDelegate;


// "public" stuff
- (BOOL)touchStartedInOuterArea:(CGPoint)initialPoint forView:(UIView*)view;
+ (BOOL)isAnOuterArea:(ViewArea)area;
+ (Movement)decodeMovement:(NSString*)movement;
+ (SwipeType)decodeSwipe:(NSString*)movement;
+ (NSString*)convertViewAreaToString:(NSInteger)viewArea;


@end

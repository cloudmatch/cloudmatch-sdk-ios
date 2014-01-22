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
#import "SMOnMovementDelegate.h"

@interface SMInnerOuterChecker : UIPanGestureRecognizer {
    ViewArea initialAreaTouched;
    ViewArea finalAreaTouched;
}


//the state property is necessary for subclassing UIGestureRecognizer
@property(nonatomic,readwrite) UIGestureRecognizerState state;

//@property(nonatomic, weak) id<SMInnerOuterCheckerDelegate> movementDelegate;
@property(nonatomic, weak) id<SMOnMovementDelegate> movementDelegate;


// "public" stuff
- (BOOL)touchStartedInOuterArea:(CGPoint)initialPoint forView:(UIView*)view;
+ (BOOL)isAnOuterArea:(ViewArea)area;
+ (Movement)decodeMovement:(NSString*)movement;
+ (SwipeType)decodeSwipe:(NSString*)movement;
+ (NSString*)convertViewAreaToString:(NSInteger)viewArea;


@end

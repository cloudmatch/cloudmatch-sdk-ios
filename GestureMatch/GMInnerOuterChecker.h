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
#import "GMJsonConstants.h"
#import "GMOnMovementDelegate.h"
#import "GMSwipeTranslationHelper.h"
#import "GMMatchInput.h"

@interface GMInnerOuterChecker : UIPanGestureRecognizer {
    ViewArea initialAreaTouched;
    ViewArea finalAreaTouched;
}

//the state property is necessary for subclassing UIGestureRecognizer
@property(nonatomic,readwrite) UIGestureRecognizerState state;

//@property(nonatomic, weak) id<GMInnerOuterCheckerDelegate> movementDelegate;
@property(nonatomic, weak) id<GMOnMovementDelegate> movementDelegate;

@property (nonatomic, weak) UIView *attachedView;

//Init method with criteria
- (id)initWithTarget:(id)target action:(SEL)action criteria:(NSString*)criteria;
- (id)initWithCriteria:(NSString*)criteria;

// "public" stuff
- (BOOL)touchStartedInOuterArea:(CGPoint)initialPoint forView:(UIView*)view;
+ (BOOL)isAnOuterArea:(ViewArea)area;

@end

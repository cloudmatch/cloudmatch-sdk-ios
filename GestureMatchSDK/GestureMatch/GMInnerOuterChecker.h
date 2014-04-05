/*
 * Copyright 2014 Fabio Tiriticco, Fabway
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>
#import "GMJsonConstants.h"
#import "GMOnMovementDelegate.h"
#import "GMSwipeTranslationHelper.h"
#import "GMMatchInput.h"

@interface GMInnerOuterChecker : UIPanGestureRecognizer {
    CGPoint startPoint;
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

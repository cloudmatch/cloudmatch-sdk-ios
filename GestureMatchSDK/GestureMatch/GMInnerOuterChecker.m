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

#import "GMInnerOuterChecker.h"
#import "GMGestureMatchClient.h"

@interface GMInnerOuterChecker ()

@property (nonatomic, strong) NSString* mCriteria;

//Checks if the coordinate is within the swipe detection area
-(BOOL)xIsInInnerSection:(NSInteger)x forView:(UIView*)view;

@end

@implementation GMInnerOuterChecker

//The border around the screen (in points) to detect when the user tapped on a border
NSInteger const kSIDE_AREA_WIDTH = 20;

#pragma mark - Init Methods

- (id)init
{
    [self doesNotRecognizeSelector:_cmd];
    //Init method should not be called
    return self;
}

- (id)initWithTarget:(id)target action:(SEL)action
{
    [self doesNotRecognizeSelector:_cmd];
    //initWithTarget should not be called without specifying a criteria
    return self;
}

- (id)initWithTarget:(id)target action:(SEL)action criteria:(NSString*)criteria
{
    self = [super initWithTarget:target action:action];
    if (self) {
        self.mCriteria = criteria;
    }
    return self;
}

- (id)initWithCriteria:(NSString*)criteria
{
    self = [super initWithTarget:nil action:nil];
    if (self) {
        self.mCriteria = criteria;
    }
    return self;
}

#pragma mark - Touches delegate

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    NSUInteger numTaps = [touch tapCount];
    if (numTaps >=2) {
        [self ignoreTouch:touch forEvent:event];
    }
    
#if DEBUG
    NSLog(@"[IOC] touches began at point: %@", NSStringFromCGPoint(touchPoint));
#endif
    
    [self touchStarted:touchPoint inView:self.view];
    
    //If the gesture recognizer is interpreting a continuous gesture, it should set its state to UIGestureRecognizerStateBegan upon receiving this message. If at any point in its handling of the touch objects the gesture recognizer determines that the multi-touch event sequence is not its gesture, it should set it state to UIGestureRecognizerStateCancelled.
    self.state = UIGestureRecognizerStateBegan;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    UITouch *mytouch=[touches anyObject];
    CGPoint np = [mytouch locationInView:self.view];
    NSString *movementStr = [self touchEnded:np inView:self.view];
    
#if DEBUG
    NSLog(@"[IOC] touches ended at point: %@", NSStringFromCGPoint(np));
    NSLog(@"[IOC]Movement: %@", movementStr);
#endif

    //Check if valid touch START
    int first = [[movementStr substringToIndex:1] intValue];
    int second = [[movementStr substringFromIndex:1] intValue];
    
    if (first == second) {
#if DEBUG
        NSLog(@"[IOC]bad, same two areas");
#endif
    }
    
    else if (first == kViewAreaInvalid ||
             second == kViewAreaInvalid) {
#if DEBUG
        NSLog(@"[IOC]bad, at least one invalid area detected");
#endif
    }
    else {
        // if the swipe is valid (after request to the delegate, implemented by SDK client)
        BOOL swipeValid = [self.movementDelegate isSwipeValid];
        
        if (swipeValid) {
            // notify SDK client of movement
            Movement move = [GMSwipeTranslationHelper decodeMovement:movementStr];
            SwipeType swipeType = [GMSwipeTranslationHelper decodeSwipe:move];
            
            [self.movementDelegate onMovementDetection:move swipeType:swipeType];
            
            NSString *eqParam = [self.movementDelegate getEqualityParam];
            if (eqParam == (id)[NSNull null] || eqParam.length == 0) {
                eqParam = @"";
            }
            NSString *start = [GMSwipeTranslationHelper convertViewAreaToString:first];
            NSString *end = [GMSwipeTranslationHelper convertViewAreaToString:second];
            
            // send match request
            [[[GMGestureMatchClient sharedInstance] getMatcher] matchUsingCriteria:_mCriteria equalityParam:eqParam areaStart:start areaEnd:end];
        }
        
    }
    // Check if valid touch END
    
    // If the gesture recognizer is interpreting a continuous gesture, it should set its state to UIGestureRecognizerStateEnded upon receiving this message. If it is interpreting a discrete gesture, it should set its state to UIGestureRecognizerStateRecognized. If at any point in its handling of the touch objects the gesture recognizer determines that the multi-touch event sequence is not its gesture, it should set it state to UIGestureRecognizerStateCancelled.
    
    self.state = UIGestureRecognizerStateEnded;
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    //If the gesture recognizer is interpreting a continuous gesture, it should set its state to UIGestureRecognizerStateChanged upon receiving this message. If at any point in its handling of the touch objects the gesture recognizer determines that the multi-touch event sequence is not its gesture, it should set it state to UIGestureRecognizerStateCancelled .
    
    self.state = UIGestureRecognizerStateChanged;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
#if DEBUG
    NSLog(@"[IOC] touches canceled");
#endif
    
    //Upon receiving this message, the gesture recognizer for a continuous gesture should set its state to UIGestureRecognizerStateCancelled; a gesture recognizer for a discrete gesture should set its state to UIGestureRecognizerStateFailed.
    self.state = UIGestureRecognizerStateCancelled;
}

# pragma mark - touch interface

-(ViewArea)touchStarted:(CGPoint)initialPoint inView:(UIView*)view
{
#if DEBUG
    NSLog(@"[IOC]touch started");
#endif
    initialAreaTouched = [self getBelongingArea:initialPoint forView:view];
    return initialAreaTouched;
}

-(NSString*)touchEnded:(CGPoint)finalPoint inView:(UIView*)view
{
#if DEBUG
    NSLog(@"[IOC]touch ended");
#endif
    finalAreaTouched = [self getBelongingArea:finalPoint forView:view];
    NSString *areas = [NSString stringWithFormat:@"%ld%ld", initialAreaTouched, finalAreaTouched];
    return areas;
}

# pragma mark - belonging areas stuff

-(ViewArea)getBelongingArea:(CGPoint)point forView:(UIView*)view
{
    NSInteger x = point.x;
    NSInteger y = point.y;
    
    // this method assumes that origin of the view is always (0, 0)
    ViewArea result = kViewAreaInvalid;
    if (y < kSIDE_AREA_WIDTH) {
        if ([self xIsInInnerSection:x forView:view]) {
            // top area
            result = kViewAreaTop;
        }
    } else if (y > (view.frame.size.height - kSIDE_AREA_WIDTH)) {
        if ([self xIsInInnerSection:x forView:view]) {
            // top area
            result = kViewAreaBottom;
        }
    } else {
        if ([self xIsInInnerSection:x forView:view]) {
            // inner area
            result = kViewAreaInner;
        } else {
            if (x < kSIDE_AREA_WIDTH) {
                // left area
                result = kViewAreaLeft;
            } else {
                // right area
                result = kViewAreaRight;
            }
        }
    }
    return result;
}

+ (BOOL)isAnOuterArea:(ViewArea)area
{
    return area == kViewAreaLeft || area == kViewAreaRight ||
    area == kViewAreaBottom || area == kViewAreaTop;
}

-(BOOL)xIsInInnerSection:(NSInteger)x forView:(UIView*)view
{
    return x > kSIDE_AREA_WIDTH &&
    x < (view.frame.size.width - kSIDE_AREA_WIDTH);
}

- (BOOL)touchStartedInOuterArea:(CGPoint)initialPoint forView:(UIView*)view
{
    ViewArea pointArea = [self getBelongingArea:initialPoint forView:view];
    return [GMInnerOuterChecker isAnOuterArea:pointArea];
}

#pragma mark - UIPanGestureRecognizer subclass

- (void)reset
{
    [super reset];
    
    initialAreaTouched = 0;
    finalAreaTouched = 0;
}

@end

//
//  InnerOuterChecker.m
//  DrawLinesInnerOuter
//
//  Created by Fabio Tiriticco on 30/10/12.
//  Copyright (c) 2012 Fabio Tiriticco. All rights reserved.
//

#import "SMInnerOuterChecker.h"

@interface SMInnerOuterChecker ()

// "private" stuff
-(BOOL)xIsInInnerSection:(NSInteger)x forView:(UIView*)view;

@end

@implementation SMInnerOuterChecker

//The border around the screen (in points) to detect when the user tapped on a border
NSInteger const kInterval = 20;

#pragma mark - Touches delegate

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    CGPoint touchPoint = [touch locationInView:touch.view];
    
    NSLog(@"[IOC] touches began at point: %@", NSStringFromCGPoint(touchPoint));
    
    [self touchStarted:touchPoint inView:self.view];
    
    //If the gesture recognizer is interpreting a continuous gesture, it should set its state to UIGestureRecognizerStateBegan upon receiving this message. If at any point in its handling of the touch objects the gesture recognizer determines that the multi-touch event sequence is not its gesture, it should set it state to UIGestureRecognizerStateCancelled.
    self.state = UIGestureRecognizerStateBegan;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *mytouch=[touches anyObject];
    CGPoint np = [mytouch locationInView:mytouch.view];
    NSLog(@"[IOC] touches ended at point: %@", NSStringFromCGPoint(np));
    
    NSString *movementStr = [self touchEnded:np inView:self.view];
    
    NSLog(@"[IOC]Movement: %@", movementStr);
    //Check if valid touch START
    int first = [[movementStr substringToIndex:1] intValue];
    int second = [[movementStr substringFromIndex:1] intValue];
    
    if (first == second) {
        NSLog(@"[IOC]bad, same two areas");
    }
    
    else if (first == kViewAreaInvalid ||
             second == kViewAreaInvalid) {
        NSLog(@"[IOC]bad, at least one invalid area detected");
    }
    else {
        // if the swipe is valid
        BOOL swipeValid = [self.movementDelegate isSwipeValid];
        
        if (swipeValid) {
            // notify client of movement
            Movement move = [SMSwipeTranslationHelper decodeMovement:movementStr];
            SwipeType swipeType = [SMSwipeTranslationHelper decodeSwipe:move];
            
            [self.movementDelegate onMovementDetection:move swipeType:swipeType];
            
            // TODO: prepare match request input and send it
            NSString *eqParam = [self.movementDelegate getEqualityParam];
            NSString *start = [SMSwipeTranslationHelper convertViewAreaToString:first];
            NSString *end = [SMSwipeTranslationHelper convertViewAreaToString:second];
            
        }
        // [self.movementDelegate onMovementFromAreaStart:start toAreaEnd:end movement:[SMInnerOuterChecker decodeMovement:movement] swipe:[SMInnerOuterChecker decodeSwipe:movement]];
    }
    // Check if valid touch END
    
    // If the gesture recognizer is interpreting a continuous gesture, it should set its state to UIGestureRecognizerStateEnded upon receiving this message. If it is interpreting a discrete gesture, it should set its state to UIGestureRecognizerStateRecognized. If at any point in its handling of the touch objects the gesture recognizer determines that the multi-touch event sequence is not its gesture, it should set it state to UIGestureRecognizerStateCancelled.
    
    self.state = UIGestureRecognizerStateEnded;
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //    NSLog(@"[IOC] touches moved");
    
    //If the gesture recognizer is interpreting a continuous gesture, it should set its state to UIGestureRecognizerStateChanged upon receiving this message. If at any point in its handling of the touch objects the gesture recognizer determines that the multi-touch event sequence is not its gesture, it should set it state to UIGestureRecognizerStateCancelled .
    
    self.state = UIGestureRecognizerStateChanged;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"[IOC] touches canceled");
    
    //Upon receiving this message, the gesture recognizer for a continuous gesture should set its state to UIGestureRecognizerStateCancelled; a gesture recognizer for a discrete gesture should set its state to UIGestureRecognizerStateFailed.
    self.state = UIGestureRecognizerStateCancelled;
}

# pragma mark - touch interface

-(ViewArea)touchStarted:(CGPoint)initialPoint inView:(UIView*)view
{
    NSLog(@"[IOC]touch started");
    initialAreaTouched = [self getBelongingArea:initialPoint forView:view];
    return initialAreaTouched;
}

-(NSString*)touchEnded:(CGPoint)finalPoint inView:(UIView*)view
{
    NSLog(@"[IOC]touch ended");
    finalAreaTouched = [self getBelongingArea:finalPoint forView:view];
    NSString *areas = [NSString stringWithFormat:@"%d%d", initialAreaTouched, finalAreaTouched];
    return areas;
}

# pragma mark - belonging areas stuff

-(ViewArea)getBelongingArea:(CGPoint)point forView:(UIView*)view
{
    NSInteger x = point.x;
    NSInteger y = point.y;
    
    // this method assumes that origin of the view is always (0, 0)
    ViewArea result = kViewAreaInvalid;
    if (y < kInterval) {
        if ([self xIsInInnerSection:x forView:view]) {
            // top area
            result = kViewAreaTop;
        }
    } else if (y > (view.frame.size.height - kInterval)) {
        if ([self xIsInInnerSection:x forView:view]) {
            // top area
            result = kViewAreaBottom;
        }
    } else {
        if ([self xIsInInnerSection:x forView:view]) {
            // inner area
            result = kViewAreaInner;
        } else {
            if (x < kInterval) {
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
    return x > kInterval &&
    x < (view.frame.size.width - kInterval);
}

- (BOOL)touchStartedInOuterArea:(CGPoint)initialPoint forView:(UIView*)view
{
    ViewArea pointArea = [self getBelongingArea:initialPoint forView:view];
    return [SMInnerOuterChecker isAnOuterArea:pointArea];
}

@end

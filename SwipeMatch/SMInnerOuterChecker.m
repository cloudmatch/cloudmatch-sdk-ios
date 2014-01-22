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
    
    NSString *movement = [self touchEnded:np inView:self.view];
    
    NSLog(@"[IOC]Movement: %@", movement);
    //Check if valid touch START
    int first = [[movement substringToIndex:1] intValue];
    int second = [[movement substringFromIndex:1] intValue];
    
    if (first == second) {
        NSLog(@"[IOC]bad, same two areas");
    }
    
    else if (first == kViewAreaInvalid ||
             second == kViewAreaInvalid) {
        NSLog(@"[IOC]bad, at least one invalid area detected");
    }
    else {
        NSString *start = [SMInnerOuterChecker convertViewAreaToString:first];
        NSString *end = [SMInnerOuterChecker convertViewAreaToString:second];
        [self.movementDelegate onMovementFromAreaStart:start toAreaEnd:end movement:[SMInnerOuterChecker decodeMovement:movement] swipe:[SMInnerOuterChecker decodeSwipe:movement]];
    }
    //Check if valid touch END
    
    //If the gesture recognizer is interpreting a continuous gesture, it should set its state to UIGestureRecognizerStateEnded upon receiving this message. If it is interpreting a discrete gesture, it should set its state to UIGestureRecognizerStateRecognized. If at any point in its handling of the touch objects the gesture recognizer determines that the multi-touch event sequence is not its gesture, it should set it state to UIGestureRecognizerStateCancelled.
    
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

-(BOOL)xIsInInnerSection:(NSInteger)x forView:(UIView*)view
{
    return x > kInterval &&
        x < (view.frame.size.width - kInterval);
}

+ (BOOL)isAnOuterArea:(ViewArea)area
{
    return area == kViewAreaLeft || area == kViewAreaRight ||
        area == kViewAreaBottom || area == kViewAreaTop;
}

- (BOOL)touchStartedInOuterArea:(CGPoint)initialPoint forView:(UIView*)view
{
    ViewArea pointArea = [self getBelongingArea:initialPoint forView:view];
    return [SMInnerOuterChecker isAnOuterArea:pointArea];
}

+ (Movement)decodeMovement:(NSString*)movement
{
    
    if ([movement length] < 2) {
        return kMovementNonInitialized;
    }
    
    ViewArea firstArea = (ViewArea)[[movement substringToIndex:1] integerValue];
    ViewArea secondArea = (ViewArea)[[movement substringFromIndex:1] integerValue];
    
    if ([self isAnOuterArea:firstArea] && [self isAnOuterArea:secondArea]) {
        return kMovementOuterToOuter;
    }
    else if([self isAnOuterArea:firstArea] && ![self isAnOuterArea:secondArea])
    {
        return kMovementOuterToInner;
    }
    else if(![self isAnOuterArea:firstArea] && [self isAnOuterArea:secondArea])
    {
        return kMovementInnerToOuter;
    }
    else if(firstArea == secondArea)
    {
        return kMovementInvalidSameArea;
    }
    else if( (firstArea == kViewAreaInvalid) || (secondArea == kViewAreaInvalid))
    {
        return kMovementInvalidAreaTouched;
    }
    else return kMovementNonInitialized;
    
}

+ (SwipeType)decodeSwipe:(NSString*)movement
{
    if ([movement length] < 2) {
        return kSwipeNotSupported;
    }
    
    Movement mov = [SMInnerOuterChecker decodeMovement:movement];
    
    switch (mov) {
        case kMovementInnerToOuter:
            return kSwipeBegin;
            break;
        case kMovementOuterToInner:
            return kSwipeEnd;
            break;
        case kMovementOuterToOuter:
            return kSwipeIntermediate;
            break;
        default:
            return  kSwipeNotSupported;
            break;
    }
}

+ (NSString*)convertViewAreaToString:(NSInteger)viewArea
{
    NSString *area = @"";
    switch (viewArea) {
        case kViewAreaTop:
            area = kSMAreaTop;
            break;
        case kViewAreaRight:
            area = kSMAreaRight;
            break;
        case kViewAreaBottom:
            area = kSMAreaBottom;
            break;
        case kViewAreaLeft:
            area = kSMAreaLeft;
            break;
        case kViewAreaInner:
            area = kSMAreaInner;
            break;
        case kViewAreaInvalid:
            area = kSMAreaInvalid;
            break;
            
        default:
            break;
    }
    
    return area;
}

@end

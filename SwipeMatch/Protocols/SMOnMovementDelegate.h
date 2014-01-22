//
//  SMOnMovementDelegate.h
//  SwipeMatchSDK
//
//  Created by Giovanni on 1/20/14.
//  Copyright (c) 2014 LimeBamboo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSInteger,ViewArea) {
    kViewAreaTop = 0,
    kViewAreaBottom = 1,
    kViewAreaLeft = 2,
    kViewAreaRight = 3,
    kViewAreaInner = 4,
    kViewAreaInvalid = 5
} ;

typedef NS_ENUM(NSInteger, Movement){
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

@protocol SMOnMovementDelegate <NSObject>

- (BOOL)isSwipeValid;
- (NSString*)getEqualityParam;
- (void)onMovementFromAreaStart:(NSString *)areaStart toAreaEnd:(NSString *)areaEnd movement:(Movement)movement swipe:(NSInteger)swipe;

@optional
- (void)onError:(NSError*) error;

@end

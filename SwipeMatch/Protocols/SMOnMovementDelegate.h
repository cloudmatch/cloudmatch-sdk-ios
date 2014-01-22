//
//  SMOnMovementDelegate.h
//  SwipeMatchSDK
//
//  Created by Giovanni on 1/20/14.
//  Copyright (c) 2014 LimeBamboo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMSwipeConstants.h"

@protocol SMOnMovementDelegate <NSObject>

- (BOOL)isSwipeValid;
- (NSString*)getEqualityParam;
- (void)onMovementDetection:(Movement)movement swipeType:(NSInteger)swipeType;

@optional

- (void)onError:(NSError*) error;

@end

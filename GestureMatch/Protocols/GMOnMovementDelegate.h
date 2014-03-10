//
//  GMOnMovementDelegate.h
//  GestureMatchSDK
//
//  Created by Giovanni on 1/20/14.
//  Copyright (c) 2014 LimeBamboo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMSwipeConstants.h"

@protocol GMOnMovementDelegate <NSObject>

- (BOOL)isSwipeValid;
- (NSString*)getEqualityParam;

// TODO: add screen coordinates
- (void)onMovementDetection:(Movement)movement swipeType:(NSInteger)swipeType;

@optional

- (void)onError:(NSError*) error;

@end

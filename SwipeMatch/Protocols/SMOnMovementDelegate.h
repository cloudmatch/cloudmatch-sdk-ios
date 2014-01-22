//
//  SMOnMovementDelegate.h
//  SwipeMatchSDK
//
//  Created by Giovanni on 1/20/14.
//  Copyright (c) 2014 LimeBamboo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SMOnMovementDelegate <NSObject>

- (BOOL)clientShouldSend;
- (NSData*)getDataToSendForMovement:(NSInteger)movement;
- (void)detectedMovement:(NSString*)movement swipe:(NSInteger)swipe;
- (void)detectedMovementFromAreaStart:(NSString*)areaStart toAreaEnd:(NSString*)areaEnd;

@end

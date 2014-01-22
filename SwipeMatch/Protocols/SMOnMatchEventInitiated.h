//
//  SMOnMatchEventInitiated.h
//  SwipePicture
//
//  Created by Giovanni on 12/12/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SMOnMatchEventInitiated <NSObject>

- (void)onMatchActionWithAreaStart:(NSString*)areaStart areaEnd:(NSString*)areaEnd equalityParam:(NSString*)equalityParam;

@end

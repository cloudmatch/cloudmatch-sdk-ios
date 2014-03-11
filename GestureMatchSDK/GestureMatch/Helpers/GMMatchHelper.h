//
//  MatchHelper.h
//  GestureMatchSDK
//
//  Created by Fabio Tiriticco on 22/01/2014.
//  Copyright (c) 2014 LimeBamboo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GMMatchHelper : NSObject

-(void)matchUsingCriteria:(NSString *)criteria equalityParam:(NSString *)equalityParam areaStart:(NSString *)areaStart areaEnd:(NSString *)areaEnd;

@end

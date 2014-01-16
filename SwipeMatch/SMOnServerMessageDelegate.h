//
//  SMOnServerMessageDelegate.h
//  SwipePicture
//
//  Created by Giovanni on 12/16/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SMOnServerMessageDelegate <NSObject>

- (void)onServerMessage:(NSString*)message;

@end

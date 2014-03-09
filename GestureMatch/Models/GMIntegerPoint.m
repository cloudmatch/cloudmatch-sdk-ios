//
//  GMIntegerPoint.m
//  GestureMatchSDK
//
//  Created by Fabio Tiriticco on 8/03/2014.
//  Copyright (c) 2014 LimeBamboo. All rights reserved.
//

#import "GMIntegerPoint.h"

static NSString* X = @"x";
static NSString* Y = @"y";

@implementation GMIntegerPoint

- (id)initWithX:(NSInteger)x AndY:(NSInteger)y
{
    self = [super init];
    if (self) {
        self.x = x;
        self.y = y;
    }
    return self;
}

@end

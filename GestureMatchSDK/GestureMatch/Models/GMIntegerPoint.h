//
//  GMIntegerPoint.h
//  GestureMatchSDK
//
//  Created by Fabio Tiriticco on 8/03/2014.
//  Copyright (c) 2014 LimeBamboo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GMIntegerPoint : NSObject

@property (nonatomic, assign) NSInteger x;
@property (nonatomic, assign) NSInteger y;

- (id)initWithX:(NSInteger)x AndY:(NSInteger)y;

@end

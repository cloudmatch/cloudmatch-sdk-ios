//
//  GMPositionScheme.h
//  GestureMatchSDK
//
//  Created by Fabio Tiriticco on 9/03/2014.
//  Copyright (c) 2014 LimeBamboo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GMPositionScheme : NSObject

@property (nonatomic, assign) NSInteger mWidth;
@property (nonatomic, assign) NSInteger mHeight;
@property (nonatomic, strong) NSArray *mDevices;

+ (instancetype)modelObjectWithDictionary:(NSDictionary*)dict;
- (instancetype)initWithDictionary:(NSDictionary*)dict;

@end

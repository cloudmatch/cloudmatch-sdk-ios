//
//  GMDeviceInScheme.h
//  GestureMatchSDK
//
//  Created by Fabio Tiriticco on 8/03/2014.
//  Copyright (c) 2014 LimeBamboo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GMIntegerPoint;

@interface GMDeviceInScheme : NSObject

@property (nonatomic, assign) NSInteger mIdInGroup;
@property (nonatomic, strong) GMIntegerPoint *mPosition;

- (id)initWithIdInGroup:(NSInteger)idInGroup AndPosition:(GMIntegerPoint*)position;
+ (instancetype)modelObjectWithDictionary:(NSDictionary*)dict;
- (instancetype)initWithDictionary:(NSDictionary*)dict;

@end

//
//  SMMatchee.h
//  SwipePicture
//
//  Created by Giovanni on 12/11/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMResponsesConstants.h"

@interface SMMatchee : NSObject

@property (nonatomic, assign) NSInteger mIdInGroup;
@property (nonatomic, strong) NSString *mScreenPosition;

- (id)initWithIdInGroup:(NSInteger)idInGroup screenPosition:(NSString*)screenPosition;
+ (instancetype)modelObjectWithDictionary:(NSDictionary*)dict;
- (instancetype)initWithDictionary:(NSDictionary*)dict;
- (NSDictionary*)proxyForJson;

@end

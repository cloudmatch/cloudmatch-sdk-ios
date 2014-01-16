//
//  SMLeaveGroupInput.h
//  SwipePicture
//
//  Created by Giovanni on 12/11/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMJsonGeneralLabels.h"
#import "SMJsonConstants.h"

@interface SMLeaveGroupInput : NSObject

@property (nonatomic, strong) NSString* mReason;
@property (nonatomic, strong) NSString* mGroupId;

- (id)initWithReason:(NSString*)reason groupId:(NSString*)groupId;
+ (instancetype)modelObjectWithDictionary:(NSDictionary*)dict;
- (instancetype)initWithDictionary:(NSDictionary*)dict;
- (NSDictionary*)dictionaryRepresentation;
- (NSDictionary*)proxyForJson;

@end

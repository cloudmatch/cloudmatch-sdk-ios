//
//  GMDeliverResponse.h
//  GestureMatchSDK
//
//  Created by Giovanni on 12/11/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GMDeliveryResponse : NSObject

@property (nonatomic, strong) NSString* mOutcome;
@property (nonatomic, strong) NSString* mDeliveryReason;
@property (nonatomic, strong) NSString* mGroupId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary*)dict;
- (instancetype)initWithDictionary:(NSDictionary*)dict;

@end

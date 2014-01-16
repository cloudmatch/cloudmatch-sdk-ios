//
//  SMMatcheeDelivery.h
//  SwipePicture
//
//  Created by Giovanni on 12/26/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMMatcheeDelivery : NSObject

@property (nonatomic, assign) NSInteger mSenderMatchee;
@property (nonatomic, strong) NSString* mPayload;
@property (nonatomic, strong) NSString* mGroupId;

- (id)initWithSenderMatchee:(NSInteger)senderMatchee payload:(NSString*)payload groupId:(NSString*)groupId;

@end

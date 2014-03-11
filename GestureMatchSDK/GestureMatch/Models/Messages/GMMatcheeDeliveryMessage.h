//
//  GMMatcheeDeliveryMessage.h
//  GestureMatchSDK
//
//  Created by Giovanni on 12/11/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GMMatcheeDeliveryMessage : NSObject

@property (nonatomic, assign) NSInteger mSenderMatchee;
@property (nonatomic, strong) NSString* mDeliveryId;
@property (nonatomic, strong) NSString* mPayload;
@property (nonatomic, strong) NSString* mGroupId;
@property (nonatomic, assign) NSInteger mTotalChunks;
@property (nonatomic, assign) NSInteger mChunkNr;

+ (instancetype)modelObjectWithDictionary:(NSDictionary*)dict;
- (instancetype)initWithDictionary:(NSDictionary*)dict;

@end

//
//  GMDeliveryInput.h
//  GestureMatchSDK
//
//  Created by Giovanni on 12/11/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMJsonGeneralLabels.h"
#import "GMJsonInputLabels.h"
#import "GMJsonConstants.h"
#import "GMMatchee.h"

@interface GMDeliveryInput : NSObject

@property (nonatomic, strong) NSArray *mRecipients;
@property (nonatomic, strong) NSString *mDeliveryId;
@property (nonatomic, strong) NSString *mPayload;
@property (nonatomic, strong) NSString *mGroupId;
@property (nonatomic, assign) NSInteger mTotalChunks;
@property (nonatomic, assign) NSInteger mChunkNr;


- (id)initWithRecipients:(NSArray*)recipients payload:(NSString*)payload groupId:(NSString*)groupId;
- (id)initWithRecipients:(NSArray *)recipients deliveryId:(NSString*)deliveryId payload:(NSString *)payload groupId:(NSString *)groupId totalChunks:(NSUInteger)totalChunks chunkNr:(NSUInteger)chunkNr;
+ (instancetype)modelObjectWithDictionary:(NSDictionary*)dict;
- (instancetype)initWithDictionary:(NSDictionary*)dict;
- (NSDictionary*)dictionaryRepresentation;
- (NSDictionary*)proxyForJson;


@end

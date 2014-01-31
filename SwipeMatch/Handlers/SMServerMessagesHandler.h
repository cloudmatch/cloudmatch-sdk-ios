//
//  SMServerMessagesHandler.h
//  SwipePicture
//
//  Created by Giovanni on 12/13/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMOnServerEventDelegate.h"
#import "SMOnServerMessageDelegate.h"
#import "SMJsonGeneralLabels.h"
#import "SMJsonConstants.h"
#import "SMResponsesConstants.h"

@interface SMServerMessagesHandler : NSObject <SMOnServerMessageDelegate>

- (id)initWithServerEventDelegate:(id<SMOnServerEventDelegate>)delegate;

@property (nonatomic, weak) id<SMOnServerEventDelegate> serverEventDelegate;
@property (nonatomic, strong) NSMutableDictionary *mPartialDeliveries;

@end

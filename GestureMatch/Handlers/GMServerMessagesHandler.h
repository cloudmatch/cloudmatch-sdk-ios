//
//  GMServerMessagesHandler.h
//  GestureMatchSDK
//
//  Created by Giovanni on 12/13/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMOnServerEventDelegate.h"
#import "GMOnServerMessageDelegate.h"
#import "GMJsonGeneralLabels.h"
#import "GMJsonConstants.h"
#import "GMResponsesConstants.h"

@interface GMServerMessagesHandler : NSObject <GMOnServerMessageDelegate>

- (id)initWithServerEventDelegate:(id<GMOnServerEventDelegate>)delegate;

@property (nonatomic, weak) id<GMOnServerEventDelegate> serverEventDelegate;
@property (nonatomic, strong) NSMutableDictionary *mPartialDeliveries;

@end

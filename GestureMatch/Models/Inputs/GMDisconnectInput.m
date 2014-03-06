//
//  GMDisconnectInput.m
//  GestureMatchSDK
//
//  Created by Giovanni on 12/11/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

#import "GMDisconnectInput.h"

@implementation GMDisconnectInput

- (id)initWithReason:(NSString *)reason
{
    self = [super init];
    if (self) {
        self.mReason = reason;
    }
    return self;
}

+ (instancetype)modelObjectWithDictionary:(NSDictionary*)dict
{
    GMDisconnectInput *instance = [[GMDisconnectInput alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.mReason = [dict objectForKey:REASON];
    }
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    return @{TYPE: kGMResponseTypeDisconnect,
             REASON : _mReason
             };
}

- (NSDictionary*)proxyForJson
{
    return [self dictionaryRepresentation];
}

@end

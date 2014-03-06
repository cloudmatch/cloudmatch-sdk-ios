//
//  GMMatchResponse.h
//  GestureMatchSDK
//
//  Created by Giovanni on 12/11/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMJsonGeneralLabels.h"
#import "GMResponsesConstants.h"
#import "GMMatchee.h"

@interface GMMatchResponse : NSObject


//public ResponseReasons mReason = ResponseReasons.unknown;
//public String mGroupId;
//public Integer mGroupSize;
//public Matchee mMyselfInGroup;
//public ArrayList<Matchee> mOthersInGroup = new ArrayList<Matchee>();

@property (nonatomic, strong) NSString *mOutcome;
@property (nonatomic, strong) NSString *mResponseReason;
@property (nonatomic, strong) GMMatchee *mMyselfInGroup;
@property (nonatomic, strong) NSArray *mOthersInGroup;
@property (nonatomic, strong) NSString *mGroupId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary*)dict;
- (instancetype)initWithDictionary:(NSDictionary*)dict;



@end

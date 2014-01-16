//
//  SMMatchResponse.h
//  SwipePicture
//
//  Created by Giovanni on 12/11/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMJsonGeneralLabels.h"
#import "SMResponsesConstants.h"
#import "SMMatchee.h"

@interface SMMatchResponse : NSObject


//public ResponseReasons mReason = ResponseReasons.unknown;
//public String mGroupId;
//public Integer mGroupSize;
//public Matchee mMyselfInGroup;
//public ArrayList<Matchee> mOthersInGroup = new ArrayList<Matchee>();

@property (nonatomic, strong) NSString *mOutcome;
@property (nonatomic, strong) NSString *mResponseReason;
@property (nonatomic, strong) SMMatchee *mMyselfInGroup;
@property (nonatomic, strong) NSArray *mOthersInGroup;
@property (nonatomic, strong) NSString *mGroupId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary*)dict;
- (instancetype)initWithDictionary:(NSDictionary*)dict;



@end

//
//  GMMatchResponse.h
//  GestureMatchSDK
//
//  Created by Giovanni on 12/11/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GMPositionScheme;

@interface GMMatchResponse : NSObject


//public ResponseReasons mReason = ResponseReasons.unknown;
//public String mGroupId;
//public Integer mGroupSize;
//public Matchee mMyselfInGroup;
//public ArrayList<Matchee> mOthersInGroup = new ArrayList<Matchee>();

//private static final String MY_ID_IN_GROUP = "myId";
//private static final String DEVICES_IN_GROUP = "group";
//
//public Outcomes mOutcome = Outcomes.unknown;
//public ResponseReasons mReason = ResponseReasons.unknown;
//public String mGroupId;
//public Integer mGroupSize;
//public Integer mMyIdInGroup;
//public ArrayList<Integer> mDevicesInGroup = new ArrayList<Integer>();
//public PositionScheme mPositionScheme;

@property (nonatomic, strong) NSString *mOutcome;
@property (nonatomic, strong) NSString *mResponseReason;
@property (nonatomic, strong) NSString *mGroupId;
@property (nonatomic, assign) NSInteger mMyIdInGroup;
@property (nonatomic, assign) NSInteger mGroupSize;
@property (nonatomic, strong) NSArray *mDevicesInGroup;
@property (nonatomic, strong) GMPositionScheme* mPositionScheme;

+ (instancetype)modelObjectWithDictionary:(NSDictionary*)dict;
- (instancetype)initWithDictionary:(NSDictionary*)dict;

@end

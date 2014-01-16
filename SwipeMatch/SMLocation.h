//
//  AppLocation.h
//  networker-ios
//
//  Created by Giovanni on 11/20/13.
//  Copyright (c) 2013 Giovanni Maggini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

extern NSString* const kLocationServicesFailure;
extern NSString* const kLocationServicesForbidden;
extern NSString* const kLocationServicesGotBestAccuracyLocation;

@interface SMLocation : NSObject <CLLocationManagerDelegate>

+ (SMLocation*)sharedInstance;

//Location Properties
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *currentLocation;

//Location methods
- (void) startLocationServices;
- (void) stopLocationServices;

@end

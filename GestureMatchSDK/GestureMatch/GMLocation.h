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

@interface GMLocation : NSObject <CLLocationManagerDelegate>

+ (GMLocation*)sharedInstance;

//Location methods
- (void) startLocationServices;
- (void) stopLocationServices;

- (double)getLatitude;
- (double)getLongitude;
- (BOOL)isLocationEnabled;

@end

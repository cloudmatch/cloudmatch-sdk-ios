//
//  AppLocation.m
//  networker-ios
//
//  Created by Giovanni on 11/20/13.
//  Copyright (c) 2013 Giovanni Maggini. All rights reserved.
//

#import "SMLocation.h"

//Location Notifications
NSString* const kLocationServicesFailure = @"kLocationServicesFailure";
NSString* const kLocationServicesForbidden = @"kLocationServicesForbidden";
NSString* const kLocationServicesGotBestAccuracyLocation = @"kLocationServicesGotBestAccuracyLocation";

@interface SMLocation ()

//Location Properties
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic, assign) BOOL locationServicesEnabled;

@end


@implementation SMLocation

+(SMLocation *)sharedInstance {
    static dispatch_once_t pred;
    static SMLocation *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[SMLocation alloc] init];
        shared.locationServicesEnabled = true;
    });
    return shared;
}

#pragma mark - Getters

- (double)getLatitude
{
    return _currentLocation.coordinate.latitude;
}

- (double)getLongitude
{
    return _currentLocation.coordinate.longitude;
}

- (BOOL)isLocationEnabled
{
    return _locationServicesEnabled;
}

#pragma mark - Location Manager

- (void)startLocationServices
{
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"location services are disabled");
        return;
    }
    
    if (nil == _locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [_locationManager startUpdatingLocation];
}

- (void)stopLocationServices
{
    [_locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    self.locationServicesEnabled = NO;
    
    if ([error domain] == kCLErrorDomain) {
        // We handle CoreLocation-related errors here
        switch ([error code]) {
                // "Don't Allow" on two successive app launches is the same as saying "never allow". The user
                // can reset this for all apps by going to Settings > General > Reset > Reset Location Warnings.
            case kCLErrorDenied:{
                [[NSNotificationCenter defaultCenter] postNotificationName:kLocationServicesForbidden object:nil];
            }
            case kCLErrorLocationUnknown:
            {
                NSDictionary *userInfo = @{ @"error" : error };
                [[NSNotificationCenter defaultCenter] postNotificationName:kLocationServicesFailure object:nil userInfo:userInfo];
            }
                
            default:
                break;
        }
    } else {
        // We handle all non-CoreLocation errors here
    }
    
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currentLocation = [locations lastObject];
    NSDate* eventDate = currentLocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0) {
        _currentLocation = currentLocation;
        [[NSNotificationCenter defaultCenter] postNotificationName:kLocationServicesGotBestAccuracyLocation object:nil];
#if DEBUG
        NSLog(@"Location: %f %f", [self getLatitude], [self getLongitude] );
#endif
    }
}

@end

/*
 * Copyright 2014 cloudmatch.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "CMLocation.h"

//Location Notifications
NSString* const kLocationServicesFailure = @"kLocationServicesFailure";
NSString* const kLocationServicesForbidden = @"kLocationServicesForbidden";
NSString* const kLocationServicesGotBestAccuracyLocation = @"kLocationServicesGotBestAccuracyLocation";

@interface CMLocation ()

//Location Properties
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic, assign) BOOL locationServicesEnabled;

@end


@implementation CMLocation

+(CMLocation *)sharedInstance {
    static dispatch_once_t pred;
    static CMLocation *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[CMLocation alloc] init];
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
    }
}

@end

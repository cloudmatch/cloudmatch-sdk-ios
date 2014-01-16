//
//  SMUtilities.m
//  SwipePicture
//
//  Created by Giovanni on 12/17/13.
//  Copyright (c) 2013 LimeBamboo. All rights reserved.
//

#import "SMUtilities.h"

@implementation SMUtilities

+ (NSString*)getDeviceIdForAppId:(NSString*)appID
{
    // Get device UDID
    // getting the unique key (if present ) from keychain , assuming "your app identifier" as a key
    NSString *deviceID = [SSKeychain passwordForService:@"ch.swipemat" account:appID];
    if (deviceID == nil) { // if this is the first time app lunching , create key for device
        NSString *uuid  = [self createNewUUID];
        // save newly created key to Keychain
        [SSKeychain setPassword:uuid forService:@"ch.swipemat" account:appID];
        // this is the one time process
        deviceID = uuid;
    }
    return deviceID;
}

+ (NSString*)generateDeliveryUUID
{
    return [self createNewUUID];
}

#pragma mark - Private

+ (NSString *)createNewUUID {
    
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge NSString *)string;
}

@end

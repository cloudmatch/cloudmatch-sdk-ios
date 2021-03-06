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

#import "CMUtilities.h"
#import "SSKeychain.h"

@implementation CMUtilities

+ (NSString*)getDeviceIdForAppId
{
    // Get device UDID
    // getting the unique key (if present ) from keychain , assuming "your app identifier" as a key
    NSString *deviceID = [SSKeychain passwordForService:@"io.cloudmatch" account:@"deviceId"];
    if (deviceID == nil) {
        // if this is the first time app lunching , create key for device
        NSString *uuid  = [self createNewUUID];
        // save newly created key to Keychain
        [SSKeychain setPassword:uuid forService:@"io.cloudmatch" account:@"deviceId"];
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
    return [[NSUUID UUID] UUIDString];
}

@end

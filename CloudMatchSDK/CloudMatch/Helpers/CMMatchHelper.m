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

#import "CMMatchHelper.h"
#import "CMMatchInput.h"
#import "CMLocation.h"
#import "SRWebSocket.h"
#import "CMCloudMatchClient.h"

@implementation CMMatchHelper

- (void)matchUsingCriteria:(NSString *)criteria equalityParam:(NSString *)equalityParam areaStart:(NSString *)areaStart areaEnd:(NSString *)areaEnd
{
    if ([[CMLocation sharedInstance] isLocationEnabled] != YES) {
        @throw [NSException exceptionWithName:@"Location services disabled" reason:@"Location services disabled" userInfo:nil];
    }
    
    double latitude = [[CMLocation sharedInstance] getLatitude];
    double longitude = [[CMLocation sharedInstance] getLongitude];
    
    CMMatchInput *matchInput = [[CMMatchInput alloc] initWithCriteria:criteria latitude:latitude longitude:longitude equalityParam:equalityParam areaStart:areaStart areaEnd:areaEnd];
    
    @try {
        NSError *jsonError;
        NSData *dataToSend = [NSJSONSerialization dataWithJSONObject:[matchInput dictionaryRepresentation] options:0 error:&jsonError];
        NSString *stringtoSend = [[NSString alloc] initWithData:dataToSend encoding:NSUTF8StringEncoding];
        if (dataToSend == nil) {
            @throw [NSException exceptionWithName:@"Error parsing matchInput" reason:jsonError.localizedDescription userInfo:nil];
        }
        
        SRWebSocket* webSocket = [[CMCloudMatchClient sharedInstance] getWebSocket];
        
#ifdef DEBUG
        NSLog(@"Sending data: %@", [matchInput dictionaryRepresentation]);
#endif
        
        if (webSocket.readyState == SR_OPEN) {
            [webSocket send:stringtoSend];
        } else {
            // TODO: deal with error states or add to sendQueue in CMCloudMatchClient
        }
    }
    
    @catch (NSException *exception) {
        // TODO: deal with exception
    }
    
}

@end

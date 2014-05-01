/*
 * Copyright 2014 Fabio cloudmatch.io
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

#import "GMMatchHelper.h"
#import "GMMatchInput.h"
#import "GMLocation.h"
#import "SBJson4Writer.h"
#import "SRWebSocket.h"
#import "GMGestureMatchClient.h"

@implementation GMMatchHelper

- (void)matchUsingCriteria:(NSString *)criteria equalityParam:(NSString *)equalityParam areaStart:(NSString *)areaStart areaEnd:(NSString *)areaEnd
{
    if ([[GMLocation sharedInstance] isLocationEnabled] != YES) {
        @throw [NSException exceptionWithName:@"Location services disabled" reason:@"Location services disabled" userInfo:nil];
    }
    
    double latitude = [[GMLocation sharedInstance] getLatitude];
    double longitude = [[GMLocation sharedInstance] getLongitude];
    
    GMMatchInput *matchInput = [[GMMatchInput alloc] initWithCriteria:criteria latitude:latitude longitude:longitude equalityParam:equalityParam areaStart:areaStart areaEnd:areaEnd];
    
    @try {
        SBJson4Writer *writer = [[SBJson4Writer alloc] init];
        NSString *dataToSend = [writer stringWithObject:[matchInput dictionaryRepresentation]];
        if (writer.error != nil) {
            @throw [NSException exceptionWithName:@"Error parsing matchInput" reason:writer.error userInfo:nil];
        }
        
        SRWebSocket* webSocket = [[GMGestureMatchClient sharedInstance] getWebSocket];
        if (webSocket.readyState == SR_OPEN) {
            [webSocket send:dataToSend];
        } else {
            // TODO: deal with error states or add to sendQueue in GMGestureMatchClient
        }
    }
    
    @catch (NSException *exception) {
        // TODO: deal with exception
    }
    
}

@end

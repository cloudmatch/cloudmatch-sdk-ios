//
//  MatchHelper.m
//  GestureMatchSDK
//
//  Created by Fabio Tiriticco on 22/01/2014.
//  Copyright (c) 2014 LimeBamboo. All rights reserved.
//

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
        NSLog(@"%@ Ready to send: %@", [[self class] description], dataToSend);
        
        SRWebSocket* webSocket = [[GMGestureMatchClient sharedInstance] getWebSocket];
        if (webSocket.readyState == SR_OPEN) {
            [webSocket send:dataToSend];
        } else {
            NSLog(@"Socket not ready");
            // TODO: deal with error states or add to sendQueue in GMGestureMatchClient
        }
    }
    
    @catch (NSException *exception) {
        NSLog(@"[%@] Exception in matchUsingCriteria: %@", [[self class] description], [exception description]);
    }
    
}

@end

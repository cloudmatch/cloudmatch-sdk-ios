//
//  MatchHelper.m
//  SwipeMatchSDK
//
//  Created by Fabio Tiriticco on 22/01/2014.
//  Copyright (c) 2014 LimeBamboo. All rights reserved.
//

#import "SMMatchHelper.h"
#import "SMMatchInput.h"

@implementation SMMatchHelper

- (void)matchUsingCriteria:(NSString *)criteria equalityParam:(NSString *)equalityParam areaStart:(NSString *)areaStart areaEnd:(NSString *)areaEnd
{
    // TODO: check for location services enabled
    
    double latitude = [SMLocation sharedInstance].currentLocation.coordinate.latitude;
    double longitude = [SMLocation sharedInstance].currentLocation.coordinate.longitude;
    
    SMMatchInput *matchInput = [[SMMatchInput alloc] initWithCriteria:criteria latitude:latitude longitude:longitude equalityParam:equalityParam areaStart:areaStart areaEnd:areaEnd];
    
    @try {
        SBJson4Writer *writer = [[SBJson4Writer alloc] init];
        NSString *dataToSend = [writer stringWithObject:[matchInput dictionaryRepresentation]];
        if (writer.error != nil) {
            @throw [NSException exceptionWithName:@"Error parsing matchInput" reason:writer.error userInfo:nil];
        }
        NSLog(@"%@ Ready to send: %@", [[self class] description], dataToSend);
        
        SRWebSocket* webSocket = [[SMSwipeMatchClient sharedInstance] getWebSocket];
        if (webSocket.readyState == SR_OPEN) {
            [webSocket send:dataToSend];
        } else {
            NSLog(@"Socket not ready");
            // TODO: deal with error states
        }
    }
    
    @catch (NSException *exception) {
        NSLog(@"[%@] Exception in matchUsingCriteria: %@", [[self class] description], [exception description]);
    }
    
}

@end

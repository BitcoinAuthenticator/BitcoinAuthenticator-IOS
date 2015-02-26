//
//  RemoteNotificationHandler.m
//  Authenticator
//
//  Created by alon muroch on 1/21/15.
//  Copyright (c) 2015 Bitcoin Authenticator. All rights reserved.
//

#import "RemoteNotificationHandler.h"

@implementation RemoteNotificationHandler

+(void)handle:(NSDictionary*)userInfo
{
    NSDictionary *payload = [userInfo objectForKey:@"p"];
    
    BARemoteNotificationMessageType msgType = (BARemoteNotificationMessageType)[[payload objectForKey:@""] intValue];
    switch (msgType) {
        case Test:
            //TODO
            break;
        case SignTx:
            
            break;
        case UpdateIpAddresses:
            break;
        case CoinsReceived:
            break;
        default:
            break;
    }
}

+(void)didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString* deviceTokenStr = [[[[deviceToken description]
                               stringByReplacingOccurrencesOfString: @"<" withString: @""]
                              stringByReplacingOccurrencesOfString: @">" withString: @""]
                             stringByReplacingOccurrencesOfString: @" " withString: @""] ;
    [self setDeviceToken:deviceTokenStr];
    NSLog(@"Did Register for Remote Notifications with Device Token (%@)", deviceTokenStr);
}

+(void)didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Did Fail to Register for Remote Notifications");
    NSLog(@"%@, %@", error, error.localizedDescription);
}

static NSString *deviceToken;
+(NSString*)deviceToken
{
    @synchronized(self)
    {
        return deviceToken;
    }
}
+(void)setDeviceToken:(NSString *)val
{
    deviceToken = val;
}

@end

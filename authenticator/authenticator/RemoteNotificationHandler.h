//
//  RemoteNotificationHandler.h
//  Authenticator
//
//  Created by alon muroch on 1/21/15.
//  Copyright (c) 2015 Bitcoin Authenticator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BARemoteNotificationMessage.h"

@interface RemoteNotificationHandler : NSObject

+(NSString*)deviceToken;

+(void)didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
+(void)didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;
+(void)handle:(NSDictionary*)userInfo;

@end

//
//  AuthenticatorAppDelegateExtender.h
//  Authenticator
//
//  Created by alon muroch on 1/21/15.
//  Copyright (c) 2015 Bitcoin Authenticator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RemoteNotificationHandler.h"

/** This extension class is designed to add the necessary configuration and functionality to the app's delegate for the authenticator.
 *  Extend your AppDelegate class with this class.
 */
@interface AuthenticatorAppDelegateExtender : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

-(void)registerForRemoteNotifications:(UIApplication *)application;

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;

@end

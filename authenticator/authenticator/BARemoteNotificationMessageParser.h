//
//  BARemoteNotificationMessage.h
//  authenticator
//
//  Created by alon muroch on 2/26/15.
//  Copyright (c) 2015 Bitcoin Authenticator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BARemoteNotificationData.h"

typedef enum {
    Test                = 1 << 0, // 1
    SignTx              = 1 << 1, // 2
    UpdateIpAddresses   = 1 << 2, // 4
    CoinsReceived       = 1 << 3  // 8
}BARemoteNotificationMessageType;

@interface BARemoteNotificationMessageParser : NSObject

@property (nonatomic) BARemoteNotificationMessageType type;
@property (strong, nonatomic) NSDate *timestamp;
@property (strong, nonatomic) NSString *reqID;
@property (strong, nonatomic) NSString *walletID;
@property(nonatomic, strong) NSString *customMsg; // optional

//When data is parse it is first converted to a JSON string for later use.
//This parameter holds the JSON string
@property (nonatomic, strong) NSString *stringifiedData;

-(void)fromString:(NSString*)str  type:(BARemoteNotificationMessageType)type;
-(void)fromDictionary:(NSDictionary*)dic type:(BARemoteNotificationMessageType)type;

-(BARemoteNotificationData*)notificationDataObject;

@end

/**
 ██████╗ ██████╗ ███████╗ █████╗ ██╗  ██╗
 ██╔══██╗██╔══██╗██╔════╝██╔══██╗██║ ██╔╝
 ██████╔╝██████╔╝█████╗  ███████║█████╔╝
 ██╔══██╗██╔══██╗██╔══╝  ██╔══██║██╔═██╗
 ██████╔╝██║  ██║███████╗██║  ██║██║  ██╗
 ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝
 */

@interface SignTxMessageParser : BARemoteNotificationMessageParser

@property(nonatomic, strong) NSString *localIP;
@property(nonatomic, strong) NSString *externalIP;

-(void)fromDictionary:(NSDictionary*)dic;

@end

/**
 ██████╗ ██████╗ ███████╗ █████╗ ██╗  ██╗
 ██╔══██╗██╔══██╗██╔════╝██╔══██╗██║ ██╔╝
 ██████╔╝██████╔╝█████╗  ███████║█████╔╝
 ██╔══██╗██╔══██╗██╔══╝  ██╔══██║██╔═██╗
 ██████╔╝██║  ██║███████╗██║  ██║██║  ██╗
 ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝
 */

@interface UpdateIpAddressesMessageParser : BARemoteNotificationMessageParser

@property(nonatomic, strong) NSString *localIP;
@property(nonatomic, strong) NSString *externalIP;

-(void)fromDictionary:(NSDictionary*)dic;

@end

/**
 ██████╗ ██████╗ ███████╗ █████╗ ██╗  ██╗
 ██╔══██╗██╔══██╗██╔════╝██╔══██╗██║ ██╔╝
 ██████╔╝██████╔╝█████╗  ███████║█████╔╝
 ██╔══██╗██╔══██╗██╔══╝  ██╔══██║██╔═██╗
 ██████╔╝██║  ██║███████╗██║  ██║██║  ██╗
 ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝
 */

@interface CoinsReceivedMessageParser : BARemoteNotificationMessageParser
-(void)fromDictionary:(NSDictionary*)dic;
@end

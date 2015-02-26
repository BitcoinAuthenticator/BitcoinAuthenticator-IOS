//
//  BARemoteNotificationMessage.h
//  authenticator
//
//  Created by alon muroch on 2/26/15.
//  Copyright (c) 2015 Bitcoin Authenticator. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    Test                = 1 << 0,
    SignTx              = 1 << 1,
    UpdateIpAddresses   = 1 << 2,
    CoinsReceived       = 1 << 3
}BARemoteNotificationMessageType;

@interface BARemoteNotificationMessage : NSObject

@property (nonatomic) BARemoteNotificationMessageType type;
@property (strong, nonatomic) NSDate *timestamp;
@property (strong, nonatomic) NSString *reqID;
@property (strong, nonatomic) NSString *walletID;
@property(nonatomic, strong) NSString *customMsg; // optional

-(void)fromDictionary:(NSDictionary*)dic type:(BARemoteNotificationMessageType)type;

@end

/**
 ██████╗ ██████╗ ███████╗ █████╗ ██╗  ██╗
 ██╔══██╗██╔══██╗██╔════╝██╔══██╗██║ ██╔╝
 ██████╔╝██████╔╝█████╗  ███████║█████╔╝
 ██╔══██╗██╔══██╗██╔══╝  ██╔══██║██╔═██╗
 ██████╔╝██║  ██║███████╗██║  ██║██║  ██╗
 ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝
 */

@interface SignTxMessage : BARemoteNotificationMessage

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

@interface UpdateIpAddressesMessage : BARemoteNotificationMessage

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

@interface CoinsReceivedMessage : BARemoteNotificationMessage
-(void)fromDictionary:(NSDictionary*)dic;
@end

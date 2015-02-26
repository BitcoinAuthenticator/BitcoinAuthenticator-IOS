//
//  BARemoteNotificationMessage.m
//  authenticator
//
//  Created by alon muroch on 2/26/15.
//  Copyright (c) 2015 Bitcoin Authenticator. All rights reserved.
//

#import "BARemoteNotificationMessage.h"

@implementation BARemoteNotificationMessage

-(id)init
{
    self = [super init];
    if(self != nil)
    {
        
    }
    return self;
}

/** Parses a dictionary of the custom payload sent from the authenticator wallet.
 */
-(void)fromDictionary:(NSDictionary*)dic type:(BARemoteNotificationMessageType)type
{
    self.timestamp = nil; // TODO
    self.walletID = [dic objectForKey:@"WalletID"];
    self.type = type;
    self.reqID = [dic objectForKey:@"RequestID"];
    self.customMsg = [dic objectForKey:@"CustomMsg"];
}

@end

/**
 ██████╗ ██████╗ ███████╗ █████╗ ██╗  ██╗
 ██╔══██╗██╔══██╗██╔════╝██╔══██╗██║ ██╔╝
 ██████╔╝██████╔╝█████╗  ███████║█████╔╝
 ██╔══██╗██╔══██╗██╔══╝  ██╔══██║██╔═██╗
 ██████╔╝██║  ██║███████╗██║  ██║██║  ██╗
 ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝
 */

@implementation SignTxMessage

-(id)init
{
    self = [super init];
    if(self != nil)
    {
        
    }
    return self;
}

-(void)fromDictionary:(NSDictionary*)dic
{
    [super fromDictionary:dic type:SignTx];
    
    NSDictionary *reqPayload = [dic objectForKey:@"ReqPayload"];
    self.localIP = [reqPayload objectForKey:@"LocalIP"];
    self.externalIP = [reqPayload objectForKey:@"ExternalIP"];
}

@end

/**
 ██████╗ ██████╗ ███████╗ █████╗ ██╗  ██╗
 ██╔══██╗██╔══██╗██╔════╝██╔══██╗██║ ██╔╝
 ██████╔╝██████╔╝█████╗  ███████║█████╔╝
 ██╔══██╗██╔══██╗██╔══╝  ██╔══██║██╔═██╗
 ██████╔╝██║  ██║███████╗██║  ██║██║  ██╗
 ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝
 */

@implementation UpdateIpAddressesMessage

-(id)init
{
    self = [super init];
    if(self != nil)
    {
        
    }
    return self;
}

-(void)fromDictionary:(NSDictionary*)dic
{
    [super fromDictionary:dic type:UpdateIpAddresses];
    
    NSDictionary *reqPayload = [dic objectForKey:@"ReqPayload"];
    self.localIP = [reqPayload objectForKey:@"LocalIP"];
    self.externalIP = [reqPayload objectForKey:@"ExternalIP"];
}

@end

/**
 ██████╗ ██████╗ ███████╗ █████╗ ██╗  ██╗
 ██╔══██╗██╔══██╗██╔════╝██╔══██╗██║ ██╔╝
 ██████╔╝██████╔╝█████╗  ███████║█████╔╝
 ██╔══██╗██╔══██╗██╔══╝  ██╔══██║██╔═██╗
 ██████╔╝██║  ██║███████╗██║  ██║██║  ██╗
 ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝
 */

@implementation CoinsReceivedMessage

-(id)init
{
    self = [super init];
    if(self != nil)
    {
        
    }
    return self;
}

-(void)fromDictionary:(NSDictionary*)dic
{
    [super fromDictionary:dic type:CoinsReceived];
}

@end

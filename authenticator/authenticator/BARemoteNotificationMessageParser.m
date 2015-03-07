//
//  BARemoteNotificationMessage.m
//  authenticator
//
//  Created by alon muroch on 2/26/15.
//  Copyright (c) 2015 Bitcoin Authenticator. All rights reserved.
//

#import "BARemoteNotificationMessageParser.h"
#import "NSManagedObject+Manager.h"

@implementation BARemoteNotificationMessageParser

-(id)init
{
    self = [super init];
    if(self != nil)
    {
        
    }
    return self;
}

/** Will convert the string to a NSDictionary and parse as normal
 */
-(void)fromString:(NSString*)str  type:(BARemoteNotificationMessageType)type
{
    NSError *e = nil;
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:[self.stringifiedData dataUsingEncoding:NSUTF8StringEncoding]
                                                         options: NSJSONReadingMutableContainers
                                                         error: &e];
    [self fromDictionary:JSON type:type];
}

/** Parses a dictionary of the custom payload sent from the authenticator wallet.
 */
-(void)fromDictionary:(NSDictionary*)dic type:(BARemoteNotificationMessageType)type
{
    // dic to string
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        self.stringifiedData = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    self.timestamp = nil; // TODO
    self.walletID = [dic objectForKey:@"WalletID"];
    self.type = type;
    self.reqID = [dic objectForKey:@"RequestID"];
    self.customMsg = [dic objectForKey:@"CustomMsg"];
}

-(BARemoteNotificationData*)notificationDataObject {
    BARemoteNotificationData *obj = [BARemoteNotificationData _managedObject];
    obj.type = [NSNumber numberWithInt:self.type];
//    if(self.timestamp != nil) // TODO
//        obj.tmpStamp = [NSDateFormatter localizedStringFromDate:self.timestamp
//                                                  dateStyle:NSDateFormatterShortStyle
//                                                  timeStyle:NSDateFormatterFullStyle];
    obj.data = self.stringifiedData;
        
    return obj;
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

@implementation SignTxMessageParser

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

@implementation UpdateIpAddressesMessageParser

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

@implementation CoinsReceivedMessageParser

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

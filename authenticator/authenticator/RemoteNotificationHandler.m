//
//  RemoteNotificationHandler.m
//  Authenticator
//
//  Created by alon muroch on 1/21/15.
//  Copyright (c) 2015 Bitcoin Authenticator. All rights reserved.
//

#import "RemoteNotificationHandler.h"
#import "BARemoteNotificationMessageParser.h"
#import "BAPairingData.h"
#import "NSManagedObject+Manager.h"

@implementation RemoteNotificationHandler

/**Extracts the authenticator payload from a the received APN and processes it with +(void)handleRemoteNotificaitonPayload:(NSDictionary*)payload
 */
+(void)handleReceivedAPNS:(NSDictionary*)userInfo
{
    NSDictionary *payload = [userInfo objectForKey:@"p"];
    [self handleRemoteNotificaitonPayload:payload];
}


/**Will parse the incoming notification and add, if necessary, a pending request to the referenced pairing.
 */
+(void)handleRemoteNotificaitonPayload:(NSDictionary*)payload
{
    BARemoteNotificationMessageType msgType = (BARemoteNotificationMessageType)[[payload objectForKey:@"RequestType"] intValue];
    NSString *strigifiedData;
    NSNumber *walletIdx;
    switch (msgType) {
        case Test:
            //TODO
            break;
        case SignTx:
        {
            SignTxMessageParser *parser = [[SignTxMessageParser alloc] init];
            [parser fromDictionary:payload];
            strigifiedData = [parser stringifiedData];
            strigifiedData = [parser stringifiedData];
            walletIdx = [NSNumber numberWithLongLong:[parser.walletID longLongValue]];
            break;
        }
        case UpdateIpAddresses:
        {
            UpdateIpAddressesMessageParser *parser = [[UpdateIpAddressesMessageParser alloc] init];
            [parser fromDictionary:payload];
            strigifiedData = [parser stringifiedData];
            walletIdx = [NSNumber numberWithLongLong:[parser.walletID longLongValue]];
            break;
        }
        case CoinsReceived:
        {
            CoinsReceivedMessageParser *parser = [[CoinsReceivedMessageParser alloc] init];
            [parser fromDictionary:payload];
            strigifiedData = [parser stringifiedData];
            walletIdx = [NSNumber numberWithLongLong:[parser.walletID longLongValue]];
            break;
        }
        default:
            break;
    }
    
    // build notification data
    BARemoteNotificationData *notificationData = [BARemoteNotificationData _managedObject];
    notificationData.data = strigifiedData;
    notificationData.type = [NSNumber numberWithInt:msgType];
    
    // get the referenced wallet by its id
    NSString *predicateStr = [NSString stringWithFormat:@"walletIdx == %d", [walletIdx intValue]];
    NSArray *pairingsFound = [BAPairingData _objectsMatching:predicateStr];
    if(pairingsFound == nil || pairingsFound.count == 0) return;
    
    // add to the wallet
    BAPairingData *pairingData = [pairingsFound objectAtIndex:0];
    [pairingData addPendigNotificationsObject:notificationData];
    
    // update
    [BAPairingData _saveContext];
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

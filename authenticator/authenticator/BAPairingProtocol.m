//
//  BAPairingProtocol.m
//  authenticator
//
//  Created by alon muroch on 3/2/15.
//  Copyright (c) 2015 Bitcoin Authenticator. All rights reserved.
//

#import "BAPairingProtocol.h"

@implementation BAPairingProtocol

-(id)initWithData:(NSString*)qrData
{
    self = [super init];
    if(self) {
        data = qrData;
    }
    return self;
}

-(BAPairingData*)pairingData
{
    if(![self isValid]) return nil;
    BAPairingData *ret = [[BAPairingData alloc] init];
    
    NSArray *arr = [data componentsSeparatedByString:@"&"];
    
    ret.AESKey      = [arr[0] componentsSeparatedByString:@"="][1];
    ret.PubIP       = [arr[1] componentsSeparatedByString:@"="][1];
    ret.LocalIP     = [arr[2] componentsSeparatedByString:@"="][1];
    ret.pairingName = [arr[3] componentsSeparatedByString:@"="][1];
    ret.walletType  = [arr[4] componentsSeparatedByString:@"="][1];
    ret.netType     = [[arr[5] componentsSeparatedByString:@"="][1] intValue];
    ret.walletIdx   = [self getWalletIndexFromHex:[arr[6] componentsSeparatedByString:@"="][1]];
    
    return ret;
}

-(long)getWalletIndexFromHex:(NSString*)s
{
    NSScanner* pScanner = [NSScanner scannerWithString: s];
    
    unsigned long long iValue2;
    [pScanner scanHexLongLong: &iValue2];
    return iValue2;
}

-(BOOL)isValid
{
    if([data rangeOfString:@"AESKey"].location              == NSNotFound ||
       [data rangeOfString:@"&PublicIP"].location           == NSNotFound ||
       [data rangeOfString:@"&LocalIP"].location            == NSNotFound ||
       [data rangeOfString:@"&pairingName"].location        == NSNotFound ||
       [data rangeOfString:@"&WalletType"].location         == NSNotFound ||
       [data rangeOfString:@"&NetworkType"].location        == NSNotFound ||
       [data rangeOfString:@"&index"].location              == NSNotFound)
        return NO;
    return YES;
}

@end

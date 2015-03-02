//
//  authenticator.m
//  authenticator
//
//  Created by alon muroch on 2/26/15.
//  Copyright (c) 2015 Bitcoin Authenticator. All rights reserved.
//

#import "Authenticator.h"

@implementation Authenticator

+(BAPairingProtocol*)pair:(NSString*)data
{
    return [[BAPairingProtocol alloc] initWithData:data];
}

+(void)addPairing:(BAPairingData*)data
{
    
}

@end

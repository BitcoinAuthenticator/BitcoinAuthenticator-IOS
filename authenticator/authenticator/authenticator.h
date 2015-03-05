//
//  authenticator.h
//  authenticator
//
//  Created by alon muroch on 2/26/15.
//  Copyright (c) 2015 Bitcoin Authenticator. All rights reserved.
//

#include "AuthenticatorAppDelegateExtender.h"
#import "BAPairingData.h"
#import "BAPairingProtocol.h"

@interface Authenticator : NSObject

+(BAPairingProtocol*)pair:(NSString*)data;
//+(BOOL)addPairing:(BAPairingData*)data;
//
//+(NSArray*)fetchCDObjectWithName:(NSString*)name;

@end

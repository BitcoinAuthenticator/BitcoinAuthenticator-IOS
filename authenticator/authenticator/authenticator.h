//
//  authenticator.h
//  authenticator
//
//  Created by alon muroch on 2/26/15.
//  Copyright (c) 2015 Bitcoin Authenticator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAPairingProtocol.h"

@interface Authenticator : NSObject

+(BAPairingProtocol*)pair:(NSString*)data;
+(void)addPairing:(BAPairingData*)data;

@end

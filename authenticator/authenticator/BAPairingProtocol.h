//
//  BAPairingProtocol.h
//  authenticator
//
//  Created by alon muroch on 3/2/15.
//  Copyright (c) 2015 Bitcoin Authenticator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAPairingData.h"

@interface BAPairingProtocol : NSObject {
    NSString *data;
}

-(id)initWithData:(NSString*)qrData;
-(BOOL)isValid;
-(BAPairingData*)pairingData;

@end

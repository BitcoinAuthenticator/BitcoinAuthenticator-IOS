//
//  BAPairingData.h
//  authenticator
//
//  Created by alon muroch on 3/2/15.
//  Copyright (c) 2015 Bitcoin Authenticator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BAPairingData : NSObject

@property(nonatomic, strong) NSString *AESKey;
@property(nonatomic, strong) NSString *PubIP;
@property(nonatomic, strong) NSString *LocalIP;
@property(nonatomic, strong) NSString *walletType;
@property(nonatomic, strong) NSString *pairingName;
@property(nonatomic) int netType;
@property(nonatomic) long walletIdx;

@end

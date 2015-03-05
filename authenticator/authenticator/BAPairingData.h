//
//  BAPairingData.h
//  authenticator
//
//  Created by alon muroch on 3/4/15.
//  Copyright (c) 2015 Bitcoin Authenticator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BAPairingData : NSManagedObject

@property (nonatomic, retain) NSString * aesKey;
@property (nonatomic, retain) NSString * localIP;
@property (nonatomic, retain) NSNumber * netType;
@property (nonatomic, retain) NSString * pairingName;
@property (nonatomic, retain) NSString * pubIP;
@property (nonatomic, retain) NSNumber * walletIdx;
@property (nonatomic, retain) NSString * walletType;

@end

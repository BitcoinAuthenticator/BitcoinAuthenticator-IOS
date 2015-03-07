//
//  BAPairingData.h
//  authenticator
//
//  Created by alon muroch on 3/6/15.
//  Copyright (c) 2015 Bitcoin Authenticator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BARemoteNotificationData;

@interface BAPairingData : NSManagedObject

@property (nonatomic, retain) NSString * aesKey;
@property (nonatomic, retain) NSString * localIP;
@property (nonatomic, retain) NSNumber * netType;
@property (nonatomic, retain) NSString * pairingName;
@property (nonatomic, retain) NSString * pubIP;
@property (nonatomic, retain) NSNumber * walletIdx;
@property (nonatomic, retain) NSString * walletType;
@property (nonatomic, retain) NSOrderedSet *pendigNotifications;

@end

@interface BAPairingData (CoreDataGeneratedAccessors)

- (void)insertObject:(BARemoteNotificationData *)value inPendigNotificationsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromPendigNotificationsAtIndex:(NSUInteger)idx;
- (void)insertPendigNotifications:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removePendigNotificationsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInPendigNotificationsAtIndex:(NSUInteger)idx withObject:(BARemoteNotificationData *)value;
- (void)replacePendigNotificationsAtIndexes:(NSIndexSet *)indexes withPendigNotifications:(NSArray *)values;
- (void)addPendigNotificationsObject:(BARemoteNotificationData *)value;
- (void)removePendigNotificationsObject:(BARemoteNotificationData *)value;
- (void)addPendigNotifications:(NSOrderedSet *)values;
- (void)removePendigNotifications:(NSOrderedSet *)values;
@end

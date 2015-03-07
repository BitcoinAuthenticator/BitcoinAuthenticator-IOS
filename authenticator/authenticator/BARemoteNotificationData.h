//
//  BARemoteNotificationData.h
//  authenticator
//
//  Created by alon muroch on 3/6/15.
//  Copyright (c) 2015 Bitcoin Authenticator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BARemoteNotificationData : NSManagedObject

@property (nonatomic, retain) NSString * data;
@property (nonatomic, retain) NSNumber * type;

@end

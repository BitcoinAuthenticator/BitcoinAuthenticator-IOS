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

//+(BOOL)addPairing:(BAPairingData*)data
//{
//    return [self performSaveOnManagedObjectsContext];
//}

//
//+(BOOL)performSaveOnManagedObjectsContext {
//    NSManagedObjectContext *context = [(AuthenticatorAppDelegateExtender*)[[UIApplication sharedApplication] delegate] managedObjectContext];
//    NSError *error;
//    if (![context save:&error]) {
//        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
//        return NO;
//    }
//    return YES;
//}
//
//+(NSArray*)fetchCDObjectWithName:(NSString*)name
//{
//    NSManagedObjectContext *context = [(AuthenticatorAppDelegateExtender*)[[UIApplication sharedApplication] delegate] managedObjectContext];
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription
//                                   entityForName:name inManagedObjectContext:context];
//    [fetchRequest setEntity:entity];
//    NSError *error;
//    
//    return [context executeFetchRequest:fetchRequest error:&error];
//}

@end

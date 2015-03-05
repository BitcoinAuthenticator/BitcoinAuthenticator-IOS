//
//  NSManagedObject+Sugar.m
//
//  Created by Aaron Voisine on 8/22/13.
//  Copyright (c) 2013 Aaron Voisine <voisine@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import "NSManagedObject+Manager.h"

static NSManagedObjectContextConcurrencyType _concurrencyType = NSMainQueueConcurrencyType;
static NSUInteger _fetchBatchSize = 100;

@implementation NSManagedObject (Manager)

#pragma mark - create objects

+ (instancetype)_managedObject
{
    __block NSEntityDescription *entity = nil;
    __block NSManagedObject *obj = nil;
    
    [[self _context] performBlockAndWait:^{
        entity = [NSEntityDescription entityForName:[self _entityName] inManagedObjectContext:[self _context]];
        obj = [[self alloc] initWithEntity:entity insertIntoManagedObjectContext:[self _context]];
    }];
    
    return obj;
}

+ (NSArray *)_managedObjectArrayWithLength:(NSUInteger)length
{
    __block NSEntityDescription *entity = nil;
    NSMutableArray *a = [NSMutableArray arrayWithCapacity:length];
    
    [[self _context] performBlockAndWait:^{
        entity = [NSEntityDescription entityForName:[self _entityName] inManagedObjectContext:[self _context]];
        
        for (NSUInteger i = 0; i < length; i++) {
            [a addObject:[[self alloc] initWithEntity:entity insertIntoManagedObjectContext:[self _context]]];
        }
    }];
    
    return a;
}

#pragma mark - fetch existing objects

+ (NSArray *)_allObjects
{
    return [self _fetchObjects:[self _fetchRequest]];
}

+ (NSArray *)_objectsMatching:(NSString *)predicateFormat, ...
{
    NSArray *a;
    va_list args;
    
    va_start(args, predicateFormat);
    a = [self _objectsMatching:predicateFormat arguments:args];
    va_end(args);
    return a;
}

+ (NSArray *)_objectsMatching:(NSString *)predicateFormat arguments:(va_list)args
{
    NSFetchRequest *request = [self _fetchRequest];
    
    request.predicate = [NSPredicate predicateWithFormat:predicateFormat arguments:args];
    return [self _fetchObjects:request];
}

+ (NSArray *)_objectsSortedBy:(NSString *)key ascending:(BOOL)ascending
{
    return [self _objectsSortedBy:key ascending:ascending offset:0 limit:0];
}

+ (NSArray *)_objectsSortedBy:(NSString *)key ascending:(BOOL)ascending offset:(NSUInteger)offset limit:(NSUInteger)limit
{
    NSFetchRequest *request = [self _fetchRequest];
    
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:key ascending:ascending]];
    request.fetchOffset = offset;
    request.fetchLimit = limit;
    return [self _fetchObjects:request];
}

+ (NSArray *)_fetchObjects:(NSFetchRequest *)request
{
    __block NSArray *a = nil;
    __block NSError *error = nil;
    
    [[self _context] performBlockAndWait:^{
        a = [[self _context] executeFetchRequest:request error:&error];
        if (error) NSLog(@"%s:%d %s: %@", __FILE__, __LINE__, __FUNCTION__, error);
    }];
    
    return a;
}

#pragma mark - count exising objects

+ (NSUInteger)_countAllObjects
{
    return [self _countObjects:[self _fetchRequest]];
}

+ (NSUInteger)_countObjectsMatching:(NSString *)predicateFormat, ...
{
    NSUInteger count;
    va_list args;
    
    va_start(args, predicateFormat);
    count = [self _countObjectsMatching:predicateFormat arguments:args];
    va_end(args);
    return count;
}

+ (NSUInteger)_countObjectsMatching:(NSString *)predicateFormat arguments:(va_list)args
{
    NSFetchRequest *request = [self _fetchRequest];
    
    request.predicate = [NSPredicate predicateWithFormat:predicateFormat arguments:args];
    return [self _countObjects:request];
}

+ (NSUInteger)_countObjects:(NSFetchRequest *)request
{
    __block NSUInteger count = 0;
    __block NSError *error = nil;
    
    [[self _context] performBlockAndWait:^{
        count = [[self _context] countForFetchRequest:request error:&error];
        if (error) NSLog(@"%s:%d %s: %@", __FILE__, __LINE__, __FUNCTION__, error);
    }];
    
    return count;
}

#pragma mark - delete objects

+ (NSUInteger)_deleteObjects:(NSArray *)objects
{
    [[self _context] performBlockAndWait:^{
        for (NSManagedObject *obj in objects) {
            [[self _context] deleteObject:obj];
        }
    }];
    
    return objects.count;
}

#pragma mark - core data stack

// call this before any NSManagedObject+Sugar methods to use a concurrency type other than NSMainQueueConcurrencyType
+ (void)_setConcurrencyType:(NSManagedObjectContextConcurrencyType)type
{
    _concurrencyType = type;
}

// set the fetchBatchSize to use when fetching objects, default is 100
+ (void)_setFetchBatchSize:(NSUInteger)fetchBatchSize
{
    _fetchBatchSize = fetchBatchSize;
}

// returns the managed object context for the application, or if the context doesn't already exist, creates it and binds
// it to the persistent store coordinator for the application
+ (NSManagedObjectContext *)_context
{
    static dispatch_once_t onceToken = 0;
    
    dispatch_once(&onceToken, ^{
//        NSURL *docURL =
//        [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].lastObject;
//        NSURL *modelURL = [NSBundle.mainBundle URLsForResourcesWithExtension:@"momd" subdirectory:nil].lastObject;
//        NSString *projName = [[modelURL lastPathComponent] stringByDeletingPathExtension];
//        NSURL *storeURL = [[docURL URLByAppendingPathComponent:projName] URLByAppendingPathExtension:@"sqlite"];
        
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"authenticatorBundle"  ofType:@"bundle"];
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
        NSString *modelPath = [bundle pathForResource:@"authenticator" ofType:@"momd"];
        NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
        
        NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
        NSPersistentStoreCoordinator *coordinator =
        [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
        NSError *error = nil;
        
        NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"authenticator.sqlite"];
        if ([coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL
                                            options:@{NSMigratePersistentStoresAutomaticallyOption:@(YES),
                                                      NSInferMappingModelAutomaticallyOption:@(YES)} error:&error] == nil) {
            NSLog(@"%s:%d %s: %@", __FILE__, __LINE__, __FUNCTION__, error);
#if DEBUG
            abort();
#endif
            // if this is a not a debug build, attempt to delete and create a new persisent data store before crashing
            if (! [[NSFileManager defaultManager] removeItemAtURL:storeURL error:&error]) {
                NSLog(@"%s:%d %s: %@", __FILE__, __LINE__, __FUNCTION__, error);
            }
            
            if ([coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL
                                                options:@{NSMigratePersistentStoresAutomaticallyOption:@(YES),
                                                          NSInferMappingModelAutomaticallyOption:@(YES)} error:&error] == nil) {
                NSLog(@"%s:%d %s: %@", __FILE__, __LINE__, __FUNCTION__, error);
                abort(); // Forsooth, I am slain!
            }
        }
        
        if (coordinator) {
            NSManagedObjectContext *writermoc = nil, *mainmoc = nil;
            
            // create a separate context for writing to the persistent store asynchronously
            writermoc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
            writermoc.persistentStoreCoordinator = coordinator;
            
            mainmoc = [[NSManagedObjectContext alloc] initWithConcurrencyType:_concurrencyType];
            mainmoc.parentContext = writermoc;
            
            [NSManagedObject _setContext:mainmoc];
            
            // this will save changes to the persistent store before the application terminates
            [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillTerminateNotification object:nil
                                                               queue:nil usingBlock:^(NSNotification *note) {
                                                                   [self _saveContext];
                                                               }];
        }
    });
    
    NSManagedObjectContext *context = objc_getAssociatedObject(self, @selector(_context));
    
    if (! context && self != [NSManagedObject class]) {
        context = [NSManagedObject _context];
        [self _setContext:context];
    }
    
    return (context == (id)[NSNull null]) ? nil : context;
}

// sets a different context for NSManagedObject+Sugar methods to use for this type of entity
+ (void)_setContext:(NSManagedObjectContext *)context
{
    objc_setAssociatedObject(self, @selector(_context), context ? context : [NSNull null],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// persists changes (this is called automatically for the main context when the app terminates)
+ (void)_saveContext
{
    if (! [[self _context] hasChanges]) return;
    
    [[self _context] performBlock:^{
        NSError *error = nil;
        
        if ([[self _context] hasChanges] && ! [[self _context] save:&error]) { // save changes to writer context
            NSLog(@"%s:%d %s: %@", __FILE__, __LINE__, __FUNCTION__, error);
#if DEBUG
            abort();
#endif
        }
        
        [[self _context].parentContext performBlock:^{
            NSError *error = nil;
            NSUInteger taskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{}];
            
            // write changes to persistent store
            if ([[self _context].parentContext hasChanges] && ! [[self _context].parentContext save:&error]) {
                NSLog(@"%s:%d %s: %@", __FILE__, __LINE__, __FUNCTION__, error);
#if DEBUG
                abort();
#endif
            }
            
            [[UIApplication sharedApplication] endBackgroundTask:taskId];
        }];
    }];
}

#pragma mark - entity methods

// override this if entity name differs from class name
+ (NSString *)_entityName
{
    return NSStringFromClass([self class]);
}

+ (NSFetchRequest *)_fetchRequest
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:[self _entityName]];
    
    request.fetchBatchSize = _fetchBatchSize;
    return request;
}

+ (NSFetchedResultsController *)_fetchedResultsController:(NSFetchRequest *)request
{
    return [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:[self _context]
                                                 sectionNameKeyPath:nil cacheName:nil];
}

// id value = entity[@"key"]; thread safe valueForKey:
- (id)_objectForKeyedSubscript:(id<NSCopying>)key
{
    __block id obj = nil;
    
    [[self managedObjectContext] performBlockAndWait:^{
        obj = [self valueForKey:(NSString *)key];
    }];
    
    return obj;
}

// entity[@"key"] = value; thread safe setValue:forKey:
- (void)_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key
{
    [[self managedObjectContext] performBlockAndWait:^{
        [self setValue:obj forKey:(NSString *)key];
    }];
}

- (void)_deleteObject
{
    [[self managedObjectContext] performBlockAndWait:^{
        [[self managedObjectContext] deleteObject:self];
    }];
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
+(NSURL *)applicationDocumentsDirectory{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end

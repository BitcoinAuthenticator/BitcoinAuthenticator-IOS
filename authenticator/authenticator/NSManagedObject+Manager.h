//
//  NSManagedObject+Sugar.h
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

#import <CoreData/CoreData.h>

@interface NSManagedObject (Manager)

// create objects
+ (instancetype)_managedObject;
+ (NSArray *)_managedObjectArrayWithLength:(NSUInteger)length;

// fetch existing objects
+ (NSArray *)_allObjects;
+ (NSArray *)_objectsMatching:(NSString *)predicateFormat, ...;
+ (NSArray *)_objectsMatching:(NSString *)predicateFormat arguments:(va_list)args;
+ (NSArray *)_objectsSortedBy:(NSString *)key ascending:(BOOL)ascending;
+ (NSArray *)_objectsSortedBy:(NSString *)key ascending:(BOOL)ascending offset:(NSUInteger)offset limit:(NSUInteger)lim;
+ (NSArray *)_fetchObjects:(NSFetchRequest *)request;

// count existing objects
+ (NSUInteger)_countAllObjects;
+ (NSUInteger)_countObjectsMatching:(NSString *)predicateFormat, ...;
+ (NSUInteger)_countObjectsMatching:(NSString *)predicateFormat arguments:(va_list)args;
+ (NSUInteger)_countObjects:(NSFetchRequest *)request;

// delete objects
+ (NSUInteger)_deleteObjects:(NSArray *)objects;

// call this before any NSManagedObject+Sugar methods to use a concurrency type other than NSMainQueueConcurrencyType
+ (void)_setConcurrencyType:(NSManagedObjectContextConcurrencyType)type;

// set the fetchBatchSize to use when fetching objects, default is 100
+ (void)_setFetchBatchSize:(NSUInteger)fetchBatchSize;

// returns the managed object context for the application, or if the context doesn't already exist, creates it and binds
// it to the persistent store coordinator for the application
+ (NSManagedObjectContext *)_context;

// sets a different context for NSManagedObject+Sugar methods to use for this type of entity
+ (void)_setContext:(NSManagedObjectContext *)context;

+ (void)_saveContext; // persists changes (this is called automatically for the main context when the app terminates)

+ (NSString *)_entityName; // override this if entity name differs from class name
+ (NSFetchRequest *)_fetchRequest;
+ (NSFetchedResultsController *)_fetchedResultsController:(NSFetchRequest *)request;

- (id)_objectForKeyedSubscript:(id<NSCopying>)key; // id value = entity[@"key"]; thread safe valueForKey:
- (void)_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key; // entity[@"key"] = value; thread safe setValue:forKey:
- (void)_deleteObject;

@end

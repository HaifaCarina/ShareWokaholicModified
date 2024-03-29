//
//  AppDelegate.h
//  ShareWokaholicModified
//
//  Created by Haifa Carina Baluyos on 11/5/12.
//  Copyright (c) 2012 NMG Resources, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    RootViewController *viewController;
    
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) RootViewController *viewController;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

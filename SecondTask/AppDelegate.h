//
//  AppDelegate.h
//  SecondTask
//
//  Created by A-Team Intern on 3.08.21.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;
@end


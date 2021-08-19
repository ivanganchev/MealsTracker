//
//  CoreDataManager.h
//  SecondTask
//
//  Created by A-Team Intern on 19.08.21.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Meal.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataManager : NSObject
@property AppDelegate *appDelegate;
@property NSManagedObjectContext *context;
@property NSManagedObject *mealEntityManagedObject;

-(instancetype)init;
-(void)addMealEntityEntry:(Meal *)entry;
-(void)removeEntryById:(NSUUID *)identification entityName:(NSString *)entityName;
-(NSMutableArray*)fetchAllEntries:(NSString *)entityName;
@end



NS_ASSUME_NONNULL_END

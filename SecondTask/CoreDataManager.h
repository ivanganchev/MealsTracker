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
@property NSFetchRequest *requestMeals;
@property AppDelegate *appDelegate;
@property NSManagedObjectContext *context;
@property NSManagedObject *mealEntityManagedObject;
@property NSEntityDescription *mealEntityDescription;
@property NSString *entityName;

-(instancetype)initWithEntityName:(NSString *)entity;
-(void)addEntityEntry:(Meal *)entry;
-(void)removeEntryById:(NSUUID *)identification;
-(NSMutableArray*)fetchAllEntries;
@end



NS_ASSUME_NONNULL_END

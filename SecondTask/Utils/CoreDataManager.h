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

-(instancetype)init;
-(void)addMealEntityEntry:(Meal *)entry;
-(void)removeEntryById:(NSUUID *)identification entityName:(NSString *)entityName;
-(NSArray*)fetchAllEntries:(NSString *)entityName;
-(NSArray*)fetchEntriesByDate:(NSString *)entityName date:(NSString *)date;
-(void)updateEntryById:(NSUUID *)identification entityName:(NSString *)entityName
    meal:(Meal *)meal;
-(NSArray*)fetchAllEntriesExcept:(NSString *)entityName
                               mealType:(NSString *)mealType;
-(NSArray*)convertMealEntityArrayToMealArray:(NSArray *)array;
@end



NS_ASSUME_NONNULL_END

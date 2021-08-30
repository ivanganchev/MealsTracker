//
//  CoreDataManager.m
//  SecondTask
//
//  Created by A-Team Intern on 19.08.21.
//

#import "CoreDataManager.h"
#import "Meal.h"
@interface CoreDataManager ()
@property AppDelegate *appDelegate;
@property NSManagedObjectContext *context;
@end

@implementation CoreDataManager

-(instancetype)init {
    self = [super init];
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.context = self.appDelegate.persistentContainer.viewContext;
    return self;
}

-(void)addMealEntityEntry:(Meal *)entry {
    
    NSManagedObject *mealEntityManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"MealEntity" inManagedObjectContext:self.context];
    
    [mealEntityManagedObject setValue:entry.mealType forKey:@"mealType"];
    [mealEntityManagedObject setValue:entry.title forKey:@"title"];
    [mealEntityManagedObject setValue:[NSNumber numberWithInteger:entry.servingsPerDay] forKey:@"servingsPerDay"];
    [mealEntityManagedObject setValue:entry.dayTime forKey:@"dayTime"];
    [mealEntityManagedObject setValue:entry.date forKey:@"date"];
    [mealEntityManagedObject setValue:[NSUUID UUID] forKey:@"identification"];
    
    [self.appDelegate saveContext];
}

-(void)removeEntryById:(NSUUID *)identification entityName:(NSString *)entityName {
    NSFetchRequest *requestMeals = [NSFetchRequest fetchRequestWithEntityName:entityName];
    NSEntityDescription *mealEntityDescription = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"identification == %@", identification];
    [requestMeals setEntity:mealEntityDescription];
    [requestMeals setPredicate:predicate];

    NSError *error;
    NSArray *items = [NSArray arrayWithArray:[self.context executeFetchRequest:requestMeals error:&error]];

    for(NSManagedObject *managedObj in items) {
        [self.context deleteObject:managedObj];
    }
    
    [self.appDelegate saveContext];
    
}

-(NSArray*)fetchAllEntries:(NSString *)entityName {
    NSFetchRequest *requestMeals = [NSFetchRequest fetchRequestWithEntityName:entityName];
    return [self convertMealEntityArrayToMealArray:[NSArray arrayWithArray:[self.context executeFetchRequest:requestMeals error:nil]]];
}

-(NSArray*)fetchEntriesByDate:(NSString *)entityName date:(NSString *)date {
    NSFetchRequest *requestMeals = [NSFetchRequest fetchRequestWithEntityName:entityName];
    NSEntityDescription *mealEntityDescription = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"date == %@", date];
    [requestMeals setEntity:mealEntityDescription];
    [requestMeals setPredicate:predicate];

    NSError *error;
    NSArray *items = [self convertMealEntityArrayToMealArray:[NSArray arrayWithArray:[self.context executeFetchRequest:requestMeals error:&error]]];
    
    return items;
}

-(void)updateEntryById:(NSUUID *)identification
            entityName:(NSString *)entityName
                  meal:(Meal *)meal{
    NSFetchRequest *requestMeals = [NSFetchRequest fetchRequestWithEntityName:entityName];
    NSEntityDescription *mealEntityDescription = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"identification == %@", identification];
    
    [requestMeals setEntity:mealEntityDescription];
    [requestMeals setPredicate:predicate];
    [requestMeals setFetchLimit:1];
    
    NSError *error;
    NSMutableArray *items = [NSMutableArray arrayWithArray:[self.context executeFetchRequest:requestMeals error:&error]];
    
    MealEntity *e = items[0];
    e.title = meal.title;
    e.mealType = meal.mealType;
    e.dayTime = meal.dayTime;
    e.servingsPerDay = meal.servingsPerDay;
    
    [self.appDelegate saveContext];
}

-(NSArray *)fetchAllEntriesExcept:(NSString *)entityName mealType:(NSString *)mealType {
    NSFetchRequest *requestMeals = [NSFetchRequest fetchRequestWithEntityName:entityName];
    NSEntityDescription *mealEntityDescription = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"NOT (mealType CONTAINS %@)", mealType];
    [requestMeals setEntity:mealEntityDescription];
    [requestMeals setPredicate:predicate];

    NSError *error;
    NSArray *items = [self convertMealEntityArrayToMealArray:[NSArray arrayWithArray:[self.context executeFetchRequest:requestMeals error:&error]]];
    
    
    return items;
}

-(NSArray*)convertMealEntityArrayToMealArray:(NSArray *)array {
    NSMutableArray<Meal*>* newArray = [[NSMutableArray alloc] init];
    for(MealEntity *e in array) {
        Meal* m = [[Meal alloc] initWithEntityObject:e];
        [newArray addObject:m];
    }
    
    return [newArray copy];
}
@end

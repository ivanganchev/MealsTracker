//
//  CoreDataManager.m
//  SecondTask
//
//  Created by A-Team Intern on 19.08.21.
//

#import "CoreDataManager.h"

@implementation CoreDataManager

-(instancetype)init {
    self = [super init];
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.context = self.appDelegate.persistentContainer.viewContext;
    return self;
}

-(void)addMealEntityEntry:(Meal *)entry {
    self.mealEntityManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"MealEntity" inManagedObjectContext:self.context];
    
    [self.mealEntityManagedObject setValue:entry.mealType forKey:@"mealType"];
    [self.mealEntityManagedObject setValue:entry.title forKey:@"title"];
    [self.mealEntityManagedObject setValue:[NSNumber numberWithInteger:entry.servingsPerDay] forKey:@"servingsPerDay"];
    [self.mealEntityManagedObject setValue:entry.dayTime forKey:@"dayTime"];
    [self.mealEntityManagedObject setValue:@"today" forKey:@"date"];
    [self.mealEntityManagedObject setValue:[NSUUID UUID] forKey:@"identification"];
    
    [self.appDelegate saveContext];
}

-(void)removeEntryById:(NSUUID *)identification entityName:(NSString *)entityName {
    NSFetchRequest *requestMeals = [NSFetchRequest fetchRequestWithEntityName:entityName];
    NSEntityDescription *mealEntityDescription = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"identification == %@", identification];
    [requestMeals setEntity:mealEntityDescription];
    [requestMeals setPredicate:predicate];

    NSError *error;
    NSMutableArray *items = [NSMutableArray arrayWithArray:[self.context executeFetchRequest:requestMeals error:&error]];

    for(NSManagedObject *managedObj in items) {
        [self.context deleteObject:managedObj];
    }
    
    [self.appDelegate saveContext];
    
}

-(NSMutableArray*)fetchAllEntries:(NSString *)entityName{
    NSFetchRequest *requestMeals = [NSFetchRequest fetchRequestWithEntityName:entityName];
    return [NSMutableArray arrayWithArray:[self.context executeFetchRequest:requestMeals error:nil]];
}

@end

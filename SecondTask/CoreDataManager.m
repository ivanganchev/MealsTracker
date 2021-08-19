//
//  CoreDataManager.m
//  SecondTask
//
//  Created by A-Team Intern on 19.08.21.
//

#import "CoreDataManager.h"

@implementation CoreDataManager

-(instancetype)initWithEntityName:(NSString *)entity {
    self = [super init];
    
    self.entityName = entity;
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.context = self.appDelegate.persistentContainer.viewContext;
    self.requestMeals = [NSFetchRequest fetchRequestWithEntityName:entity];
    self.mealEntityDescription = [NSEntityDescription entityForName:entity inManagedObjectContext:self.context];
    return self;
}

-(void)addEntityEntry:(Meal *)entry {
    self.mealEntityManagedObject = [NSEntityDescription insertNewObjectForEntityForName:self.entityName inManagedObjectContext:self.context];
    
    [self.mealEntityManagedObject setValue:entry.mealType forKey:@"mealType"];
    [self.mealEntityManagedObject setValue:entry.title forKey:@"title"];
    [self.mealEntityManagedObject setValue:[NSNumber numberWithInteger:entry.servingsPerDay] forKey:@"servingsPerDay"];
    [self.mealEntityManagedObject setValue:entry.dayTime forKey:@"dayTime"];
    [self.mealEntityManagedObject setValue:@"today" forKey:@"date"];
    [self.mealEntityManagedObject setValue:[NSUUID UUID] forKey:@"identification"];
    
    [self.appDelegate saveContext];
}

-(void)removeEntryById:(NSUUID *)identification {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"identification == %@", identification];
    [self.requestMeals setEntity:self.mealEntityDescription];
    [self.requestMeals setPredicate:predicate];

    NSError *error;
    NSMutableArray *items = [NSMutableArray arrayWithArray:[self.context executeFetchRequest:self.requestMeals error:&error]];

    for(NSManagedObject *managedObj in items) {
        [self.context deleteObject:managedObj];
    }
    
    [self.appDelegate saveContext];
    
}

-(NSMutableArray*)fetchAllEntries {
    self.requestMeals.predicate = nil;
    return [NSMutableArray arrayWithArray:[self.context executeFetchRequest:self.requestMeals error:nil]];
}

@end

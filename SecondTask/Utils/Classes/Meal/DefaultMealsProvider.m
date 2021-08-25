//
//  DefaultMealsProvider.m
//  SecondTask
//
//  Created by A-Team Intern on 24.08.21.
//

#import "DefaultMealsProvider.h"
#import "Meal.h"

@interface DefaultMealsProvider ()
@property NSMutableArray *defaultMeals;
@end

@implementation DefaultMealsProvider

-(instancetype)initDefaultMeals {
    self.defaultMeals = [[NSMutableArray alloc] init];
    
    [self.defaultMeals insertObject:[[Meal alloc] initWithTitle:@"Beef with brocolli" mealType:@"Steak" date:@"" servingsPerDay:1 dayTime:@"Lunch"] atIndex:0];
    [self.defaultMeals insertObject:[[Meal alloc] initWithTitle:@"Tuna salad" mealType:@"Fish" date:@"" servingsPerDay:1 dayTime:@"Breakfast"] atIndex:1];
    [self.defaultMeals insertObject:[[Meal alloc] initWithTitle:@"Chicken Pasta" mealType:@"Chicken" date:@"" servingsPerDay:1 dayTime:@"Lunch"] atIndex:2];
    [self.defaultMeals insertObject:[[Meal alloc] initWithTitle:@"Moussaka" mealType:@"Vegan" date:@"" servingsPerDay:1 dayTime:@"Dinner"] atIndex:3];
    [self.defaultMeals insertObject:[[Meal alloc] initWithTitle:@"Banitsa" mealType:@"Vegeterian" date:@"" servingsPerDay:1 dayTime:@"Breakfast"] atIndex:4];
    return self;
}

-(NSMutableArray *)getDefaultMeals {
    return self.defaultMeals;
}

-(NSMutableArray *)getFilteredDefaultMeals:(NSString *)mealType {
    NSMutableArray *filteredMeals = [[NSMutableArray alloc] init];
    for(int i = 0; i < self.defaultMeals.count; i++){
        Meal *m = [self.defaultMeals objectAtIndex:i];
        if(![m.mealType isEqual:mealType]) {
            [filteredMeals addObject:m];
        }
    }
    return filteredMeals;
}
@end

//
//  DefaultMealsProvider.m
//  SecondTask
//
//  Created by A-Team Intern on 24.08.21.
//

#import "DefaultMealsProvider.h"
#import "Meal.h"

@interface DefaultMealsProvider ()
@property(strong, nonatomic, readwrite) NSArray *defaultMeals;
@end

@implementation DefaultMealsProvider

-(instancetype)initDefaultMeals {
    self = [super init];
    
    self.defaultMeals = [[NSMutableArray alloc] initWithObjects:[[Meal alloc] initWithTitle:@"Beef with brocolli" mealType:@"Steak" date:@"" servingsPerDay:1 dayTime:@"Lunch"], [[Meal alloc] initWithTitle:@"Tuna salad" mealType:@"Fish" date:@"" servingsPerDay:1 dayTime:@"Breakfast"], [[Meal alloc] initWithTitle:@"Chicken Pasta" mealType:@"Chicken" date:@"" servingsPerDay:1 dayTime:@"Lunch"], [[Meal alloc] initWithTitle:@"Moussaka" mealType:@"Vegan" date:@"" servingsPerDay:1 dayTime:@"Dinner"], [[Meal alloc] initWithTitle:@"Banitsa" mealType:@"Vegeterian" date:@"" servingsPerDay:1 dayTime:@"Breakfast"],  nil];
    return self;
}

-(NSArray *)getDefaultMeals {
    return self.defaultMeals;
}

-(NSArray *)getFilteredDefaultMealsByType:(NSString *)mealType {
    NSMutableArray *filteredMeals = [[NSMutableArray alloc] init];
    for(int i = 0; i < self.defaultMeals.count; i++){
        Meal *m = [self.defaultMeals objectAtIndex:i];
        if(![m.mealType isEqual:mealType]) {
            [filteredMeals addObject:m];
        }
    }
    return [filteredMeals copy];
}
@end

//
//  MealsUIResources.m
//  SecondTask
//
//  Created by A-Team Intern on 23.08.21.
//

#import "MealsUIResources.h"

@implementation MealsUIResources
-(instancetype)initMealTypes {
    
    self.mealsTypes = [[NSMutableArray alloc] init];
   
    [self.mealsTypes addObject:[[MealType alloc] initWithIcon:@"steak" mealType:@"Steak"]];
    [self.mealsTypes addObject:[[MealType alloc] initWithIcon:@"chicken" mealType:@"Chicken"]];
    [self.mealsTypes addObject:[[MealType alloc] initWithIcon:@"fish" mealType:@"Fish"]];
    [self.mealsTypes addObject:[[MealType alloc] initWithIcon:@"vegetarian" mealType:@"Vegeterian"]];
    [self.mealsTypes addObject:[[MealType alloc] initWithIcon:@"vegan" mealType:@"vegan"]];
    
     return self;
}
@end

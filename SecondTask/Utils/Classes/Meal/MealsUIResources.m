//
//  MealsUIResources.m
//  SecondTask
//
//  Created by A-Team Intern on 23.08.21.
//

#import "MealsUIResources.h"
@interface  MealsUIResources ()
@property(strong, nonatomic, readwrite) NSMutableArray<MealType*> *mealsTypes;
@end

@implementation MealsUIResources
-(instancetype)initMealTypes {
    
    self.mealsTypes = [[NSMutableArray alloc] init];
   
    [self.mealsTypes addObject:[[MealType alloc] initWithIcon:@"steak" mealType:@"Steak"]];
    [self.mealsTypes addObject:[[MealType alloc] initWithIcon:@"chicken" mealType:@"Chicken"]];
    [self.mealsTypes addObject:[[MealType alloc] initWithIcon:@"fish" mealType:@"Fish"]];
    [self.mealsTypes addObject:[[MealType alloc] initWithIcon:@"vegetarian" mealType:@"Vegeterian"]];
    [self.mealsTypes addObject:[[MealType alloc] initWithIcon:@"vegan" mealType:@"Vegan"]];
    
     return self;
}
@end

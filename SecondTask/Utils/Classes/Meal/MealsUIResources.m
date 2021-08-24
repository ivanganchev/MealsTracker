//
//  MealsUIResources.m
//  SecondTask
//
//  Created by A-Team Intern on 23.08.21.
//

#import "MealsUIResources.h"

@implementation MealsUIResources
-(instancetype)initMealTypes {
    NSArray *mealTypes = [NSArray arrayWithObjects:@"Steak", @"Chicken", @"Fish", @"Vegeterian", @"Vegan", nil];
    NSArray *mealTypesIcons = [NSArray arrayWithObjects:@"steak", @"chicken", @"fish", @"vegetarian", @"vegan", nil];
    
    self.mealsTypes = [[NSMutableArray alloc] init];
   
    for(int i = 0; i < mealTypes.count; i++) {
        MealType *m = [[MealType alloc] initWithIcon:[mealTypesIcons objectAtIndex:i] mealType:[mealTypes objectAtIndex:i]];
        [self.mealsTypes addObject:m];
    }
    
     return self;
}
@end

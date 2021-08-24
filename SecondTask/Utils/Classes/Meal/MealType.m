//
//  MealType.m
//  SecondTask
//
//  Created by A-Team Intern on 23.08.21.
//

#import "MealType.h"

@implementation MealType

-(instancetype)initWithIcon:(NSString *)icon mealType:(NSString *)mealType {
    self.mealIconName = icon;
    self.mealTypeName = mealType;
    
    return self;
}
@end

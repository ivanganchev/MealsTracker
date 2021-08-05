//
//  Meal.m
//  SecondTask
//
//  Created by A-Team Intern on 5.08.21.
//

#import "Meal.h"

@implementation Meal
    
-(instancetype) initWithTitle:(NSString *)title mealType:(NSString *) mealType date:(NSString *)date servingsPerWeek:(NSInteger )servingsPerWeek {
    self = [super init];
    
    if(self) {
        self.title = title;
        self.mealType = mealType;
        self.date = date;
        self.servingsPerWeek = servingsPerWeek;
    }

    return self;
}
@end

//
//  Meal.m
//  SecondTask
//
//  Created by A-Team Intern on 5.08.21.
//

#import "Meal.h"

@implementation Meal
    
-(instancetype) initWithTitle:(NSString *)title mealType:(NSString *) mealType date:(NSString *)date servingsPerDay:(NSInteger)servingsPerDay
                     dayTime:(NSString *) dayTime {
    self = [super init];
    
    if(self) {
        self.title = title;
        self.mealType = mealType;
        self.date = date;
        self.servingsPerDay = servingsPerDay;
        self.dayTime = dayTime;
        self.identificaiton = [NSUUID UUID];
    }

    return self;
}

-(instancetype) initWithEntityObject:(MealEntity *)entity {
    self.title = entity.title;
    self.mealType = entity.mealType;
    self.date = entity.date;
    self.servingsPerDay = entity.servingsPerDay;
    self.dayTime = entity.dayTime;
    self.identificaiton = entity.identification;
    return self;
}

@end

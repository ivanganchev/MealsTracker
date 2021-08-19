//
//  Meal.h
//  SecondTask
//
//  Created by A-Team Intern on 5.08.21.
//

#import <Foundation/Foundation.h>
#import "MealEntity+CoreDataProperties.h"

NS_ASSUME_NONNULL_BEGIN

@interface Meal : NSObject

@property NSString *title;
@property NSString *mealType;
@property NSString *date;
@property NSInteger servingsPerDay;
@property NSString *dayTime;
@property NSUUID *identificaiton;

-(instancetype) initWithTitle:(NSString *)title mealType:(NSString *) mealType date:(NSString *)date servingsPerDay:(NSInteger)servingsPerDay dayTime:(NSString *) dayTime;

-(instancetype) initWithEntityObject:(MealEntity *)entity;

@end


NS_ASSUME_NONNULL_END

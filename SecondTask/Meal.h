//
//  Meal.h
//  SecondTask
//
//  Created by A-Team Intern on 5.08.21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Meal : NSObject

@property NSString *title;
@property NSString *mealType;
@property NSString *date;
@property NSInteger servingsPerWeek;
@property NSString *dayTime;

-(instancetype) initWithTitle:(NSString *)title mealType:(NSString *) mealType date:(NSString *)date servingsPerWeek:(NSInteger)servingsPerWeek dayTime:(NSString *) dayTime;

@end

NS_ASSUME_NONNULL_END

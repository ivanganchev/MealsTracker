//
//  DefaultMealsProvider.h
//  SecondTask
//
//  Created by A-Team Intern on 24.08.21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DefaultMealsProvider : NSObject
-(instancetype)initDefaultMeals;
-(NSMutableArray *)getDefaultMeals;
-(NSMutableArray *)getFilteredDefaultMeals:(NSString *)mealType;
@end

NS_ASSUME_NONNULL_END

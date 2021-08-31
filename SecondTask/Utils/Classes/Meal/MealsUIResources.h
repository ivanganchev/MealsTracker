//
//  MealsUIResources.h
//  SecondTask
//
//  Created by A-Team Intern on 23.08.21.
//

#import <Foundation/Foundation.h>
#import "MealType.h"
NS_ASSUME_NONNULL_BEGIN

@interface MealsUIResources : NSObject
@property(strong, nonatomic, readonly) NSMutableArray<MealType*> *mealsTypes;
-(instancetype) initMealTypes;
@end

NS_ASSUME_NONNULL_END

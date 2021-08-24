//
//  MealType.h
//  SecondTask
//
//  Created by A-Team Intern on 23.08.21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MealType : NSObject
@property NSString *mealIconName;
@property NSString *mealTypeName;

-(instancetype)initWithIcon:(NSString *)icon mealType:(NSString *)mealType;
@end

NS_ASSUME_NONNULL_END

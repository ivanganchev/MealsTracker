//
//  ExistingMealsViewController.h
//  SecondTask
//
//  Created by A-Team Intern on 20.08.21.
//

#import <UIKit/UIKit.h>
#import "Meal.h"

NS_ASSUME_NONNULL_BEGIN
@protocol ExistingMealsViewControllerDelegate;

@interface ExistingMealsViewController : UIViewController
@property  (weak, nonatomic) id<ExistingMealsViewControllerDelegate> delegate;
@end

@protocol ExistingMealsViewControllerDelegate <NSObject>
-(void)existingMealsViewController:(ExistingMealsViewController *)viewController didSelectMeal:(Meal *)meal;
@end
NS_ASSUME_NONNULL_END

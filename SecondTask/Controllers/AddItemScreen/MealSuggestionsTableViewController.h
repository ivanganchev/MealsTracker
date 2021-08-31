//
//  MealSuggestionsTableViewController.h
//  SecondTask
//
//  Created by A-Team Intern on 24.08.21.
//

#import <UIKit/UIKit.h>
#import "Meal.h"

NS_ASSUME_NONNULL_BEGIN
@protocol MealSuggestionsTableViewControllerDelegate;

@interface MealSuggestionsTableViewController : UIViewController
@property NSString *mealTypeException;
@property (weak, nonatomic) id<MealSuggestionsTableViewControllerDelegate> delegate;
@end

@protocol MealSuggestionsTableViewControllerDelegate <NSObject>
-(void)mealSuggestionsViewController:(MealSuggestionsTableViewController *)viewController didSelectMeal:(Meal *)meal;
@end
NS_ASSUME_NONNULL_END

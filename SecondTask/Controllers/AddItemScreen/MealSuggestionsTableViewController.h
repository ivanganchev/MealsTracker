//
//  MealSuggestionsTableViewController.h
//  SecondTask
//
//  Created by A-Team Intern on 24.08.21.
//

#import <UIKit/UIKit.h>
#import "Meal.h"

NS_ASSUME_NONNULL_BEGIN
@protocol MealSuggestionsTableViewControllerDelegate <NSObject>
-(void)getSuggestedMeal:(Meal *)meal;
@end

@interface MealSuggestionsTableViewController : UIViewController
@property NSString *mealTypeException;
@property (weak, nonatomic) id<MealSuggestionsTableViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END

//
//  EditMealViewController.h
//  SecondTask
//
//  Created by A-Team Intern on 23.08.21.
//

#import <UIKit/UIKit.h>
#import "Meal.h"

NS_ASSUME_NONNULL_BEGIN
@protocol EditMealViewControllerDelegate <NSObject>

- (void)getEditedMeal:(Meal *)meal;

@end

@interface EditMealViewController : UIViewController
@property Meal* meal;
@property  (weak, nonatomic) id<EditMealViewControllerDelegate> delegate;
@end



NS_ASSUME_NONNULL_END

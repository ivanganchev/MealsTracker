//
//  UITableViewMealsCell.h
//  SecondTask
//
//  Created by A-Team Intern on 5.08.21.
//

#import <UIKit/UIKit.h>
#import "Meal.h"

@protocol CellDelegate;

@interface UITableViewMealsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mealTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *mealServingsLabel;
+(NSString *)getCellId;
-(void)setUpWithMeal:(Meal *)meal;
@end



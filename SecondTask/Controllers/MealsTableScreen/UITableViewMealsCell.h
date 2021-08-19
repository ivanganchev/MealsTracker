//
//  UITableViewMealsCell.h
//  SecondTask
//
//  Created by A-Team Intern on 5.08.21.
//

#import <UIKit/UIKit.h>
@protocol CellDelegate;

@interface UITableViewMealsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mealTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *mealServingsLabel;
@property (weak, nonatomic) id<CellDelegate>delegate;
@property (assign, nonatomic) NSInteger cellIndex;
@property (weak, nonatomic) NSString *cellMealType;
@end



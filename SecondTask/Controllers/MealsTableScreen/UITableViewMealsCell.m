//
//  UITableViewMealsCell.m
//  SecondTask
//
//  Created by A-Team Intern on 5.08.21.
//

#import "UITableViewMealsCell.h"

@implementation UITableViewMealsCell

static NSString * cellId = @"UITableViewMealsCellId";

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(NSString *)getCellId {
    return cellId;
}

-(void)setUpWithMeal:(Meal *) meal{
    self.mealTitleLabel.text = meal.title;
    self.mealServingsLabel.text = [NSString stringWithFormat:@"%ld", meal.servingsPerDay];
}

@end

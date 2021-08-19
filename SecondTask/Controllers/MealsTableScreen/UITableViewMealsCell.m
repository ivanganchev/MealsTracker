//
//  UITableViewMealsCell.m
//  SecondTask
//
//  Created by A-Team Intern on 5.08.21.
//

#import "UITableViewMealsCell.h"

@implementation UITableViewMealsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)deleteButtonTap:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickOnCellAtIndex:mealType:)]) {
            [self.delegate didClickOnCellAtIndex:self.cellIndex mealType:self.cellMealType];
        }
}

@end

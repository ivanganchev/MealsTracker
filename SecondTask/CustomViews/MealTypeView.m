//
//  MealTypeView.m
//  SecondTask
//
//  Created by A-Team Intern on 23.08.21.
//

#import "MealTypeView.h"
@interface MealTypeView ()
@property NSArray *mealTypesIcons;
@end

@implementation MealTypeView

-(instancetype)initWithWidth:(float)componentWidth height:(float)componentHeight iconText:(nonnull NSString *)iconText mealType:(nonnull NSString *)mealType{
    self = [super initWithFrame:CGRectMake(0, 0, componentWidth - 10.0f, componentHeight)];
    
    UILabel *pickerViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
    UIImageView *pickerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 29, 29)];
    
    pickerImageView.image = [UIImage imageNamed:iconText];
    pickerViewLabel.text = mealType;
    
    [self addSubview:pickerImageView];
    [self addSubview:pickerViewLabel];
    
    pickerImageView.translatesAutoresizingMaskIntoConstraints = false;
    pickerViewLabel.translatesAutoresizingMaskIntoConstraints = false;
    
    [pickerImageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant: componentWidth / 2 - pickerImageView.image.size.width/ 2 - pickerViewLabel.intrinsicContentSize.width / 2 - 10].active = YES;
    [pickerImageView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor constant:0].active = YES;
    [pickerImageView.widthAnchor constraintEqualToConstant:25].active = YES;
    [pickerImageView.heightAnchor constraintEqualToConstant:25].active = YES;
    
    [pickerViewLabel.leadingAnchor constraintEqualToAnchor:pickerImageView.trailingAnchor constant:10].active = YES;
    [pickerViewLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor constant:0].active = YES;
    
    return self;
}
@end

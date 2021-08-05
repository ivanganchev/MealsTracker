//
//  AddItemViewController.m
//  SecondTask
//
//  Created by A-Team Intern on 3.08.21.
//

#import "AddItemViewController.h"

@interface AddItemViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *mealTypePickerView;
@property (weak, nonatomic) IBOutlet UITextField *servingsPerWeek;
@property NSArray *mealTypes;
@property NSArray *mealTypesIcons;

@end

@implementation AddItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mealTypes = [NSArray arrayWithObjects:@"Steak", @"Chicken", @"Fish", @"Vegeterian", @"Vegan", nil];
    
    self.mealTypesIcons = [NSArray arrayWithObjects:@"steak", @"chicken", @"fish", @"vegetarian", @"vegan", nil];
    
    self.mealTypePickerView.dataSource = self;
    self.mealTypePickerView.delegate = self;
}

-(IBAction)cancel:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(viewControllerDidCancel:)]) {
         [self.delegate viewControllerDidCancel:self];
     }
}

-(IBAction)doneButtonTap:(id)sender {
    NSInteger row = [self.mealTypePickerView selectedRowInComponent:0];
    
    Meal* meal = [[Meal alloc] initWithTitle: self.titleTextField.text mealType: self.mealTypes[row] date: @"today" servingsPerWeek:[self.servingsPerWeek.text integerValue]];
    
    [self.delegate viewController:self didAddItem:meal];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView
numberOfRowsInComponent:(NSInteger)component {
     return self.mealTypes.count;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    float componentWidth = [pickerView rowSizeForComponent:component].width;
    float componentHeight = [pickerView rowSizeForComponent:component].height;
    
    UIView *pickerCustomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, componentWidth - 10.0f, componentHeight)];
    UILabel *pickerViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
    UIImageView *pickerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 29, 29)];
    
    pickerImageView.image = [UIImage imageNamed:self.mealTypesIcons[row]];
    pickerViewLabel.text = self.mealTypes[row];
    
    [pickerCustomView addSubview:pickerImageView];
    [pickerCustomView addSubview:pickerViewLabel];
    
    pickerImageView.translatesAutoresizingMaskIntoConstraints = false;
    pickerViewLabel.translatesAutoresizingMaskIntoConstraints = false;
    
    [pickerImageView.leadingAnchor constraintEqualToAnchor:pickerCustomView.leadingAnchor constant: componentWidth / 2 - pickerImageView.image.size.width / 2 - pickerViewLabel.intrinsicContentSize.width / 2 - 10].active = YES;
    [pickerImageView.centerYAnchor constraintEqualToAnchor:pickerCustomView.centerYAnchor constant:0].active = YES;
    [pickerImageView.widthAnchor constraintEqualToConstant:25].active = YES;
    [pickerImageView.heightAnchor constraintEqualToConstant:25].active = YES;
    
    [pickerViewLabel.leadingAnchor constraintEqualToAnchor:pickerImageView.trailingAnchor constant:10].active = YES;
    [pickerViewLabel.centerYAnchor constraintEqualToAnchor:pickerCustomView.centerYAnchor constant:0].active = YES;
    
    return pickerCustomView;
}

@end

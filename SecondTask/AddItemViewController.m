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
@property NSArray *mealTypes;

@end

@implementation AddItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mealTypes = [NSArray arrayWithObjects:@"Steak", @"Chicken", @"Fish", @"Vegeterian", @"Vegan", nil];
    
    self.mealTypePickerView.dataSource = self;
    self.mealTypePickerView.delegate = self;
}

-(IBAction)cancel:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(viewControllerDidCancel:)]) {
         [self.delegate viewControllerDidCancel:self];
     }
}

-(IBAction)doneButtonTap:(id)sender {
    [self.delegate viewController:self didAddItem:self.titleTextField.text];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView
numberOfRowsInComponent:(NSInteger)component {
     return self.mealTypes.count;
}

-(UIView *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.mealTypes[row];
}

@end

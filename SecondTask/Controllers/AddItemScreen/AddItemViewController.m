//
//  AddItemViewController.m
//  SecondTask
//
//  Created by A-Team Intern on 3.08.21.
//

#import "AddItemViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "ExistingMealsViewController.h"
#import "MealTypeView.h"
#import "MealsUIResources.h"

@interface AddItemViewController () <UIPickerViewDataSource, UIPickerViewDelegate, ExistingMealsViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *mealTypePickerView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *dayTime;
@property (weak, nonatomic) IBOutlet UITextField *servingsPerDay;
@property MealsUIResources *mealsRes;
@property NSArray *dayTimeTypes;
@end

@implementation AddItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mealsRes = [[MealsUIResources alloc] initMealTypes];
    self.dayTimeTypes = [NSArray arrayWithObjects:@"Breakfast", @"Lunch", @"Dinner", nil];
    
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
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    
    Meal *meal = [[Meal alloc] initWithTitle:self.titleTextField.text mealType:self.mealsRes.mealsTypes[row].mealTypeName date:@"today" servingsPerDay:  [self.servingsPerDay.text intValue] dayTime: [self.dayTime titleForSegmentAtIndex:[self.dayTime selectedSegmentIndex]]];

    [self.delegate addMealToCoreData:self meal:meal];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView
numberOfRowsInComponent:(NSInteger)component {
     return self.mealsRes.mealsTypes.count;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    float componentWidth = [pickerView rowSizeForComponent:component].width;
    float componentHeight = [pickerView rowSizeForComponent:component].height;
    
    MealTypeView *pickerCustomView = [[MealTypeView alloc] initWithWidth:componentWidth height:componentHeight iconText:self.mealsRes.mealsTypes[row].mealIconName mealType:self.mealsRes.mealsTypes[row].mealTypeName];

    return pickerCustomView;
}

- (IBAction)chooseFromExistingButtonTap:(id)sender {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ExistingMealsViewController *existingMealsVC = [storyBoard instantiateViewControllerWithIdentifier:@"ExistingMealsViewController"];
    existingMealsVC.modalPresentationStyle = UIModalPresentationAutomatic;
    existingMealsVC.delegate = self;
    [self.navigationController pushViewController:existingMealsVC animated:YES];
}

-(void)getExistingMeal:(Meal *)meal {
    self.titleTextField.text = meal.title;
    int index = 0;
    for(int i = 0; i < self.mealsRes.mealsTypes.count; i++) {
        if([self.mealsRes.mealsTypes[i].mealTypeName isEqual:meal.mealType]) {
            index = i;
            break;
        }
    }
    [self.mealTypePickerView selectRow:index inComponent:0 animated:YES];
    [self.dayTime setSelectedSegmentIndex: [self.dayTimeTypes indexOfObject:meal.dayTime]];
    self.servingsPerDay.text = [NSString stringWithFormat:@"%ld", meal.servingsPerDay];
}

@end

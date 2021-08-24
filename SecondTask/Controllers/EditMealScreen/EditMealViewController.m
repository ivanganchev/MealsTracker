//
//  EditMealViewController.m
//  SecondTask
//
//  Created by A-Team Intern on 23.08.21.
//

#import "EditMealViewController.h"
#import "MealsUIResources.h"
#import "MealTypeView.h"

@interface EditMealViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *mealTypePickerView;
@property (weak, nonatomic) IBOutlet UITextField *mealTitle;
@property (weak, nonatomic) IBOutlet UISegmentedControl *dayTime;
@property (weak, nonatomic) IBOutlet UITextField *servingsPerDay;
@property NSArray *dayTimeTypes;

@property MealsUIResources *mealsRes;

@end

@implementation EditMealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mealsRes = [[MealsUIResources alloc] initMealTypes];
    
    self.mealTypePickerView.delegate = self;
    self.mealTypePickerView.dataSource = self;
    
    self.dayTimeTypes = [NSArray arrayWithObjects:@"Breakfast", @"Lunch", @"Dinner", nil];
    
    self.mealTitle.text = self.meal.title;
    int index = 0;
    for(int i = 0; i < self.mealsRes.mealsTypes.count; i++) {
        if([self.mealsRes.mealsTypes[i].mealTypeName isEqual:self.meal.mealType]) {
            index = i;
            break;
        }
    }
    [self.mealTypePickerView selectRow:index inComponent:0 animated:YES];
    [self.dayTime setSelectedSegmentIndex: [self.dayTimeTypes indexOfObject:self.meal.dayTime]];
    self.servingsPerDay.text = [NSString stringWithFormat:@"%ld", self.meal.servingsPerDay];
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

- (IBAction)doneButtonTap:(id)sender {
    self.meal.title = self.mealTitle.text;
    self.meal.mealType = self.mealsRes.mealsTypes[[self.mealTypePickerView selectedRowInComponent:0]].mealTypeName;
    self.meal.dayTime = [self.dayTimeTypes objectAtIndex:[self.dayTime selectedSegmentIndex]];
    self.meal.servingsPerDay = [self.servingsPerDay.text integerValue];
    [self.delegate getEditedMeal: self.meal];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end

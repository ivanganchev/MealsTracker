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
#import "SuggestionNotificationButton.h"
#import "MealSuggestionsTableViewController.h"
#import "CoreDataManager.h"

@interface AddItemViewController () <UIPickerViewDataSource, UIPickerViewDelegate, ExistingMealsViewControllerDelegate, MealSuggestionsTableViewControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *mealTypePickerView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *dayTime;
@property (weak, nonatomic) IBOutlet UITextField *servingsPerDay;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property MealsUIResources *mealsRes;
@property NSArray *dayTimeTypes;
@property SuggestionNotificationButton *suggestionButton;
@property CoreDataManager *manager;
@property BOOL isSuggestionButtonSuggesting;
@property NSString *mostCommonMealType;
@property NSInteger highestMealTypeCount;
@end

@implementation AddItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mostCommonMealType = @"";
    self.highestMealTypeCount = 0;
    
    self.mealsRes = [[MealsUIResources alloc] initMealTypes];
    self.dayTimeTypes = [NSArray arrayWithObjects:@"Breakfast", @"Lunch", @"Dinner", nil];
    
    self.mealTypePickerView.dataSource = self;
    self.mealTypePickerView.delegate = self;
    self.titleTextField.delegate = self;
    self.servingsPerDay.delegate = self;
    
//    [self.doneButton setEnabled:NO];
    
    [self setNavBarRightSuggestionButton];
    
//    [self.titleTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//    [self.servingsPerDay addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.manager = [[CoreDataManager alloc] init];
    [self setSuggestionButtonUsability];
}

-(void) viewWillAppear:(BOOL)animated {
    [self setNavBarRightSuggestionButton];
    [self setSuggestionButtonUsability];
}

- (IBAction)doneButtonTap:(id)sender {
    NSInteger row = [self.mealTypePickerView selectedRowInComponent:0];
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    
    Meal *meal = [[Meal alloc] initWithTitle:self.titleTextField.text mealType:self.mealsRes.mealsTypes[row].mealTypeName date:@"today" servingsPerDay:  [self.servingsPerDay.text intValue] dayTime: [self.dayTime titleForSegmentAtIndex:[self.dayTime selectedSegmentIndex]]];

    [self.delegate mealAdded:self meal:meal];
    
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

-(void)existingMealsViewController:(ExistingMealsViewController *)viewController didSelectMeal:(Meal *)meal {
    self.titleTextField.text = meal.title;
    [self.mealTypePickerView selectRow:[self getPickerViewSelectedRowIndex:meal] inComponent:0 animated:YES];
    [self.dayTime setSelectedSegmentIndex: [self.dayTimeTypes indexOfObject:meal.dayTime]];
    self.servingsPerDay.text = [NSString stringWithFormat:@"%ld", meal.servingsPerDay];
}

-(void)suggestionButtonTap {
    NSString *alertText = @"";
    NSMutableArray *actions = [[NSMutableArray alloc] init];
    if(self.isSuggestionButtonSuggesting == NO) {
        alertText =@"You've been eatening pretty good, you don't need any suggestions.";
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
        [actions addObject:cancelAction];
    } else {
        alertText = [NSString stringWithFormat:@"You've eaten almost only %@, do you need suggested something else?", [self.mostCommonMealType lowercaseString]];
        UIAlertAction *showAction = [UIAlertAction actionWithTitle:@"Show me" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            MealSuggestionsTableViewController *mealSuggestionsVC = [storyBoard instantiateViewControllerWithIdentifier:@"MealSuggestionsTableViewControllerId"];
            mealSuggestionsVC.mealTypeException = self.mostCommonMealType;
            mealSuggestionsVC.delegate = self;
            [self presentViewController:mealSuggestionsVC animated:YES completion:nil];
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        [actions addObject:cancelAction];
        [actions addObject:showAction];
    }
    
    UIAlertController *suggestionAlert = [UIAlertController alertControllerWithTitle:@"Suggestion" message:alertText preferredStyle:UIAlertControllerStyleAlert];
    
    for(UIAlertAction *action in actions) {
        [suggestionAlert addAction:action];
    }
 
    [self presentViewController:suggestionAlert animated:YES completion:nil];
}

-(void)setSuggestionButtonUsability{
    NSArray *allEntities = [self.manager fetchAllEntries:@"MealEntity"];
    
    int currentMealTypeCount = 0;
    int mealDifference = 7;
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:self.mealsRes.mealsTypes.count];
    
    for(MealType *m in self.mealsRes.mealsTypes) {
        for(MealEntity *e in allEntities) {
            if([e.mealType isEqual:m.mealTypeName]) {
                currentMealTypeCount++;
            }
            [dict setObject:[NSNumber numberWithInt:currentMealTypeCount] forKey:m.mealTypeName];
        }
        currentMealTypeCount = 0;
    }
    
    NSInteger highestMealTypeCount = 0;
    NSString *highestCountMealType = @"";
    NSMutableArray *leftOverValues = [[NSMutableArray alloc] init];
    for(MealType *m in self.mealsRes.mealsTypes) {
        NSInteger mealTypeCount = [[dict objectForKey:m.mealTypeName]integerValue];
        if(mealTypeCount > highestMealTypeCount) {
            highestMealTypeCount = mealTypeCount;
            highestCountMealType = m.mealTypeName;
        } else {
            [leftOverValues addObject:[NSNumber numberWithInteger:mealTypeCount]];
        }
    }
    
    if((highestMealTypeCount - [[leftOverValues valueForKeyPath:@"@max.self"]integerValue]) >= mealDifference) {
        self.isSuggestionButtonSuggesting = YES;
        [self.suggestionButton setRedDotEnabled:YES];
        self.mostCommonMealType = highestCountMealType;
    } else {
        self.isSuggestionButtonSuggesting = NO;
        [self.suggestionButton setRedDotEnabled:NO];
        self.mostCommonMealType = @"";
    }
}

-(void)mealSuggestionsViewController:(MealSuggestionsTableViewController *)viewController didSelectMeal:(Meal *)meal {
    self.titleTextField.text = meal.title;
    [self.mealTypePickerView selectRow:[self getPickerViewSelectedRowIndex:meal] inComponent:0 animated:YES];
    [self.dayTime setSelectedSegmentIndex: [self.dayTimeTypes indexOfObject:meal.dayTime]];
    self.servingsPerDay.text = [NSString stringWithFormat:@"%ld", meal.servingsPerDay];
}

-(void)setNavBarRightSuggestionButton {
    self.suggestionButton = [[SuggestionNotificationButton alloc] initButton];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:self.suggestionButton];
    self.navigationItem.rightBarButtonItem = rightButton;
    [self.suggestionButton addTarget:self
                              action:@selector(suggestionButtonTap)
       forControlEvents:UIControlEventTouchUpInside];
}

- (void)touchesEnded: (NSSet *)touches withEvent: (UIEvent *)event {
    for (UIView* view in self.view.subviews) {
        if([view isKindOfClass:[UITextField class]])
            [view resignFirstResponder];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidChange:(UITextField *)textField {
    if(![self.titleTextField.text isEqual:@""] && ![self.servingsPerDay isEqual:@"0"]) {
        
    } else {
      
    }
}

-(NSInteger)getPickerViewSelectedRowIndex:(Meal *)meal {
    int index = 0;
    for(int i = 0; i < self.mealsRes.mealsTypes.count; i++) {
        if([self.mealsRes.mealsTypes[i].mealTypeName isEqual:meal.mealType]) {
            index = i;
            break;
        }
    }
    
    return index;
}

@end

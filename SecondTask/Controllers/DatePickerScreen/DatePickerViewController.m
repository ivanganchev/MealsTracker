//
//  DatePIckerViewController.m
//  SecondTask
//
//  Created by A-Team Intern on 10.08.21.
//

#import "DatePickerViewController.h"
#import "MealsTableViewController.h"

@interface DatePickerViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *mealsDatePicker;

@end

@implementation DatePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    // Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
}

- (IBAction)dateChanged:(id)sender {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    MealsTableViewController *mealTableVC = [storyBoard instantiateViewControllerWithIdentifier:@"MealTableNavigationController"];
    mealTableVC.date = [self getDate];
    
    [self.navigationController pushViewController:mealTableVC animated:YES];
}

-(NSString *)getDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMM"];

    //Optionally for time zone conversions
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];

    NSString *stringFromDate = [formatter stringFromDate:self.mealsDatePicker.date];
    
    return stringFromDate;
}
@end

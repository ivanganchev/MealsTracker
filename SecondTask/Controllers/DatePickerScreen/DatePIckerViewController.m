//
//  DatePIckerViewController.m
//  SecondTask
//
//  Created by A-Team Intern on 10.08.21.
//

#import "DatePIckerViewController.h"
#import "MealsTableViewController.h"

@interface DatePIckerViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *mealsDatePicker;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation DatePIckerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)dateChanged:(id)sender {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMM"];

    //Optionally for time zone conversions
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];

    NSString *stringFromDate = [formatter stringFromDate:self.mealsDatePicker.date];
    
    self.dateLabel.text = stringFromDate;
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    MealsTableViewController *mealTableVC = [storyBoard instantiateViewControllerWithIdentifier:@"MealTableNavigationController"];
    //TODO Mealtableviewcontroller property date - set it here
    [mealTableVC setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:mealTableVC animated:YES completion:nil];
}

@end

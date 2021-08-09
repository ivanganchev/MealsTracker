//
//  ViewController.m
//  SecondTask
//
//  Created by A-Team Intern on 3.08.21.
//

#import "ViewController.h"
#import "AddItemViewController.h"
#import "UITableViewMealsCell.h"

@interface ViewController () <AddItemViewControllerDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *mealTable;
@property NSMutableArray<Meal *> *mealItems;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mealItems = [[NSMutableArray alloc] init];
    
    self.mealTable.dataSource = self;
    
//    [self.mealTable registerClass: UITableViewMealsCell.class forCellReuseIdentifier: @"UITableViewMealsCellId"];
}

- (IBAction)addMeal:(id)sender {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    AddItemViewController *addItemVC = [storyBoard instantiateViewControllerWithIdentifier:@"AddItemViewController"];
    
    [addItemVC setDelegate:self];
    
    [self presentViewController:addItemVC animated:YES completion:nil];
}

- (void)viewControllerDidCancel:(AddItemViewController *)viewController {
    
}

- (void)viewController:(AddItemViewController *)viewController didAddItem:(Meal *)item{
    [self.mealItems addObject:item];
    [self.mealTable reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     UITableViewMealsCell *cell = [self.mealTable dequeueReusableCellWithIdentifier:@"UITableViewMealsCellId" forIndexPath: indexPath];
//    cell = [[UITableViewMealsCell alloc] init];
    
    Meal *meal = [self.mealItems objectAtIndex:indexPath.row];
    
    cell.mealTitleLabel.text = meal.title;
    cell.mealTypeLabel.text = meal.mealType;
                                       
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mealItems.count;
}

@end

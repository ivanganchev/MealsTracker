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
@property NSArray<NSString *> *mealTypeSections;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mealItems = [[NSMutableArray alloc] init];
    self.mealTypeSections = [[NSArray alloc] initWithObjects:@"Steak", @"Chicken", @"Fish", @"Vegeterian", @"Vegan", nil];

    self.mealTable.dataSource = self;
    
    
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
     UITableViewMealsCell *cell = [self.mealTable dequeueReusableCellWithIdentifier:@"UITableViewMealsCellId"];
    
    if(cell == nil) {
        cell = [[UITableViewMealsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewMealsCellId"];
    }
    NSInteger correctIndex = [self tableView:tableView correctMealItemIndex:indexPath.row section:indexPath.section];
    
    Meal *meal = [self.mealItems objectAtIndex:correctIndex];
    
    cell.mealTitleLabel.text = meal.title;
    cell.mealServingsLabel.text = [NSString stringWithFormat:@"%ld", meal.servingsPerWeek];
                                       
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.rowHeight;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger numOfSections = self.mealTypeSections.count;
    if(self.mealItems.count > 0) {
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        tableView.backgroundView = nil;
        return numOfSections;
    } else {
        UILabel *noDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, tableView.bounds.size.height)];
        noDataLabel.text = @"No meals added";
        noDataLabel.textAlignment = NSTextAlignmentCenter;
        tableView.backgroundView = noDataLabel;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return numOfSections;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    NSString *mealType = [self.mealTypeSections objectAtIndex:section];
    
    for(Meal *m in self.mealItems) {
        if([mealType isEqualToString:m.mealType]) {
            [tempArr addObject:m];
        }
    }
    
    return tempArr.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if ([tableView.dataSource tableView:tableView numberOfRowsInSection:section] == 0) {
            return nil;
        }
    
    return [self.mealTypeSections objectAtIndex:section];
 }

-(NSInteger) tableView:(UITableView *)tableView
    correctMealItemIndex:(NSInteger)row section:(NSInteger)sections{
    NSInteger rowNumber = 0;
    
    for(int i = 0; i < sections; i++) {
        rowNumber += [self tableView:tableView numberOfRowsInSection:i];
    }
    
    return rowNumber;
}

@end

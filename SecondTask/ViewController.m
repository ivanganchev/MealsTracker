//
//  ViewController.m
//  SecondTask
//
//  Created by A-Team Intern on 3.08.21.
//

#import "ViewController.h"
#import "AddItemViewController.h"

@interface ViewController () <AddItemViewControllerDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *mealTable;
@property NSMutableArray<Meal *> *mealItems;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mealItems = [[NSMutableArray alloc] init];
    
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
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = self.mealItems[indexPath.row].mealType;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mealItems.count;
}

@end

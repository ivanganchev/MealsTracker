//
//  ExistingMealsViewController.m
//  SecondTask
//
//  Created by A-Team Intern on 20.08.21.
//

#import "ExistingMealsViewController.h"
#import "UITableViewMealsCell.h"
#import "CoreDataManager.h"
#import "Meal.h"
#import "DefaultMealsProvider.h"

@interface ExistingMealsViewController ()
    <UITableViewDataSource, UITableViewDelegate>

@property UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UITableView *existingMealsTableView;
@property CoreDataManager *manager;
@property NSArray<Meal *> *mealItems;
@property NSArray<Meal *> *defaultMeals;
@end

@implementation ExistingMealsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Default", @"Existing"]];
    self.segmentedControl.selectedSegmentIndex = 0;
    [self.segmentedControl addTarget: self action:@selector(segmentedControlIndexChanged:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = self.segmentedControl;
    
    self.manager = [[CoreDataManager alloc] init];
    
    self.existingMealsTableView.rowHeight = 80;
    self.existingMealsTableView.delegate = self;
    self.existingMealsTableView.dataSource = self;
    DefaultMealsProvider *provider = [[DefaultMealsProvider alloc]initDefaultMeals];
    self.defaultMeals = [provider getDefaultMeals];
    
    self.mealItems = self.defaultMeals;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewMealsCell *cell = [self.existingMealsTableView dequeueReusableCellWithIdentifier:UITableViewMealsCell.getCellId];
   
   if(cell == nil) {
       cell = [[UITableViewMealsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:UITableViewMealsCell.getCellId];
   }
    
    Meal* meal = [self.mealItems objectAtIndex:indexPath.row];
    
    [cell setUpWithMeal:meal];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mealItems.count;
}

-(NSMutableArray *)fillMealsArrayWithUniqueValues{
    NSMutableSet<Meal *> *uniqueMeals = [[NSMutableSet alloc] initWithArray:[self.manager fetchAllEntries:@"MealEntity"]];
    NSMutableArray *meals = [NSMutableArray arrayWithArray:[uniqueMeals allObjects]];
    return meals;
}

-(void)segmentedControlIndexChanged:(id)sender {
    if(self.segmentedControl.selectedSegmentIndex == 0) {
        self.mealItems = self.defaultMeals;
        
    } else {
        self.mealItems = [self fillMealsArrayWithUniqueValues];
    }
    
    [self.existingMealsTableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate getExistingMeal:[self.mealItems objectAtIndex:indexPath.row]];
    [self.navigationController popViewControllerAnimated:YES];
}

@end

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
@property NSMutableArray<Meal *> *mealItems;
@property NSMutableArray<Meal *> *defaultMeals;
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
    
    UITableViewMealsCell *cell = [self.existingMealsTableView dequeueReusableCellWithIdentifier:@"UITableViewMealsCellId"];
   
   if(cell == nil) {
       cell = [[UITableViewMealsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewMealsCellId"];
   }
    
    Meal* meal = [self.mealItems objectAtIndex:indexPath.row];
    
    cell.mealTitleLabel.text = meal.title;
    cell.mealServingsLabel.text = [NSString stringWithFormat:@"%ld", meal.servingsPerDay];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.mealItems.count;
}

-(NSMutableArray *)convertMealEntityToMeal{
    NSMutableArray* entities = [self.manager fetchAllEntries:@"MealEntity" ];
    
    NSMutableArray<Meal*>* newArray = [[NSMutableArray alloc] init];
    for(MealEntity *e in entities) {
        Meal* m = [[Meal alloc] initWithEntityObject:e];
        [newArray addObject:m];
    }
    
    return newArray;
}

-(void)segmentedControlIndexChanged:(id)sender {
    if(self.segmentedControl.selectedSegmentIndex == 0) {
        self.mealItems = self.defaultMeals;
        
    } else {
        self.mealItems = [self convertMealEntityToMeal];
    }
    
    [self.existingMealsTableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate getExistingMeal:[self.mealItems objectAtIndex:indexPath.row]];
    [self.navigationController popViewControllerAnimated:YES];
}

@end

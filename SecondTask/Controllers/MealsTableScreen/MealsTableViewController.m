//
//  ViewController.m
//  SecondTask
//
//  Created by A-Team Intern on 3.08.21.
//

#import "MealsTableViewController.h"
#import "AddItemViewController.h"
#import "UITableViewMealsCell.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "CoreDataManager.h"
#import "EditMealViewController.h"

@interface MealsTableViewController () <AddItemViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, EditMealViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mealTable;
@property NSMutableArray<Meal *> *mealItems;
@property NSArray<NSString *> *mealTypeSections;
@property NSMutableDictionary *mealsInSections;
@property CoreDataManager *manager;
@property UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *mealsTitle;
@property NSArray *dayTimeSections;
@property NSArray *sections;
@end

@implementation MealsTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Meal Type", @"Day Time"]];
    self.segmentedControl.selectedSegmentIndex = 0;
    [self.segmentedControl addTarget: self action:@selector(segmentedControlIndexChanged:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = self.segmentedControl;
    
    self.navigationController.navigationBar.hidden = NO;
    self.mealItems = [[NSMutableArray alloc] init];
    self.mealTypeSections = [[NSArray alloc] initWithObjects:@"Steak", @"Chicken", @"Fish", @"Vegeterian", @"Vegan", nil];
    self.sections = [[NSArray alloc] initWithArray:self.mealTypeSections];
    self.dayTimeSections = [[NSArray alloc] initWithObjects:@"Breakfast", @"Lunch", @"Dinner", nil];
    
    [self setMealsDictionary];
    
    self.mealTable.rowHeight = 80;
    self.mealTable.dataSource = self;
    self.mealTable.delegate = self;
    
    self.manager = [[CoreDataManager alloc] init];
    self.mealsInSections = [self fillMealsDictWithArray];
}

- (IBAction)addMeal:(id)sender {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    AddItemViewController *addItemVC = [storyBoard instantiateViewControllerWithIdentifier:@"AddItemViewController"];
    
    [addItemVC setDelegate:self];
    
    [self.navigationController pushViewController:addItemVC animated:YES];
}

- (void)viewControllerDidCancel:(AddItemViewController *)viewController {
}

- (void)addMealToCoreData:(AddItemViewController *)viewController meal:(nonnull Meal *)meal{
    meal.date = self.date1;
    [self.manager addMealEntityEntry:meal];
    self.mealsInSections = [self fillMealsDictWithArray];
    [self.mealTable reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     UITableViewMealsCell *cell = [self.mealTable dequeueReusableCellWithIdentifier:@"UITableViewMealsCellId"];
    
    if(cell == nil) {
        cell = [[UITableViewMealsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewMealsCellId"];
    }
    
    NSArray *meals = [self.mealsInSections objectForKey:self.sections[indexPath.section]];
    
    Meal *meal = [meals objectAtIndex:indexPath.row];
    
    cell.mealTitleLabel.text = meal.title;
    cell.mealServingsLabel.text = [NSString stringWithFormat:@"%ld", meal.servingsPerDay];
                                       
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger numOfSections = self.sections.count;
    NSInteger numOfRowsInSections = 0;
    for(id key in self.sections) {
        NSArray *a = [self.mealsInSections objectForKey:key];
        numOfRowsInSections += a.count;
    }
    
    if(numOfRowsInSections > 0) {
        self.mealsTitle.hidden = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        tableView.backgroundView = nil;
    } else {
        self.mealsTitle.hidden = YES;
        UILabel *noDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, tableView.bounds.size.height)];
        noDataLabel.text = @"No meals added";
        noDataLabel.textAlignment = NSTextAlignmentCenter;
        tableView.backgroundView = noDataLabel;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return numOfSections;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *sectionType = [self.sections objectAtIndex:section];
    
    NSMutableArray *tempArr = [self.mealsInSections objectForKey:sectionType];
    
    return tempArr.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if ([tableView.dataSource tableView:tableView numberOfRowsInSection:section] == 0) {
            return nil;
    }
    
    return [self.sections objectAtIndex:section];
 }

- (IBAction)navigateToPreviousViewController:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSMutableDictionary*) fillMealsDictWithArray {
    
    NSMutableArray* meals = [self.manager fetchEntriesByDate:@"MealEntity" date:self.date1];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:[self.sections count]];
    
    for(id key in self.sections) {
        NSMutableArray *array = [NSMutableArray array];
        [dict setObject:array forKey:key];
    }
    
    for(Meal *item in meals) {
        if(self.sections.count == self.mealTypeSections.count) {
            [dict[item.mealType] addObject:item];
        } else {
            [dict[item.dayTime] addObject:item];
        }
    }
    
    return dict;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
}

-(UISwipeActionsConfiguration *)tableView:(UITableView *)tableView
trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath;{
    UIContextualAction *editAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"Edit" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        EditMealViewController *editMealVC = [storyBoard instantiateViewControllerWithIdentifier:@"EditMealViewController"];
        NSArray *mealsBySection = self.mealsInSections[self.mealTypeSections[indexPath.section]];
        editMealVC.meal = [mealsBySection objectAtIndex:indexPath.row];
        editMealVC.delegate = self;
        [self presentViewController:editMealVC animated:YES completion:nil];
        
    }];
    editAction.backgroundColor = [UIColor lightGrayColor];

    UIContextualAction *deleteAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"Delete" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
            NSMutableArray<Meal*> *tempArr = [self.mealsInSections objectForKey:self.sections[indexPath.section]];
            [self.manager removeEntryById:tempArr[indexPath.row].identificaiton entityName:@"MealEntity"];
            self.mealsInSections = [self fillMealsDictWithArray];
            [self.mealTable reloadData];
    }];
    deleteAction.backgroundColor = [UIColor redColor];
    
    UISwipeActionsConfiguration *swipeActionConfig = [UISwipeActionsConfiguration configurationWithActions:@[deleteAction,editAction]];
    
    return swipeActionConfig;
}

-(void)segmentedControlIndexChanged:(id)sender {
    if(self.segmentedControl.selectedSegmentIndex == 0){
        self.sections = self.mealTypeSections;
    } else {
        self.sections = self.dayTimeSections;
    }
    
    [self setMealsDictionary];
    self.mealsInSections = [self fillMealsDictWithArray];
    [self.mealTable reloadData];
}

-(void)setMealsDictionary {
    self.mealsInSections = [NSMutableDictionary dictionaryWithCapacity:[self.sections count]];
    
    for(id key in self.sections) {
        NSMutableArray *array = [NSMutableArray array];
        [self.mealsInSections setObject:array forKey:key];
    }
}

-(void)getEditedMeal:(Meal *)meal {
    [self.manager updateEntryById:meal.identificaiton entityName:@"MealEntity" meal:meal];
    [self.mealTable reloadData];
}

@end

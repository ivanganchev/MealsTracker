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

@interface MealsTableViewController () <AddItemViewControllerDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *mealTable;
@property NSMutableArray<Meal *> *mealItems;
@property NSArray<NSString *> *mealTypeSections;
@property NSArray *keys;
@property NSMutableDictionary *mealsInSections;
@property CoreDataManager *manager;
@end

@implementation MealsTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.mealItems = [[NSMutableArray alloc] init];
    self.mealTypeSections = [[NSArray alloc] initWithObjects:@"Steak", @"Chicken", @"Fish", @"Vegeterian", @"Vegan", nil];
    
    self.keys = [NSArray arrayWithObjects:@"Steak", @"Chicken", @"Fish", @"Vegeterian", @"Vegan", nil];
    self.mealsInSections = [NSMutableDictionary dictionaryWithCapacity:[self.keys count]];
    
    for(id key in self.keys) {
        NSMutableArray *array = [NSMutableArray array];
        [self.mealsInSections setObject:array forKey:key];
    }
    
    self.mealTable.rowHeight = 80;
    self.mealTable.dataSource = self;
    
    self.manager = [[CoreDataManager alloc] init];
    self.mealsInSections = [self convertMealEntityToMeal];
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
    self.mealsInSections = [self convertMealEntityToMeal];
    [self.mealTable reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     UITableViewMealsCell *cell = [self.mealTable dequeueReusableCellWithIdentifier:@"UITableViewMealsCellId"];
    
    if(cell == nil) {
        cell = [[UITableViewMealsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewMealsCellId"];
    }
    
    NSArray *meals = [self.mealsInSections objectForKey:self.keys[indexPath.section]];
    
    Meal *meal = [meals objectAtIndex:indexPath.row];
    
    cell.mealTitleLabel.text = meal.title;
    cell.mealServingsLabel.text = [NSString stringWithFormat:@"%ld", meal.servingsPerDay];
                                       
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger numOfSections = self.mealTypeSections.count;
    NSInteger numOfRowsInSections = 0;
    for(id key in self.keys) {
        NSArray *a = [self.mealsInSections objectForKey:key];
        numOfRowsInSections += a.count;
    }
    
    if(numOfRowsInSections > 0) {
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
    NSString *mealType = [self.mealTypeSections objectAtIndex:section];
    
    NSMutableArray *tempArr = [self.mealsInSections objectForKey:mealType];
    
    return tempArr.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if ([tableView.dataSource tableView:tableView numberOfRowsInSection:section] == 0) {
            return nil;
        }
    
    return [self.mealTypeSections objectAtIndex:section];
 }

- (IBAction)navigateToPreviousViewController:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSMutableDictionary*) convertMealEntityToMeal {
    
    NSMutableArray* entities = [self.manager fetchEntriesByDate:@"MealEntity" date:self.date1];
    
    NSMutableArray<Meal*>* newArray = [[NSMutableArray alloc] init];
    for(MealEntity *e in entities) {
        Meal* m = [[Meal alloc] initWithEntityObject:e];
        [newArray addObject:m];
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:[self.keys count]];
    
    for(id key in self.keys) {
        NSMutableArray *array = [NSMutableArray array];
        [dict setObject:array forKey:key];
    }
    
    for(Meal *item in newArray) {
        [dict[item.mealType] addObject:item];
    }
    
    return dict;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSMutableArray<Meal*> *tempArr = [self.mealsInSections objectForKey:self.keys[indexPath.section]];
        [self.manager removeEntryById:tempArr[indexPath.row].identificaiton entityName:@"MealEntity"];
        self.mealsInSections = [self convertMealEntityToMeal];
        
        [self.mealTable reloadData];
    }
}

@end

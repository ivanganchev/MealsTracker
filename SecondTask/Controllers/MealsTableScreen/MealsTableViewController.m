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

@interface MealsTableViewController () <AddItemViewControllerDelegate, UITableViewDataSource, CellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mealTable;
@property NSMutableArray<Meal *> *mealItems;
@property NSArray<NSString *> *mealTypeSections;
@property NSFetchRequest *requestMeals;
@property AppDelegate *appDelegate;
@property NSManagedObjectContext *context;
@property NSManagedObject *mealEntity;
@property NSArray *keys;
@property NSMutableDictionary *mealsInSections;

@end

@implementation MealsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.mealTable setEditing:YES animated:YES];
    self.mealItems = [[NSMutableArray alloc] init];
    self.mealTypeSections = [[NSArray alloc] initWithObjects:@"Steak", @"Chicken", @"Fish", @"Vegeterian", @"Vegan", nil];
    
    self.keys = [NSArray arrayWithObjects:@"Steak", @"Chicken", @"Fish", @"Vegeterian", @"Vegan", nil];
    self.mealsInSections = [NSMutableDictionary dictionaryWithCapacity:[self.keys count]];
    
    for(id key in self.keys) {
        NSMutableArray *array = [NSMutableArray array];
        [self.mealsInSections setObject:array forKey:key];
    }
    
    self.mealTable.dataSource = self;
    
    self.requestMeals = [NSFetchRequest fetchRequestWithEntityName:@"MealEntity"];
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.context = self.appDelegate.persistentContainer.viewContext;
    
    self.mealsInSections = [self convertMealEntityToMeal];
}

- (IBAction)addMeal:(id)sender {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    AddItemViewController *addItemVC = [storyBoard instantiateViewControllerWithIdentifier:@"AddItemViewController"];
    
    [addItemVC setDelegate:self];
    
    [self presentViewController:addItemVC animated:YES completion:nil];
}

- (void)viewControllerDidCancel:(AddItemViewController *)viewController {
}

- (void)viewController:(AddItemViewController *)viewController{
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
    cell.cellIndex = indexPath.row;
    cell.cellMealType = meal.mealType;
    cell.delegate = self;
    cell.mealServingsLabel.text = [NSString stringWithFormat:@"%ld", meal.servingsPerDay];
                                       
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.rowHeight;
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

-(NSInteger) tableView:(UITableView *)tableView
    correctMealItemIndex:(NSInteger)row section:(NSInteger)sections{
    NSInteger rowNumber = 0;
    
    for(int i = 0; i < sections - 1; i++) {
        rowNumber += [self tableView:tableView numberOfRowsInSection:i];
    }
    
    return rowNumber + row;
}
- (IBAction)navigateToPreviousViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didClickOnCellAtIndex:(NSInteger)cellIndex mealType:(NSString *)cellMealType{
    NSMutableArray<Meal*> *tempArr = [self.mealsInSections objectForKey:cellMealType];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MealEntity" inManagedObjectContext:self.context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"identification == %@", tempArr[cellIndex].identificaiton];
    [self.requestMeals setEntity:entity];
    [self.requestMeals setPredicate:predicate];

    NSError *error;
    NSMutableArray *items = [NSMutableArray arrayWithArray:[self.context executeFetchRequest:self.requestMeals error:&error]];

    for(NSManagedObject *managedObj in items) {
        [self.context deleteObject:managedObj];
    }
    
    self.mealsInSections = [self convertMealEntityToMeal];
    [self.mealTable reloadData];
}

-(NSMutableDictionary*) convertMealEntityToMeal {
    self.requestMeals.predicate = nil;
    NSArray* entities = [NSMutableArray arrayWithArray:[self.context executeFetchRequest:self.requestMeals error:nil]];
    
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

@end

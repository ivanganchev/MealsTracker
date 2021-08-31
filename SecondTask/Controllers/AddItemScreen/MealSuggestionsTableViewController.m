//
//  MealSuggestionsTableViewController.m
//  SecondTask
//
//  Created by A-Team Intern on 24.08.21.
//

#import "MealSuggestionsTableViewController.h"
#import "CoreDataManager.h"
#import "Meal.h"
#import "DefaultMealsProvider.h"
#import "UITableViewMealsCell.h"

@interface MealSuggestionsTableViewController () <UITableViewDelegate,
                UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mealSuggestionTableView;
@property CoreDataManager *manager;
@property NSArray<Meal *> *mealItems;

@end

@implementation MealSuggestionsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mealSuggestionTableView.rowHeight = 80;
    self.mealSuggestionTableView.delegate = self;
    self.mealSuggestionTableView.dataSource = self;
    
    self.manager = [[CoreDataManager alloc] init];
    DefaultMealsProvider *provider = [[DefaultMealsProvider alloc] initDefaultMeals];
    self.mealItems = [provider getFilteredDefaultMealsByType:self.mealTypeException];
    self.mealItems = [[self.mealItems arrayByAddingObjectsFromArray:[self fillMealArray]]mutableCopy];
    self.mealItems = [[[[NSMutableSet alloc] initWithArray:self.mealItems] allObjects] mutableCopy];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewMealsCell *cell = [self.mealSuggestionTableView dequeueReusableCellWithIdentifier:UITableViewMealsCell.getCellId];
   
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

-(NSMutableArray *)fillMealArray{
    NSMutableSet<Meal *> *uniqueMeals = [[NSMutableSet alloc] initWithArray:[self.manager fetchAllEntriesExcept:@"MealEntity" mealType:self.mealTypeException]];
    NSMutableArray *meals = [NSMutableArray arrayWithArray:[uniqueMeals allObjects]];
    return meals;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate mealSuggestionsViewController:self didSelectMeal:[self.mealItems objectAtIndex:indexPath.row]];
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end

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
@property NSMutableArray<Meal *> *mealItems;

@end

@implementation MealSuggestionsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mealSuggestionTableView.rowHeight = 80;
    self.mealSuggestionTableView.delegate = self;
    self.mealSuggestionTableView.dataSource = self;
    
    self.manager = [[CoreDataManager alloc] init];
    DefaultMealsProvider *provider = [[DefaultMealsProvider alloc] initDefaultMeals];
    self.mealItems = [provider getFilteredDefaultMeals:self.mealTypeException];
    self.mealItems = [[self.mealItems arrayByAddingObjectsFromArray:[self fillMealArray]]mutableCopy];
    self.mealItems = [[[[NSMutableSet alloc] initWithArray:self.mealItems] allObjects] mutableCopy];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewMealsCell *cell = [self.mealSuggestionTableView dequeueReusableCellWithIdentifier:@"UITableViewMealsCellId"];
   
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

-(NSMutableArray *)fillMealArray{
    NSMutableSet<Meal *> *uniqueMeals = [[NSMutableSet alloc] initWithArray:[self.manager fetchAllEntriesExcept:@"MealEntity" mealType:self.mealTypeException]];
    NSMutableArray *meals = [NSMutableArray arrayWithArray:[uniqueMeals allObjects]];
    return meals;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate getSuggestedMeal:[self.mealItems objectAtIndex:indexPath.row]];
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
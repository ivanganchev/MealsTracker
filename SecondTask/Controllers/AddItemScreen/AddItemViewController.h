//
//  AddItemViewController.h
//  SecondTask
//
//  Created by A-Team Intern on 3.08.21.
//

#import <UIKit/UIKit.h>
#import "Meal.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AddItemViewControllerDelegate;

@interface AddItemViewController : UIViewController

@property  (weak, nonatomic) id<AddItemViewControllerDelegate> delegate;

@end

@protocol AddItemViewControllerDelegate <NSObject>
- (void)mealAdded:(AddItemViewController *)viewController meal:(Meal *)meal;
@optional
-(BOOL)viewController:(AddItemViewController *)viewController validateItem:(NSString *)item;
@end

NS_ASSUME_NONNULL_END

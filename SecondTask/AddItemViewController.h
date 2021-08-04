//
//  AddItemViewController.h
//  SecondTask
//
//  Created by A-Team Intern on 3.08.21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AddItemViewControllerDelegate;

@interface AddItemViewController : UIViewController

@property  (weak, nonatomic) id<AddItemViewControllerDelegate> delegate;

@end

@protocol AddItemViewControllerDelegate <NSObject>
- (void)viewControllerDidCancel:(AddItemViewController *)viewController;
- (void)viewController:(AddItemViewController *)viewController didAddItem:(NSString *)item;

@optional
-(BOOL)viewController:(AddItemViewController *)viewController validateItem:(NSString *)item;
@end

NS_ASSUME_NONNULL_END

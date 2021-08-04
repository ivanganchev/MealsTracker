//
//  AddItemViewController.m
//  SecondTask
//
//  Created by A-Team Intern on 3.08.21.
//

#import "AddItemViewController.h"

@interface AddItemViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation AddItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(IBAction)cancel:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(viewControllerDidCancel:)]) {
         [self.delegate viewControllerDidCancel:self];
     }
}

- (IBAction)doneButtonTap:(id)sender {
    [self.delegate viewController:self didAddItem:self.textView.text];
}

@end

//
//  SuggestionNotificationButton.m
//  SecondTask
//
//  Created by A-Team Intern on 24.08.21.
//

#import "SuggestionNotificationButton.h"
@interface SuggestionNotificationButton ()
@property UILabel *redDot;
@end

@implementation SuggestionNotificationButton

-(instancetype)initButton {
    self = [super initWithFrame:CGRectMake(0, 0, 25, 25)];
    self.redDot = [[UILabel alloc] initWithFrame:CGRectMake(16, -3, 10, 10)];
    self.redDot.layer.borderColor = UIColor.clearColor.CGColor;
    self.redDot.layer.borderWidth = 2;
    self.redDot.layer.cornerRadius = self.redDot.bounds.size.height / 2;
    self.redDot.textAlignment = NSTextAlignmentCenter;
    self.redDot.layer.masksToBounds = YES;
    self.redDot.backgroundColor = UIColor.redColor;
    
    [self setBackgroundImage:[UIImage systemImageNamed:@"lightbulb"] forState:UIControlStateNormal];
    [self addSubview:self.redDot];
    return self;
}

-(void)disableButton {
    [self setUserInteractionEnabled: NO];
    [self setAlpha:0.3f];
    [self setTintColor:[UIColor grayColor]];
    [self.subviews setValue:@YES forKeyPath:@"hidden"];
}

-(void)enableButton {
    [self setUserInteractionEnabled: YES];
    [self setAlpha:1.0f];
    [self setTintColor:[UIColor systemBlueColor]];
    [self.subviews setValue:@NO forKeyPath:@"hidden"];
}

@end

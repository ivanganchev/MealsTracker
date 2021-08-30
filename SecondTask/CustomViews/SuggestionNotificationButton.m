//
//  SuggestionNotificationButton.m
//  SecondTask
//
//  Created by A-Team Intern on 24.08.21.
//

#import "SuggestionNotificationButton.h"
@interface SuggestionNotificationButton ()
@property UIImageView *redDot;
@end

@implementation SuggestionNotificationButton

-(instancetype)initButton {
    self = [super initWithFrame:CGRectMake(0, 0, 25, 25)];
    self.redDot = [[UIImageView alloc] initWithFrame:CGRectMake(16, -3, 10, 10)];
    self.redDot.layer.borderColor = UIColor.clearColor.CGColor;
    self.redDot.layer.borderWidth = 2;
    self.redDot.layer.cornerRadius = self.redDot.bounds.size.height / 2;
    self.redDot.layer.masksToBounds = YES;
    self.redDot.backgroundColor = UIColor.redColor;
    
    [self setBackgroundImage:[UIImage systemImageNamed:@"lightbulb"] forState:UIControlStateNormal];
    [self addSubview:self.redDot];
    return self;
}

-(void)setRedDotEnabled:(BOOL)enabled {
    [self.redDot setHidden:enabled];
}

@end

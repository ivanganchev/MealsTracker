//
//  MealTypeView.h
//  SecondTask
//
//  Created by A-Team Intern on 23.08.21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MealTypeView : UIView

-(instancetype)initWithWidth:(float)componentWidth
                         height:(float)componentHeight
                         iconText:(NSString *)iconText
                         mealType:(NSString *)mealType;
@end

NS_ASSUME_NONNULL_END

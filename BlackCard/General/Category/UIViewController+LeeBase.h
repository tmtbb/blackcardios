

#import <UIKit/UIKit.h>

@interface UIViewController (LeeBase)
-(UIBarButtonItem *)loadLeftItemWithImage:(NSString *)image action:(SEL)action;
-(UIBarButtonItem *)loadRightItemWithImage:(NSString *)image action:(SEL)action;
-(UIBarButtonItem *)loadLeftItemWithTitle:(NSString *)title action:(SEL)action;
-(UIBarButtonItem *)loadRightItemWithTitle:(NSString *)title action:(SEL)action;


- (void)loadLeftItemWithImage:(NSString *)image Title:(NSString *)title action:(SEL)action;

-(void)loadItemWithFirstImage:(NSString *)image1 firstAction:(SEL)action1 secondImage:(NSString *)image2 secondAction:(SEL)action2 orientation:(NSString *)orientation;
- (void)setRightItemWithTitle:(NSString *)title action:(SEL)action;
@end

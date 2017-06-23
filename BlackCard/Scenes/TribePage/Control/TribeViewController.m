//
//  TribeViewController.m
//  BlackCard
//
//  Created by xmm on 2017/5/25.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//
#define TitleHeight 40  //头高度
#define NavBarHeight 64  //nav高度
#define YYScreenH [UIScreen mainScreen].bounds.size.height
#define YYScreenW [UIScreen mainScreen].bounds.size.width
#define SelectedColor kUIColorWithRGB(0xE3A63F)//选中颜色
#define NormoarlColor kUIColorWithRGB(0xA6A6A6)//默认颜色


#import "TribeViewController.h"
#import <HMSegmentedControl.h>

#import "TheArticleTableViewController.h"
#import "CardTribeViewController.h"
#import "UIView+XJExtension.h"
#import "CommentViewController.h"
#import "ManorViewController.h"

@interface TribeViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>


@property(strong,nonatomic)HMSegmentedControl *segmentControl;
@property(strong,nonatomic)UIButton *rightButton;

@property(strong,nonatomic)CardTribeViewController *cardTribeControl;
@property(strong,nonatomic)TheArticleTableViewController *articleControl;
@property(strong,nonatomic)ManorViewController  *manorControl;

@property (strong,nonatomic) UIPageViewController *pageViewController;

@end

@implementation TribeViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    

    // 设置导航条内容
//    [self setupNavgationBar];
    
    [self setTitleSegment];
    
  [self.pageViewController setViewControllers:@[self.cardTribeControl] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor =  [UIColor whiteColor];


}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     self.navigationController.navigationBar.barTintColor  = kUIColorWithRGB(0x434343);



}

#pragma mark - 添加所有的子控制器

- (void)setTitleSegment {
    UIView *all = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth - 16, 43)];
    HMSegmentedControl *control = [[HMSegmentedControl alloc]initWithSectionTitles:@[@"精英生活",@"邀请函",@"卡友部落"]];
    control.frame = CGRectMake(32, 11, kMainScreenWidth - 40 - 53, 32);
    control.type = HMSegmentedControlTypeText;
    control.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    control.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    //        control.selectionIndicatorEdgeInsets = UIEdgeInsetsMake(0, 10, 0,-10);
    control.selectionIndicatorHeight = 1.5;
    control.selectionIndicatorColor = kUIColorWithRGB(0xE3A63F);
    control.backgroundColor = [UIColor clearColor];
    control.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName :  kUIColorWithRGB(0xA6A6A6)};
    control.selectedTitleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName :kUIColorWithRGB(0xE3A63F)};
    WEAKSELF
    [control setIndexChangeBlock:^(NSInteger index) {
        [weakSelf changeChildController:index];
    }];
    
    [all addSubview:control];
    self.rightButton = [self buttonSetting];
    [all addSubview: _rightButton];
    _segmentControl = control;
    
    
    
    
    self.navigationItem.titleView = all;
    
    
}
- (UIButton *)buttonSetting {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kMainScreenWidth - 56, 0, 40, 43);
    [button setImage:[UIImage imageNamed:@"camera"] forState:UIControlStateNormal];
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 9, 4);
    [button addTarget:self action:@selector(momentClicked) forControlEvents:UIControlEventTouchUpInside];
    return button;
}






#pragma mark - 发布此刻心情
-(void)momentClicked{
    
    WEAKSELF
    [self pushWithIdentifier:@"MomentViewController" complete:^(UIViewController *controller) {
        controller.hidesBottomBarWhenPushed = YES;
        [controller setValue:@"此刻" forKey:@"name"];
        [controller setValue:weakSelf.cardTribeControl forKey:@"delegate"];
        
    }];

}

- (void)changeChildController:(NSInteger)index {
    self.rightButton.hidden = index != 0;

    switch (index) {
        case 0:
  [self.pageViewController setViewControllers:@[self.cardTribeControl] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
            break;
        case 1:{
            
            UIPageViewControllerNavigationDirection naviD = self.pageViewController.viewControllers.firstObject == self.cardTribeControl ? UIPageViewControllerNavigationDirectionForward :UIPageViewControllerNavigationDirectionReverse;
            [self.pageViewController setViewControllers:@[self.articleControl] direction:naviD  animated:YES completion:nil];

            
        }
            
            break;
        case 2:
        [self.pageViewController setViewControllers:@[self.manorControl] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
            break;
    }
}




#pragma mark - 懒加载

- (CardTribeViewController *)cardTribeControl {
    if (_cardTribeControl == nil) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        _cardTribeControl = [sb instantiateViewControllerWithIdentifier:@"CardTribeViewController"];
    }
    return _cardTribeControl;
}


- (TheArticleTableViewController *)articleControl {
    if (_articleControl == nil) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        _articleControl = [sb instantiateViewControllerWithIdentifier:@"TheArticleTableViewController"];
    }
    return _articleControl;
}
- (ManorViewController  *)manorControl {
    
    if (_manorControl == nil) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        _manorControl = [sb instantiateViewControllerWithIdentifier:@"ManorViewController"];
    }
    return _manorControl;
}



-(UIPageViewController *)pageViewController
{
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        [self.view addSubview:_pageViewController.view];
        [self addChildViewController:_pageViewController];
    }
    return _pageViewController;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

#pragma mark -PageViewController DataSource
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if (viewController == self.cardTribeControl) {
        return nil;
    }else {
        
        return viewController == self.articleControl ? self.cardTribeControl : self.articleControl;
    }
    return nil;
    
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    
    if (viewController == self.manorControl) {
        return nil;
    }else {
        return viewController == self.cardTribeControl ? self.articleControl    : self.manorControl;
    }
    
}

#pragma mark -PageViewController Delegate
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed) {
        UIViewController *control = pageViewController.viewControllers.firstObject;
        NSInteger pageCount = control== self.cardTribeControl ? 0 : (control == self.articleControl ? 1 : 2);
        self.segmentControl.selectedSegmentIndex = pageCount;
        self.rightButton.hidden = pageCount != 0;
        
        
    }

}





@end

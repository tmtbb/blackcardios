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


#import "CardTribeViewController.h"
#import "EliteLifeViewController.h"
#import "CEOThinkingViewController.h"
#import "UIView+XJExtension.h"
#import "MomentViewController.h"
#import "CommentViewController.h"

@interface TribeViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>


@property(strong,nonatomic)HMSegmentedControl *segmentControl;


@property(strong,nonatomic)CardTribeViewController *cardTribeControl;
@property(strong,nonatomic)EliteLifeViewController *eliteLifeControl;
@property(strong,nonatomic)CEOThinkingViewController *ceoControl;

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
    HMSegmentedControl *control = [[HMSegmentedControl alloc]initWithSectionTitles:@[@"卡友部落",@"精英生活",@"邀请函"]];
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
    [all addSubview:[self buttonSetting]];
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
    MomentViewController *mvc=[[MomentViewController alloc] init];
    mvc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:mvc animated:YES];
}

- (void)changeChildController:(NSInteger)index {
    
    switch (index) {
        case 0:
  [self.pageViewController setViewControllers:@[self.cardTribeControl] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
            break;
        case 1:{
            
            UIPageViewControllerNavigationDirection naviD = self.pageViewController.viewControllers.firstObject == self.cardTribeControl ? UIPageViewControllerNavigationDirectionForward :UIPageViewControllerNavigationDirectionReverse;
            [self.pageViewController setViewControllers:@[self.eliteLifeControl] direction:naviD  animated:YES completion:nil];

            
        }
            
            break;
        case 2:
        [self.pageViewController setViewControllers:@[self.ceoControl] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
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


- (EliteLifeViewController *)eliteLifeControl {
    if (_eliteLifeControl == nil) {
      _eliteLifeControl =   [[EliteLifeViewController alloc] init];
    }
    return _eliteLifeControl;
}

- (CEOThinkingViewController *)ceoControl {
    
    if (_ceoControl == nil) {
        _ceoControl = [[CEOThinkingViewController alloc] init];
    }
    return _ceoControl;
}




-(UIPageViewController *)pageViewController
{
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.view.backgroundColor = kUIColor_Red;
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
        
        return viewController == self.eliteLifeControl ? self.cardTribeControl : self.eliteLifeControl;
    }
    
    
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if (viewController == self.ceoControl) {
        return nil;
    }else {
        return viewController == self.cardTribeControl ? self.eliteLifeControl : self.ceoControl;
    }
    
}

#pragma mark -PageViewController Delegate
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed) {
        UIViewController *control = pageViewController.viewControllers.firstObject;
        NSInteger pageCount = control== self.cardTribeControl ? 0 : (control == self.eliteLifeControl ? 1 : 2);
        self.segmentControl.selectedSegmentIndex = pageCount;
        
    }

}



@end

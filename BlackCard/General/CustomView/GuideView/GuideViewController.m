//
//  GuideViewController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/5/31.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "GuideViewController.h"
#import "GuideSubviewController.h"
@interface GuideViewController ()<GuideSubviewControllerDelegate,UIPageViewControllerDelegate,UIPageViewControllerDataSource>
@property (strong,nonatomic) UIPageViewController *pageViewController;
@property(nonatomic)NSInteger page;
@property(strong,nonatomic)NSArray<NSString *> *imageArray;


@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _imageArray = [NSArray arrayWithObjects:@"guideViewOne",@"guideViewTwo",@"guideViewThree",@"guideViewFour", nil];
    GuideSubviewController *subController = [self createGuidSubViewController:0];
    [self.pageViewController setViewControllers:@[subController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}


- (void)didAction:(NSInteger)action data:(id)data {
    if ([self.delegate respondsToSelector:@selector(guideViewClose)]) {
        [self.delegate guideViewClose];
    }
    
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
#pragma mark -PageViewController DataSource
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger page = _page - 1;
    if (page < 0) {
        return nil;
    }else {
        GuideSubviewController *subController = [self createGuidSubViewController:page];
        return subController;
    }
    
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    
    NSInteger page = _page + 1;
    if (page > _imageArray.count -1 ) {
        return nil;
    }else {
        GuideSubviewController *subController = [self createGuidSubViewController:page];
        return subController;
    }
    
}

#pragma mark -PageViewController Delegate
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed) {
        GuideSubviewController *subController = pageViewController.viewControllers.firstObject;
        _page = subController.tag;
    }
    
}

- (GuideSubviewController *)createGuidSubViewController:(NSInteger )tag {
    
    GuideSubviewController *subController = [GuideSubviewController guideSubViewImageNamed: [_imageArray objectAtIndex:tag]];
    subController.tag = tag;
    subController.delegate = self;
    [subController showBottomButton:tag == _imageArray.count - 1 ];
    
    return subController;

}

@end

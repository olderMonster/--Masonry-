//
//  MTMainController.m
//  MeiTuan
//
//  Created by kehwa on 16/7/19.
//  Copyright © 2016年 kehwa. All rights reserved.
//

#import "MTMainController.h"

#import "OMTabbar.h"

#import "MTHomeController.h"
#import "MTSellerController.h"
#import "MTUserController.h"
#import "MTMoreController.h"

//设置自定义TabBar的高度
#define kTabbarHeight 44

@interface MTMainController ()<UINavigationControllerDelegate,OMTabbarDelegate>

@property (nonatomic , strong)OMTabbar *tabbar;

@end

@implementation MTMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildVC];

    [self.view addSubview:self.tabbar];
    
}

- (void)addChildVC{
    
    MTHomeController *homeVC = [[MTHomeController alloc]init];
    UINavigationController *homeNav = [[UINavigationController alloc]initWithRootViewController:homeVC];
    homeNav.delegate = self;
    [self addChildViewController:homeNav];
    
    MTSellerController *sellerVC = [[MTSellerController alloc]init];
    UINavigationController *sellerNav = [[UINavigationController alloc]initWithRootViewController:sellerVC];
    sellerNav.delegate = self;
    [self addChildViewController:sellerNav];
    
    MTUserController *userVC = [[MTUserController alloc]init];
    UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:userVC];
    userNav.delegate = self;
    [self addChildViewController:userNav];
    
    MTMoreController *moreVC = [[MTMoreController alloc]init];
    UINavigationController *moreNav = [[UINavigationController alloc]initWithRootViewController:moreVC];
    moreNav.delegate = self;
    [self addChildViewController:moreNav];
    
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    //获取当前导航控制器的根控制器
    UINavigationController *rootController = [navigationController.viewControllers objectAtIndex:0 ];
    if (rootController != viewController) {  //将要显示的控制器不是根控制器
        //设置导航控制器的高度，使下方的dock消失，并使导航控制器的高度变大
        CGRect frame = navigationController.view.frame;
        //frame.size.height = kScreenHeight;
        frame.size.height = [UIScreen mainScreen].bounds.size.height;
        navigationController.view.frame = frame;
        
        
        //添加dock到根控制器的view上，便于跳转时使dock跟随移动
        [self.tabbar removeFromSuperview];
        CGRect tabbarFrame = self.tabbar.frame;
        tabbarFrame.origin.y = rootController.view.frame.size.height - self.tabbar.frame.size.height;
        if ([rootController.view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scroll = (UIScrollView *)rootController.view;
            [scroll addSubview:self.tabbar];
            [UIView beginAnimations:nil context:nil];
            tabbarFrame.origin.y += scroll.contentOffset.y;
            [UIView commitAnimations];
            
        }
        self.tabbar.frame = tabbarFrame;
        [rootController.view addSubview:self.tabbar];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //开启手势
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    
    //获得当前导航控制器的根控制器
    UINavigationController *rootController = [navigationController.viewControllers objectAtIndex:0];
    if (rootController == viewController) {
        //将要显示的视图控制器是根视图控制器，此时tabbar出现，并加在self.view上
        //还原导航控制器视图的高度
        CGRect frame = navigationController.view.frame;
        frame.size.height = [UIScreen mainScreen].bounds.size.height - kTabbarHeight;
        navigationController.view.frame = frame;
        
        //添加tabbar到mainView上
        [self.tabbar removeFromSuperview];
        CGRect tabbarFrame = self.tabbar.frame;
        //调整tabbar的高度
        tabbarFrame.origin.y = self.view.frame.size.height - self.tabbar.frame.size.height;
        self.tabbar.frame = tabbarFrame;
        [self.view addSubview:self.tabbar];
    }
    
}


#pragma mark - OMTabbarDelegate
- (void)tabbar:(OMTabbar *)tabbar itemSelectedFrom:(int)from to:(int)to{
    if (to < 0 || to > self.childViewControllers.count) {
        return;
    }
    
    //取得旧的控制器的view
    UIViewController *oldController = [self.childViewControllers objectAtIndex:from];
    [oldController.view removeFromSuperview];
    
    //取得将要显示的控制器的view
    UIViewController *newController = [self.childViewControllers objectAtIndex:to];
    //设置将要显示的控制器的的view大小
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height - kTabbarHeight;
    newController.view.frame = CGRectMake(0, 0, width, height);
    //添加要显示的控制器的view
    [self.view addSubview:newController.view];
}


#pragma mark - getters and setters
- (OMTabbar *)tabbar{
    if (_tabbar == nil) {
        _tabbar = [[OMTabbar alloc]init];
        _tabbar.backgroundColor = [UIColor whiteColor];
        _tabbar.delegate = self;
        _tabbar.frame = CGRectMake(0, self.view.frame.size.height - kTabbarHeight, self.view.frame.size.width, kTabbarHeight);
        [_tabbar addItemwithIcon:@"icon_tabbar_onsite@2x.png" selectedIcon:@"icon_tabbar_onsite_selected@2x.png" title:@"首页"];
        [_tabbar addItemwithIcon:@"icon_tabbar_merchant_normal@2x" selectedIcon:@"icon_tabbar_merchant_selected@2x" title:@"商家"];
        [_tabbar addItemwithIcon:@"icon_tabbar_mine@2x.png" selectedIcon:@"icon_tabbar_mine_selected@2x.png" title:@"我的"];
        [_tabbar addItemwithIcon:@"icon_tabbar_misc@2x.png" selectedIcon:@"icon_tabbar_misc_selected@2x.png" title:@"更多"];
    }
    return _tabbar;
}

@end

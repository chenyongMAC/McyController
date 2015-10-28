//
//  MainTabBarController.m
//  XS27Weibo
//
//  Created by gj on 15/10/8.
//  Copyright (c) 2015年 www.huiwen.com 杭州汇文教育. All rights reserved.
//

#import "MainTabBarController.h"
#import "BaseNavController.h"
#import "Common.h"
#import "ThemeImageView.h"
#import "ThemeButton.h"



@interface MainTabBarController ()

@end

@implementation MainTabBarController{
    ThemeImageView *_selectedImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //警告：调用顺序不要变
    //01 加载子控制器
    [self _createSubControllers];
    //02 设置tabBar
    [self _creatTabBar];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (void)_creatTabBar{
    
    //01 移除原有tabBarButton
    for (UIView *view in self.tabBar.subviews) {
        //通过字符串获得类对象
        Class cls = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:cls]) {
            [view removeFromSuperview];
        }
    }
 
    //02 背景图片
    ThemeImageView *bgImageView = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 49)];
    bgImageView.imageName = @"mask_navbar.png";
    [self.tabBar addSubview:bgImageView];
    
    //03 按钮选中图片
    _selectedImageView = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/5, 49)];
    _selectedImageView.imageName = @"home_bottom_tab_arrow.png";
    [self.tabBar addSubview:_selectedImageView];
    
    //04 设置 按钮图片
    NSArray *imageNames = @[@"home_tab_icon_1.png",
                            @"home_tab_icon_2.png",
                            @"home_tab_icon_3.png",
                            @"home_tab_icon_4.png",
                            @"home_tab_icon_5.png"];
    CGFloat width = kScreenWidth/5;
    
    for (int i = 0; i<5; i++) {
        ThemeButton *button = [[ThemeButton alloc] initWithFrame:CGRectMake(i*width, 0, width, 49)];
        button.normalImageName = imageNames[i];
        button.tag = i;
        [button addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    
        [self.tabBar addSubview:button];
    }
    
}
- (void)selectAction:(UIButton *)button{
    [UIView animateWithDuration:0.3 animations:^{
         _selectedImageView.center = button.center;
    }];
   
    self.selectedIndex = button.tag;
}

//加载子控制器
- (void)_createSubControllers{
    
    NSArray *names = @[@"Home",@"Message",@"Discover",@"Profile",@"More"];
    NSMutableArray *navArray = [[NSMutableArray alloc] initWithCapacity:5];
    for (int i  = 0; i<5; i++) {
        //通过storyBoard加载子视图
        UIStoryboard *storyBoard = [UIStoryboard  storyboardWithName:names[i] bundle:nil];
        //创建storyboard中箭头指向的控制器（初始控制器），此处把导航控制器作为了storyboard的初始控制器
        BaseNavController *nav = [storyBoard instantiateInitialViewController];
        [navArray addObject:nav];
    }
    self.viewControllers = navArray;
}







@end

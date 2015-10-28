//
//  BaseNavController.m
//  XS27Weibo
//
//  Created by gj on 15/10/8.
//  Copyright (c) 2015年 www.huiwen.com 杭州汇文教育. All rights reserved.
//

#import "BaseNavController.h"
#import "ThemeManager.h"

@interface BaseNavController ()

@end

@implementation BaseNavController
#pragma mark - 初始化控制器，注意调用情况
//下面这个init方法不会被调用
- (instancetype)init{
    self = [super init];
    if (self) {
        NSLog(@"init方法会不会被调用呀");
    }
    return self;
    
}

//由于父级控制器是由storyboard加载的，子类中的初始化方法会调用initWithCoder
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange:) name:kThemeNameDidChangeNotification object:nil];
    }
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

#pragma mark - 监听方法
- (void)themeDidChange:(NSNotification *)notification{
    [self _loadImage];
}

#pragma mark - 加载图片
- (void)_loadImage{
    
    //01 设置导航栏背景图片
    ThemeManager *manager = [ThemeManager shareInstance];
    UIImage *image = [manager getThemeImage:@"mask_titlebar64.png"];
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    //02 标题颜色
    // Mask_Title_color
    UIColor *color  = [manager getThemeColor:@"Mask_Title_color"];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:color};
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self _loadImage];
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

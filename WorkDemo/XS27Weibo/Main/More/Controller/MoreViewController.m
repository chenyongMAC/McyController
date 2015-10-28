//
//  MoreViewController.m
//  HWWeibo
//
//  Created by gj on 15/9/9.
//  Copyright (c) 2015年 www.huiwen.com 杭州汇文教育. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreTableViewCell.h"
#import "ThemeTableViewController.h"

#import "AppDelegate.h"

static NSString *moreCellId = @"moreCellId";

@interface MoreViewController ()

@end

@implementation MoreViewController{
    
    UITableView *_tableView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _createTableView];
}

//每次出现的时候重新刷新数据
- (void)viewWillAppear:(BOOL)animated{
    
    [_tableView reloadData];
    
}


- (void)_createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    
    
    
    
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[MoreTableViewCell class] forCellReuseIdentifier:moreCellId];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    MoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:moreCellId forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            cell.themeImageView.imageName = @"more_icon_theme.png";
            cell.themeTextLabel.text = @"主题选择";
            cell.themeDetailLabel.text = [ThemeManager shareInstance].themeName;
        }
        else if(indexPath.row == 1) {
            cell.themeImageView.imageName = @"more_icon_account.png";
            cell.themeTextLabel.text = @"账户管理";
        }
    }
    else if(indexPath.section == 1) {
        cell.themeTextLabel.text = @"意见反馈";
        cell.themeImageView.imageName = @"more_icon_feedback.png";
    }
    
    //设置箭头
    if (indexPath.section < 2) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    
    return cell;
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 2;
    }
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //进入主题选择页面
    if (indexPath.row == 0 && indexPath.section == 0) {
        ThemeTableViewController *vc = [[ThemeTableViewController alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}



@end

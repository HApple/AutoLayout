//
//  SDAutoLayoutTimeLineViewController.m
//  AutoLayout
//
//  Created by Jn.Huang on 16/8/8.
//  Copyright © 2016年 huang. All rights reserved.
//

#import "SDAutoLayoutTimeLineViewController.h"
#import <SDAutoLayout.h>
#import "FDFeedEntity.h"
#import "DataManager.h"
#import "SDAutoLayoutFeedCell.h"


static NSString *kSDAutoLayoutFeedCellIdentify = @"SDAutoLayoutFeedCell";
@interface SDAutoLayoutTimeLineViewController ()

@property (nonatomic, strong)NSArray<FDFeedEntity*> *dataSource;
@end

@implementation SDAutoLayoutTimeLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [DataManager shareManager].entities;
    [self.tableView registerClass:[SDAutoLayoutFeedCell class] forCellReuseIdentifier:kSDAutoLayoutFeedCellIdentify];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SDAutoLayoutFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:kSDAutoLayoutFeedCellIdentify forIndexPath:indexPath];
    cell.entity = self.dataSource[indexPath.row];
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    ///////////////////////////////////////////////////////////////////////
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应步骤2 * >>>>>>>>>>>>>>>>>>>>>>>>
    /* model 为模型实例， keyPath 为 model 的属性名，通过 kvc 统一赋值接口 */
    
    return [self.tableView cellHeightForIndexPath:indexPath model:self.dataSource[indexPath.row] keyPath:@"entity" cellClass:[SDAutoLayoutFeedCell class] contentViewWidth:[self cellContentViewWith]];
    
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}
@end

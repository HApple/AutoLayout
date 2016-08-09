//
//  MasconryTimeLineViewController.m
//  AutoLayout
//
//  Created by Jn.Huang on 16/8/8.
//  Copyright © 2016年 huang. All rights reserved.
//

#import "MasconryTimeLineViewController.h"
#import "MasonryFeedCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "FDFeedEntity.h"
#import "DataManager.h"

static NSString *kMasonryFeedCellIdentify = @"MasonryFeedCell";
@interface MasconryTimeLineViewController ()

@property (nonatomic, strong)NSArray<FDFeedEntity*> *dataSource;
@end

@implementation MasconryTimeLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [DataManager shareManager].entities;
    [self.tableView registerClass:[MasonryFeedCell class] forCellReuseIdentifier:kMasonryFeedCellIdentify];
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
    
    MasonryFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:kMasonryFeedCellIdentify forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(MasonryFeedCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.fd_enforceFrameLayout = NO;
    cell.entity = self.dataSource[indexPath.row];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return [tableView fd_heightForCellWithIdentifier:kMasonryFeedCellIdentify cacheByIndexPath:indexPath configuration:^(MasonryFeedCell *cell) {
        [self configureCell:cell atIndexPath:indexPath];
    }];
    
}



@end

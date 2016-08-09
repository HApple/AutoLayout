//
//  SDAutoLayoutTableViewController.m
//  AutoLayout
//
//  Created by Jn.Huang on 16/8/4.
//  Copyright © 2016年 huang. All rights reserved.
//

#import "SDAutoLayoutTableViewController.h"
#import "SDAutoLayoutScrollViewController.h"
#import "SDAutoLayoutTimeLineViewController.h"

@interface SDAutoLayoutTableViewController ()

@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic, strong)NSMutableArray *classArray;

@end

@implementation SDAutoLayoutTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [NSMutableArray arrayWithObjects:@"UIScrollView 内容自适应",@"UITableView 高度自适应", nil];
    self.classArray = [NSMutableArray arrayWithObjects:[SDAutoLayoutScrollViewController class],
                                                       [SDAutoLayoutTimeLineViewController class],
                       nil];
    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SDAutolayoutCell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.navigationController pushViewController:[[self.classArray[indexPath.row] alloc] init] animated:YES];
}
@end

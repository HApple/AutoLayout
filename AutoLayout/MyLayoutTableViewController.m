//
//  MyLayoutTableViewController.m
//  AutoLayout
//
//  Created by Jn.Huang on 16/8/4.
//  Copyright © 2016年 huang. All rights reserved.
//

#import "MyLayoutTableViewController.h"
#import "MyLaoutScrollViewController.h"
#import "MyLayoutTimeLineViewController.h"
#import "MyLayoutTagCloundViewController.h"


@interface MyLayoutTableViewController ()

@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic, strong)NSMutableArray *classArray;
@end

@implementation MyLayoutTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [NSMutableArray arrayWithObjects:@"UIScrollView 内容自适应",@"UITableView 高度自适应",@"标签流", nil];
    self.classArray = [NSMutableArray arrayWithObjects:[MyLaoutScrollViewController class],
                                                       [MyLayoutTimeLineViewController class],
                                                       [MyLayoutTagCloundViewController class],
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyLayoutCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    // 注意这里。为了达到动态高度TableViewCell的加载性能最高以及高性能，一定要实现estimatedHeightForRowAtIndexPath这个方法。这个方法用来评估
    //UITableViewCell的高度。如果实现了这个方法，系统会根据数量重复调用这个方法，得出评估的总体高度。然后再根据显示的需要调用heightForRowAtIndexPath方法来确定真实的高度。如果您不实现estimatedHeightForRowAtIndexPath这个方法，加载性能将非常的低下！！！！
    return 40;  //这个评估尺寸你可以根据你的cell的一般高度来设置一个最合适的值。
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.navigationController pushViewController:[[self.classArray[indexPath.row] alloc] init] animated:YES];
}

@end

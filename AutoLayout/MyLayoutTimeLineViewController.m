//
//  MyLayoutTimeLineViewController.m
//  AutoLayout
//
//  Created by Jn.Huang on 16/8/8.
//  Copyright © 2016年 huang. All rights reserved.
//

#import "MyLayoutTimeLineViewController.h"
#import "MyLayoutFeedCell.h"
#import "FDFeedEntity.h"
#import <MyLayout.h>
#import "DataManager.h"

static NSString *kMyLayoutFeedCellIdentify = @"MyLayoutFeedCell";
@interface MyLayoutTimeLineViewController ()

@property (nonatomic, strong)NSArray<FDFeedEntity*> *dataSource;
@end

@implementation MyLayoutTimeLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [DataManager shareManager].entities;
 // [self.tableView registerClass:[MyLayoutFeedCell class] forCellReuseIdentifier:kMyLayoutFeedCellIdentify];
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

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    // 注意这里。为了达到动态高度TableViewCell的加载性能最高以及高性能，一定要实现estimatedHeightForRowAtIndexPath这个方法。这个方法用来评估
    //UITableViewCell的高度。如果实现了这个方法，系统会根据数量重复调用这个方法，得出评估的总体高度。然后再根据显示的需要调用heightForRowAtIndexPath方法来确定真实的高度。如果您不实现estimatedHeightForRowAtIndexPath这个方法，加载性能将非常的低下！！！！
    return 40;  //这个评估尺寸你可以根据你的cell的一般高度来设置一个最合适的值。
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 不能用这个方式初始化cell 会死循环,由于heightForRowAtIndexPath方法里调用了此方法
    // MyLayoutFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:kMyLayoutFeedCellIdentify forIndexPath:indexPath];
     
    MyLayoutFeedCell *cell = (MyLayoutFeedCell*)[tableView dequeueReusableCellWithIdentifier:kMyLayoutFeedCellIdentify];
    if (cell == nil){
        cell = [[MyLayoutFeedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kMyLayoutFeedCellIdentify];
    }
    cell.entity = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyLayoutFeedCell *cell = (MyLayoutFeedCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    //通过布局视图的estimateLayoutRect函数能够评估出UITableViewCell的动态高度。estimateLayoutRect并不会进行布局
    //而只是评估布局的尺寸，这里的宽度不传0的原因是上面的UITableViewCell在建立时默认的宽度是320(不管任何尺寸都如此),因此如果我们
    //传递了宽度为0的话则会按320的宽度来评估UITableViewCell的动态高度，这样当在375和414的宽度时评估出来的高度将不会正确，因此这里需要
    //指定出真实的宽度尺寸；而高度设置为0的意思是表示高度不是固定值需要评估出来。
    //UITableViewCell的动态高度评估不局限于线性布局，相对布局也是同样适用的。
    CGRect rect = [cell.rootLayout estimateLayoutRect:CGSizeMake(tableView.frame.size.width, 0)];
    return rect.size.height + 1;  //如果使用系统自带的分割线，请返回rect.size.height+1
}




@end

//
//  MasonryScrollViewController.m
//  AutoLayout
//
//  Created by Jn.Huang on 16/8/8.
//  Copyright © 2016年 huang. All rights reserved.
//

#import "MasonryScrollViewController.h"
#import <Masonry.h>

@interface MasonryScrollViewController ()

@end

@implementation MasonryScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {
    [super loadView];
    
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    
    
    /*先加到父视图上，再设置约束,这个步骤必须在前！！否则会崩溃
      SDAutoLayout一样也是必须先加到父视图上，才能设置自动布局
     */
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(5,5,5,5));//设置scrollView大小与父视图内边距为5
    }];
    
    
    /*
     创建一个视图容器container加到scrollView里
     container的edges与scrollView相同，这个决定container的位置,与scrollView各边距为0
     
     container的width与height才是决定它的大小，而这个也决定了scrollView的contentSize
     
     在这里(伪代码)
     scrollView.contentSize = CGSizeMake(container.witdth + container.左边距 + container.右边距,
                                         container.height + container.顶部边距 + container.底部边距,)
     
     而container的width与scrollView相同，且左边距右边距为0，所以实际上横向不能滑动
     container的height由其子视图决定，具体分析下for循环里的代码
     
     */
    
    UIView *container = [UIView new];
    [scrollView addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
    }];
    
    int count = 5;
    
    //自上而下的顺序依次排列视图
    UIView *lastView = nil;
    for ( int i = 1 ; i <= count ; ++i ){
        UIView *subv = [UIView new];
        subv.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
                                          saturation:( arc4random() % 128 / 256.0 ) + 0.5
                                          brightness:( arc4random() % 128 / 256.0 ) + 0.5
                                               alpha:1];
        
        //先加入到父视图，然后再设置其约束
        [container addSubview:subv];
        
        [subv mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.and.right.equalTo(container);//左右边距为0，相当于宽度与父视图与相等
            
            make.height.mas_equalTo(@(100+(i*20)));//设置高度
            
            if ( lastView ){
                make.top.mas_equalTo(lastView.mas_bottom);//设置排列在上一视图的下端
            }
            else{
                make.top.mas_equalTo(container.mas_top);//设置在顶端的子视图与父视图顶部边距相同
            }
        }];
        
        lastView = subv;
    }
    

    /*最后设置一下最底部的lastView与父视图container底部的距离，以此能自动计算出container的高度，
     也就算出了scrollView的contentSize,确定了能滑动的范围
     */
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView.mas_bottom);
    }];
}

@end

//
//  SDAutoLayoutScrollViewController.m
//  AutoLayout
//
//  Created by Jn.Huang on 16/8/8.
//  Copyright © 2016年 huang. All rights reserved.
//

#import "SDAutoLayoutScrollViewController.h"
#import <SDAutoLayout.h>

@interface SDAutoLayoutScrollViewController ()

@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic, strong)NSMutableArray *classArray;

@end

@implementation SDAutoLayoutScrollViewController

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
    
    /*
     SDAutoLayout 与 Masonry相同，先加入到父视图，后设置布局
     */
    [self.view addSubview:scrollView];
    scrollView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(5,5,5,5));//设置scrollView与父视图各边距为0,即确定了大小与位置
    
    
    
    int count = 5;
    
    //自上而下的顺序依次排列视图
    UIView *lastView = nil;
    for ( int i = 1 ; i <= count ; ++i ){
        UIView *subv = [UIView new];
        subv.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
                                          saturation:( arc4random() % 128 / 256.0 ) + 0.5
                                          brightness:( arc4random() % 128 / 256.0 ) + 0.5
                                               alpha:1];
        
        [scrollView addSubview:subv];
        subv.sd_layout
        .leftSpaceToView(scrollView,0)
        .rightSpaceToView(scrollView,0)
        .heightIs(100+(i*20));
        
        
        if ( lastView ){
            subv.sd_layout.topSpaceToView(lastView,0);//设置排列在上一视图的下端
        }
        else{
            subv.sd_layout.topSpaceToView(scrollView,0);//设置在顶端的子视图与父视图顶部边距相同
        }
        
        lastView = subv;
    }
    
    
    // scrollview自动contentsize
    [scrollView setupAutoContentSizeWithBottomView:lastView bottomMargin:0];
    
    
    
    
    
}

@end

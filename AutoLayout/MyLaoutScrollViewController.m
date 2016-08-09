//
//  MyLaoutScrollViewController.m
//  AutoLayout
//
//  Created by Jn.Huang on 16/8/8.
//  Copyright © 2016年 huang. All rights reserved.
//

#import "MyLaoutScrollViewController.h"
#import <MyLayout.h>

@interface MyLaoutScrollViewController ()

@end

@implementation MyLaoutScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self setUpScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {
    
    [super loadView];
    
    /*这样写居然没有任何效果...
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.myMargin = 5;
    [self.view addSubview:scrollView];
    */
    
    
    /*第一种方式 就正常设置frame
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; //让uiscrollView的尺寸总是保持和父视图一致。
    [self.view addSubview:scrollView];
     */
    
    
    //第二种方式 反正就要滚动，设置self.view = scrollView
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.backgroundColor = [UIColor whiteColor];
    self.view = scrollView;
    
    /*由于我们是要实现从上而下按顺序添加视图 所以这里涉及到线性布局MyLinearLayout
     线性布局是一种里面的子视图按添加的顺序从上到下或者从左到右依次排列的单列(单行)布局视图
     */
    
    /*MyLayoutViewOrientation_Vert = 0,  //整体从上到下    
      MyLayoutViewOrientation_Horz = 1,  //整体从左到右
     */

    MyLinearLayout *contentLayout = [MyLinearLayout linearLayoutWithOrientation:MyLayoutViewOrientation_Vert];
    contentLayout.padding = UIEdgeInsetsMake(5, 5, 5 ,5); //设置布局内的子视图离自己的边距.
    contentLayout.myLeftMargin = 0;
    contentLayout.myRightMargin = 0;                          //同时指定左右边距为0表示宽度和父视图一样宽
    
    /*
     heightDime  这种加上Dime的属性，是相当于设置自动布局尺寸，
     而myHeight则是直接设置frame里的height
     */
    contentLayout.heightDime.lBound(scrollView.heightDime, 10, 1); //高度虽然是wrapContentHeight的。但是最小的高度不能低于父视图的高度加10.
    [scrollView addSubview:contentLayout];

    int count = 5;
    
    //自上而下的顺序依次排列视图

    for ( int i = 1 ; i <= count ; ++i ){
        UIView *subv = [UIView new];
        subv.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
                                          saturation:( arc4random() % 128 / 256.0 ) + 0.5
                                          brightness:( arc4random() % 128 / 256.0 ) + 0.5
                                               alpha:1];
        
        /*
            由于MyLinearLayout都帮我们处理好了上下图关系，
            只需要设置下位置大小就好
         */
        subv.myHeight = 100+(i*20);
        subv.myTopMargin = 0;
        subv.myLeftMargin = 0;
        subv.myRightMargin = 0;
        [contentLayout addSubview:subv];
    }
    

    
    
    
}

@end

//
//  MyLayoutTagCloundViewController.m
//  AutoLayout
//
//  Created by Jn.Huang on 16/8/7.
//  Copyright © 2016年 huang. All rights reserved.
//

#import "MyLayoutTagCloundViewController.h"
#import <MyLayout.h>
#import "DataManager.h"

@interface MyLayoutTagCloundViewController ()

@property (nonatomic, strong)MyFlowLayout *flowLayout;
@end

@implementation MyLayoutTagCloundViewController

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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.flowLayout = [[MyFlowLayout alloc] initWithOrientation:MyLayoutViewOrientation_Vert arrangedCount:0];
    self.flowLayout.myMargin = 0;
    self.flowLayout.myTopMargin = 64;
    
    self.flowLayout.subviewMargin = 10;
    
    /**
     * 设置布局视图四周的内边距值。所谓内边距是指布局视图内的所有子视图离布局视图四周的边距。通过为布局视图设置内边距可以减少为所有子视图设置外边距的工作，而外边距则是指视图离父视图四周的距离。
     */
    self.flowLayout.topPadding = 20;
    self.flowLayout.leftPadding = 20;
    self.flowLayout.rightPadding = 15;
    
    [self.view addSubview:self.flowLayout];
    
    [[DataManager shareManager].tagTexts enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self createTagButton:obj];
        
    }];
    

    
}

-(void)createTagButton:(NSString*)text
{
    UIButton *tagButton = [UIButton new];
    [tagButton setTitle:text forState:UIControlStateNormal];
    tagButton.layer.cornerRadius = 20;
    tagButton.backgroundColor = [UIColor colorWithRed:random()%255 / 255.0 green:random()%128 / 255.0 blue:random()%128 / 255.0 alpha:1];
    
    //这里可以看到尺寸宽度等于自己的尺寸宽度并且再增加10，且最小是40，意思是按钮的宽度是等于自身内容的宽度再加10，但最小的宽度是40
    //如果没有这个设置，而是直接调用了sizeToFit则按钮的宽度就是内容的宽度。
    tagButton.widthDime.equalTo(tagButton.widthDime).add(20).min(40);
    tagButton.heightDime.equalTo(tagButton.heightDime).add(10); //高度根据自身的内容再增加10
    [tagButton sizeToFit];
    [self.flowLayout addSubview:tagButton];
    
}

@end

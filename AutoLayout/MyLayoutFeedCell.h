//
//  MyLayoutFeedCell.h
//  AutoLayout
//
//  Created by Jn.Huang on 16/8/8.
//  Copyright © 2016年 huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDFeedEntity.h"
#import <MyLayout.h>

@interface MyLayoutFeedCell : UITableViewCell

//对于需要动态评估高度的UITableViewCell来说可以把布局视图暴露出来。用于高度评估和边界线处理。以及事件处理的设置。
@property(nonatomic, strong, readonly) MyBaseLayout *rootLayout;

@property (nonatomic, strong) FDFeedEntity *entity;
@end

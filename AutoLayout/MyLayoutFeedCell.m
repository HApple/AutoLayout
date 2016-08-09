//
//  MyLayoutFeedCell.m
//  AutoLayout
//
//  Created by Jn.Huang on 16/8/8.
//  Copyright © 2016年 huang. All rights reserved.
//

#import "MyLayoutFeedCell.h"


@interface MyLayoutFeedCell ()

@property (nonatomic, strong)  UILabel *titleLabel;
@property (nonatomic, strong)  UILabel *contentLabel;
@property (nonatomic, strong)  UIImageView *contentImageView;
@property (nonatomic, strong)  UILabel *usernameLabel;
@property (nonatomic, strong)  UILabel *timeLabel;

@end

@implementation MyLayoutFeedCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    
    //这里采用线性布局实现
    _rootLayout = [MyLinearLayout linearLayoutWithOrientation:MyLayoutViewOrientation_Vert];
   _rootLayout.leftPadding = 10;

    /*
     在UITableViewCell中使用MyLayout中的布局时请将布局视图作为contentView的子视图。如果我们的UITableViewCell的高度是动态的，请务必在将布局视图添加到contentView之前进行如下设置：
     _rootLayout.widthDime.equalTo(self.contentView.widthDime);
     _rootLayout.wrapContentHeight = YES;
     */
    _rootLayout.widthDime.equalTo(self.contentView.widthDime);
    _rootLayout.wrapContentHeight = YES;
    _rootLayout.wrapContentWidth = NO;
    _rootLayout.leftPadding = 15;
    [self.contentView addSubview:_rootLayout];

    
    
    
    _titleLabel = [UILabel new];
    _titleLabel.textColor = [UIColor colorWithRed:0 green:0 blue:127/255 alpha:1];
    _titleLabel.numberOfLines = 0;
    _titleLabel.myTopMargin = 10;
    _titleLabel.myLeftMargin = 0;//垂直线性布局里面如果同时设置了左右边距则能确定子视图的宽度
    _titleLabel.myRightMargin = 16;
    _titleLabel.flexedHeight = YES;//如果想让文本的高度是动态的，请在设置明确宽度的情况下将numberOfLines设置为0并且将flexedHeight设置为YES。
    [_rootLayout addSubview:_titleLabel];
    
    _contentLabel = [UILabel new];
    _contentLabel.textColor = [UIColor darkGrayColor];
    _contentLabel.numberOfLines = 0;
    _contentLabel.myTopMargin = 6;
    _contentLabel.myLeftMargin = 0;
    _contentLabel.myRightMargin = 10;
    _contentLabel.flexedHeight = YES;
    [_rootLayout addSubview:_contentLabel];
    
    

    _contentImageView = [UIImageView new];
    _contentImageView.contentMode = UIViewContentModeScaleAspectFit;
    _contentImageView.myTopMargin = 10;
    [_rootLayout addSubview:_contentImageView];
    
    
    MyLinearLayout *bottomLayout = [MyLinearLayout linearLayoutWithOrientation:MyLayoutViewOrientation_Horz];
    bottomLayout.myTopMargin = 8;
    bottomLayout.myRightMargin = 10;
    bottomLayout.myLeftMargin = 0;
    bottomLayout.myBottomMargin = 4;
    bottomLayout.wrapContentHeight = YES;
    bottomLayout.wrapContentWidth = NO;
    bottomLayout.widthDime.equalTo(_rootLayout.widthDime);
    [_rootLayout addSubview:bottomLayout];
    
    _usernameLabel = [UILabel new];
    _usernameLabel.textColor = [UIColor lightGrayColor];
    _usernameLabel.myLeftMargin = 0;
    _usernameLabel.widthDime.equalTo(bottomLayout.widthDime).multiply(0.5);
    _usernameLabel.myHeight = 20;
    
    [bottomLayout addSubview:_usernameLabel];
    
    _timeLabel = [UILabel new];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel.textColor = [UIColor colorWithRed:140/255 green:170/255 blue:228/255 alpha:1];
    _timeLabel.widthDime.equalTo(bottomLayout.widthDime).multiply(0.5);
    _timeLabel.myRightMargin = 0;
    _timeLabel.myHeight = 20;
    [bottomLayout addSubview:_timeLabel];
    
}


- (void)setEntity:(FDFeedEntity *)entity
{
    _entity = entity;
    
    self.titleLabel.text = entity.title;
    self.contentLabel.text = entity.content;
    
    UIImage *image = entity.imageName.length > 0 ? [UIImage imageNamed:entity.imageName] : nil;
    if (image) {
        self.contentImageView.hidden = NO;
        self.contentImageView.image = image;
        [self.contentImageView sizeToFit];
    }else{
        self.contentImageView.hidden = YES;
    }
    
    
    
    self.usernameLabel.text = entity.username;
    self.timeLabel.text = entity.time;
    

}

@end

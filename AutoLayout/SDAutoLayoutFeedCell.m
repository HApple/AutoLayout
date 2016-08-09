//
//  SDAutoLayoutFeedCell.m
//  AutoLayout
//
//  Created by Jn.Huang on 16/8/8.
//  Copyright © 2016年 huang. All rights reserved.
//

#import "SDAutoLayoutFeedCell.h"
#import <SDAutoLayout.h>

@interface SDAutoLayoutFeedCell ()

@property (nonatomic, strong)  UILabel *titleLabel;
@property (nonatomic, strong)  UILabel *contentLabel;
@property (nonatomic, strong)  UIImageView *contentImageView;
@property (nonatomic, strong)  UILabel *usernameLabel;
@property (nonatomic, strong)  UILabel *timeLabel;
@end

@implementation SDAutoLayoutFeedCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    
    _titleLabel = [UILabel new];
    _titleLabel.textColor = [UIColor colorWithRed:0 green:0 blue:127/255 alpha:1];
    _titleLabel.numberOfLines = 0;
    
    _contentLabel = [UILabel new];
    _contentLabel.textColor = [UIColor darkGrayColor];
    _contentLabel.numberOfLines = 0;
    
    _contentImageView = [UIImageView new];
    _contentImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    _usernameLabel = [UILabel new];
    _usernameLabel.textColor = [UIColor lightGrayColor];
    
    _timeLabel = [UILabel new];
    _timeLabel.textColor = [UIColor colorWithRed:140/255 green:170/255 blue:228/255 alpha:1];
    
    [self.contentView sd_addSubviews:@[_titleLabel,_contentLabel,_contentImageView,_usernameLabel,_timeLabel]];
    
    _titleLabel.sd_layout
    .topSpaceToView(self.contentView,10)
    .leftSpaceToView(self.contentView,10)
    .rightSpaceToView(self.contentView,16)
    .autoHeightRatio(0);
    
    _contentLabel.sd_layout
    .topSpaceToView(_titleLabel,10)
    .leftEqualToView(_titleLabel)
    .rightSpaceToView(self.contentView,16)
    .autoHeightRatio(0);
    
    _contentImageView.sd_layout
    .topSpaceToView(_contentLabel,8)
    .leftEqualToView(_titleLabel);
    
    
    _usernameLabel.sd_layout
    .topSpaceToView(_contentImageView,8)
    .leftEqualToView(_titleLabel)
    .heightIs(20);
    [_usernameLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    _timeLabel.sd_layout
    .rightSpaceToView(self.contentView,10)
    .heightIs(20)
    .centerYEqualToView(_usernameLabel);
    [_timeLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    
    
}


- (void)setEntity:(FDFeedEntity *)entity
{
    _entity = entity;
    
    self.titleLabel.text = entity.title;
    self.contentLabel.text = entity.content;
    
    UIImage *image = entity.imageName.length > 0 ? [UIImage imageNamed:entity.imageName] : nil;
    self.contentImageView.image = image;
    
    
    // 在实际的开发中，网络图片的宽高应由图片服务器返回然后计算宽高比。
    if (image.size.width > 0) {
        CGFloat imageMaxWidth = [UIScreen mainScreen].bounds.size.width - 10 - 8;
        CGFloat scale = image.size.height / image.size.width;
        self.contentImageView.sd_layout.widthIs(MIN(imageMaxWidth, image.size.width));
        self.contentImageView.sd_layout.autoHeightRatio(scale);

    } else {
        self.contentImageView.sd_layout.autoHeightRatio(0);

    }
    
    self.usernameLabel.text = entity.username;
    self.timeLabel.text = entity.time;
    
     //***********************高度自适应cell设置步骤************************
    [self setupAutoHeightWithBottomView:_usernameLabel bottomMargin:4];
}


@end

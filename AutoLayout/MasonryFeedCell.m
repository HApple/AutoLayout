//
//  MasonryFeedCell.m
//  AutoLayout
//
//  Created by Jn.Huang on 16/8/8.
//  Copyright © 2016年 huang. All rights reserved.
//

#import "MasonryFeedCell.h"
#import <Masonry.h>

@interface MasonryFeedCell ()

@property (nonatomic, strong)  UILabel *titleLabel;
@property (nonatomic, strong)  UILabel *contentLabel;
@property (nonatomic, strong)  UIImageView *contentImageView;
@property (nonatomic, strong)  UILabel *usernameLabel;
@property (nonatomic, strong)  UILabel *timeLabel;

@end

@implementation MasonryFeedCell

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
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.mas_equalTo(10);
        make.trailing.mas_equalTo(-10);
    }];
    
    _contentLabel = [UILabel new];
    _contentLabel.textColor = [UIColor darkGrayColor];
    _contentLabel.numberOfLines = 0;
    [self.contentView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(10);
        make.leading.equalTo(_titleLabel);
        make.trailing.mas_equalTo(-10);
    }];
    
    _contentImageView = [UIImageView new];
    _contentImageView.contentMode = UIViewContentModeLeft;
    [self.contentView addSubview:_contentImageView];
    [_contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.mas_equalTo(_contentLabel.mas_bottom).offset(8);
       make.leading.equalTo(_titleLabel);
       make.trailing.mas_greaterThanOrEqualTo(16);
    }];
    
    
    _usernameLabel = [UILabel new];
    _usernameLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_usernameLabel];
    [_usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_contentImageView.mas_bottom).offset(8);
        make.leading.equalTo(_titleLabel);
        make.bottom.mas_equalTo(-4);
    }];
    
    _timeLabel = [UILabel new];
    _timeLabel.textColor = [UIColor colorWithRed:140/255 green:170/255 blue:228/255 alpha:1];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-10);
        make.baseline.equalTo(_usernameLabel);
    }];
    
}


- (void)setEntity:(FDFeedEntity *)entity
{
    _entity = entity;
    
    self.titleLabel.text = entity.title;
    self.contentLabel.text = entity.content;
    self.contentImageView.image = entity.imageName.length > 0 ? [UIImage imageNamed:entity.imageName] : nil;
    self.usernameLabel.text = entity.username;
    self.timeLabel.text = entity.time;
}

@end

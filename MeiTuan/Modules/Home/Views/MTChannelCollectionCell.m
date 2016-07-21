//
//  MTChannelCollectionCell.m
//  MeiTuan
//
//  Created by kehwa on 16/7/19.
//  Copyright © 2016年 kehwa. All rights reserved.
//

#import "MTChannelCollectionCell.h"
#import <Masonry/Masonry.h>
#import "OMNetworkingConfiguration.h"
@interface MTChannelCollectionCell()

@property (nonatomic , strong)UIImageView *channelImageView;
@property (nonatomic , strong)UILabel *channaelTitleLabel;

@end

@implementation MTChannelCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _channelImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_customReview_image_default"]];
        _channelImageView.backgroundColor = [UIColor grayColor];
        _channelImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_channelImageView];
        
        _channaelTitleLabel = [[UILabel alloc]init];
        _channelImageView.backgroundColor = [UIColor redColor];
        _channaelTitleLabel.font = [UIFont systemFontOfSize:10];
        _channaelTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_channaelTitleLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    WS(weakSelf);
    
    [self.channelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).with.offset(10);
        make.centerX.equalTo(weakSelf.contentView);
        make.width.equalTo(@40);
        make.height.equalTo(@40);
        
    }];
    
    self.channelImageView.layer.cornerRadius = self.channelImageView.bounds.size.width * 0.5;
    
    
    [self.channaelTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(@0);
        make.top.equalTo(weakSelf.channelImageView.mas_bottom).with.offset(5);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        
    }];
    
}


- (void)setChannel:(NSDictionary *)channel{
    _channel = channel;
    
    self.channelImageView.image = [UIImage imageNamed:channel[@"image"]];
    self.channaelTitleLabel.text = channel[@"title"];
    
}

@end

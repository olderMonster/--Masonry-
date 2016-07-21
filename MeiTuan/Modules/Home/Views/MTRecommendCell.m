//
//  MTRecommendCell.m
//  MeiTuan
//
//  Created by kehwa on 16/7/19.
//  Copyright © 2016年 kehwa. All rights reserved.
//

#import "MTRecommendCell.h"
#import "OMNetworkingConfiguration.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
@interface MTRecommendCell()

@property (nonatomic , strong)UIImageView *merchantImageView;   //商家图片
@property (nonatomic , strong)UIImageView *unbookImageView;     //免预约
@property (nonatomic , strong)UILabel *merchantNameLabel;       //商家名称
@property (nonatomic , strong)UILabel *usedRangeLabel;          //使用范围
@property (nonatomic , strong)UILabel *merchantInfoLabel;       //简介
@property (nonatomic , strong)UILabel *onlinePriceLabel;        //网络价格
@property (nonatomic , strong)UILabel *storePriceLabel;         //门店价格
@property (nonatomic , strong)UILabel *distanceLabel;           //距离
@property (nonatomic , strong)UILabel *salesLabel;              //销量

@end

@implementation MTRecommendCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _merchantImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_merchantImageView];
        
        
        _unbookImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_deal_noBooking"]];
        [self.contentView addSubview:_unbookImageView];
        
        _merchantNameLabel = [[UILabel alloc]init];
        _merchantNameLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_merchantNameLabel];
        
        _merchantInfoLabel = [[UILabel alloc]init];
        _merchantInfoLabel.font = [UIFont systemFontOfSize:10];
        _merchantInfoLabel.textColor = [UIColor grayColor];
        _merchantInfoLabel.numberOfLines = 2;
        [_merchantInfoLabel sizeToFit];
        [self.contentView addSubview:_merchantInfoLabel];
        
        _onlinePriceLabel = [[UILabel alloc]init];
        _onlinePriceLabel.font = [UIFont systemFontOfSize:14];
        _onlinePriceLabel.textColor = RGB(96, 182, 175);
        [self.contentView addSubview:_onlinePriceLabel];
        
        
        _storePriceLabel = [[UILabel alloc]init];
        _storePriceLabel.font = [UIFont systemFontOfSize:10];
        _storePriceLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_storePriceLabel];
        
        _salesLabel = [[UILabel alloc]init];
        _salesLabel.font = [UIFont systemFontOfSize:10];
        _salesLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_salesLabel];
        
        
        _distanceLabel = [[UILabel alloc]init];
        _distanceLabel.font = [UIFont systemFontOfSize:10];
        _distanceLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_distanceLabel];
        
        
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.merchantImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(10);
        make.left.equalTo(self.contentView).with.offset(10);
        make.height.equalTo(@(self.contentView.bounds.size.height - 20));
        make.width.equalTo(@(self.contentView.bounds.size.height - 20));
    }];
    

    [self.unbookImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.merchantImageView.mas_top);
        make.left.equalTo(self.merchantImageView.mas_left);
    }];
    
    
    [self.merchantNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        /**
         *  相对merchantImageView的最右边来说，距离merchantImageView最右边是10px
         */
        make.left.equalTo(self.merchantImageView.mas_right).with.offset(10);
        make.top.equalTo(self.merchantImageView.mas_top);
        make.height.equalTo(@20);
    }];
    
    
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.merchantNameLabel.mas_centerY);
        make.left.equalTo(self.merchantNameLabel.mas_right);
        make.right.equalTo(self.contentView).with.offset(-10);
        make.height.equalTo(self.merchantNameLabel.mas_height);
    }];

    
    [self.merchantInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.merchantNameLabel.mas_left);
        make.right.equalTo(self.contentView).with.offset(-10);
        make.top.equalTo(self.merchantNameLabel.mas_bottom);
    }];
    
    
    [self.onlinePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.merchantNameLabel.mas_left);
        make.bottom.equalTo(self.merchantImageView.mas_bottom);
        make.height.equalTo(@(self.onlinePriceLabel.font.pointSize));
        
    }];
    
    [self.storePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.onlinePriceLabel.mas_right).with.offset(3);
        make.centerY.equalTo(self.onlinePriceLabel.mas_centerY);
        make.height.equalTo(self.onlinePriceLabel.mas_height);
    }];
    
    [self.salesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).with.offset(-10);
        make.centerY.equalTo(self.onlinePriceLabel.mas_centerY);
        make.height.equalTo(self.onlinePriceLabel.mas_height);
        
    }];
    
}


#pragma mark - getters and setters
- (void)setRecommend:(NSDictionary *)recommend{
    
    _recommend = recommend;
    
    NSString *imageUrl = [recommend[@"squareimgurl"] stringByReplacingOccurrencesOfString:@"w.h" withString:@"160.0"];
    [self.merchantImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"bg_customReview_image_default.png"]];
    self.merchantNameLabel.text = recommend[@"mname"];
    self.distanceLabel.text = @"<150m";
    
    self.merchantInfoLabel.text = [NSString stringWithFormat:@"[%@]%@",recommend[@"range"],recommend[@"title"]];
    
    //网价
    self.onlinePriceLabel.text = [NSString stringWithFormat:@"￥%.2f",[recommend[@"price"] floatValue]];
    //门市价
    self.storePriceLabel.text = [NSString stringWithFormat:@"门市价:￥%.2f",[recommend[@"price"] floatValue]];
    //销量
    if (recommend[@"rating"] && recommend[@"rate-count"]) {
        self.salesLabel.text = [NSString stringWithFormat:@"%@分(%@人)",recommend[@"rating"],recommend[@"rate-count"]];
    }else{
        self.salesLabel.text = @"暂无评分";
    }
    
}

@end

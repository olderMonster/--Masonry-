
//
//  MTDiscountCollectionCell.m
//  MeiTuan
//
//  Created by kehwa on 16/7/19.
//  Copyright © 2016年 kehwa. All rights reserved.
//

#import "MTDiscountCollectionCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "OMNetworkingConfiguration.h"
#import "UIColor+HandleAddition.h"
#import <Masonry/Masonry.h>
@interface MTDiscountCollectionCell()

@property (nonatomic , strong)UIImageView *goodsImageView;
@property (nonatomic , strong)UILabel *titleLabel;
@property (nonatomic , strong)UILabel *subtitleLabel;

@end

@implementation MTDiscountCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _goodsImageView = [[UIImageView alloc]init];
        _goodsImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_goodsImageView];
        
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_titleLabel];
        
        
        _subtitleLabel = [[UILabel alloc]init];
        _subtitleLabel.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:_subtitleLabel];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];

    WS(weakSelf);
    
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.contentView).with.offset(5);
        make.right.equalTo(weakSelf.contentView).with.offset(-5);
        make.width.equalTo(@(weakSelf.contentView.bounds.size.height - 10));
        make.height.equalTo(@(weakSelf.contentView.bounds.size.height - 10));
    }];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(weakSelf.contentView).with.offset(15);
        make.left.equalTo(weakSelf.contentView).with.offset(10);
        
    }];
    
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(weakSelf.titleLabel);
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).with.offset(5);
        
    }];
    
    
}

- (void)setDiscount:(NSDictionary *)discount{
    _discount = discount;
    
    NSString *imageUrl = [discount[@"imageurl"] stringByReplacingOccurrencesOfString:@"w.h" withString:@"120.0"];
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"bg_customReview_image_default"]];
    
    self.titleLabel.text = discount[@"maintitle"];
    self.subtitleLabel.text = discount[@"deputytitle"];
    
    self.subtitleLabel.textColor = [UIColor colorWithHexString:discount[@"deputy_typeface_color"]];
    
}

@end

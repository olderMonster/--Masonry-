//
//  MTMerchantCell.m
//  MeiTuan
//
//  Created by kehwa on 16/7/20.
//  Copyright © 2016年 kehwa. All rights reserved.
//

#import "MTMerchantCell.h"
#import "OMNetworkingConfiguration.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
@interface MTMerchantCell()

@property (nonatomic , strong)UIImageView *merchantImageView;       //商户图片
@property (nonatomic , strong)UILabel *merchantNameLabel;           //商户名称
@property (nonatomic , strong)UILabel *tuanTagLabel;                //团购标签
@property (nonatomic , strong)UILabel *waiTagLabel;                 //外卖标签
@property (nonatomic , strong)UILabel *jianTagLabel;                //减免标签
@property (nonatomic , strong)UILabel *commentCountLabel;           //评价数量
@property (nonatomic , strong)UILabel *consumptionPerLabel;         //人均消费
@property (nonatomic , strong)UILabel *categoryAndLocationLabel;    //店铺卖点以及地址
@property (nonatomic , strong)UILabel *distanceLabel;               //距离

@end

@implementation MTMerchantCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _merchantImageView = [[UIImageView alloc]init];
        _merchantImageView.layer.masksToBounds = YES;
        _merchantImageView.layer.cornerRadius = 2;
        [self.contentView addSubview:_merchantImageView];
        
        
        _merchantNameLabel = [[UILabel alloc]init];
        _merchantNameLabel.font = [UIFont systemFontOfSize:14];
        _merchantNameLabel.text = @"瑞康体检";
        [self.contentView addSubview:_merchantNameLabel];
        
        _tuanTagLabel = [[UILabel alloc]init];
        _tuanTagLabel.backgroundColor = RGB(96, 182, 175);
        _tuanTagLabel.font = [UIFont systemFontOfSize:11];
        _tuanTagLabel.text = @"团";
        _tuanTagLabel.textColor = [UIColor whiteColor];
        _tuanTagLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_tuanTagLabel];
        
        _waiTagLabel = [[UILabel alloc]init];
        _waiTagLabel.backgroundColor = [UIColor redColor    ];
        _waiTagLabel.font = [UIFont systemFontOfSize:11];
        _waiTagLabel.text = @"外";
        _waiTagLabel.textColor = [UIColor whiteColor];
        _waiTagLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_waiTagLabel];
        
        _jianTagLabel = [[UILabel alloc]init];
        _jianTagLabel.backgroundColor = RGB(245, 185, 98);
        _jianTagLabel.font = [UIFont systemFontOfSize:11];
        _jianTagLabel.text = @"￥";
        _jianTagLabel.textColor = [UIColor whiteColor];
        _jianTagLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_jianTagLabel];
        
        
        _commentCountLabel = [[UILabel alloc]init];
        _commentCountLabel.textColor = [UIColor grayColor];
        _commentCountLabel.font = [UIFont systemFontOfSize:12];
        _commentCountLabel.text = @"875评论";
        [self.contentView addSubview:_commentCountLabel];
        
        _consumptionPerLabel = [[UILabel alloc]init];
        _consumptionPerLabel.textColor = [UIColor grayColor];
        _consumptionPerLabel.font = [UIFont systemFontOfSize:12];
        _commentCountLabel.text = @"人均￥39";
        [self.contentView addSubview:_consumptionPerLabel];
        
        _categoryAndLocationLabel = [[UILabel alloc]init];
        _categoryAndLocationLabel.textColor = [UIColor grayColor];
        _categoryAndLocationLabel.font = [UIFont systemFontOfSize:12];
        _categoryAndLocationLabel.text = @"三明治 同乐坊";
        [self.contentView addSubview:_categoryAndLocationLabel];
        
        _distanceLabel = [[UILabel alloc]init];
        _distanceLabel.textColor = [UIColor grayColor];
        _distanceLabel.font = [UIFont systemFontOfSize:12];
        _distanceLabel.text = @"0.4km";
        [self.contentView addSubview:_distanceLabel];
        
        
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    WS(weakSelf);
    
    [self.merchantImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(weakSelf.contentView).with.offset(10);
        make.top.equalTo(weakSelf.contentView).with.offset(10);
        make.bottom.equalTo(weakSelf.contentView).with.offset(-10);
        make.width.equalTo(@100);
        
    }];
    
    
    [self.merchantNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(weakSelf.merchantImageView.mas_right).with.offset(10);
        make.top.equalTo(weakSelf.merchantImageView);
        
    }];
    
    [self.tuanTagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.merchantNameLabel.mas_right).with.offset(5);
        make.centerY.equalTo(weakSelf.merchantNameLabel);
        make.width.equalTo(@(weakSelf.merchantNameLabel.font.pointSize));
        make.height.equalTo(@(weakSelf.merchantNameLabel.font.pointSize));
        
//        make.right.lessThanOrEqualTo(weakSelf.waiTagLabel.mas_left);
    }];
    
    [self.waiTagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.tuanTagLabel.mas_right).with.offset(5);
        make.centerY.equalTo(weakSelf.merchantNameLabel);
        make.width.equalTo(@(weakSelf.merchantNameLabel.font.pointSize));
        make.height.equalTo(@(weakSelf.merchantNameLabel.font.pointSize));
        
//        make.right.lessThanOrEqualTo(weakSelf.jianTagLabel.mas_left);
    }];
    
    [self.jianTagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.waiTagLabel.mas_right).with.offset(5);
        make.centerY.equalTo(weakSelf.merchantNameLabel);
        make.width.equalTo(@(weakSelf.merchantNameLabel.font.pointSize));
        make.height.equalTo(@(weakSelf.merchantNameLabel.font.pointSize));
        
//        make.right.lessThanOrEqualTo(@(weakSelf.contentView.bounds.size.width - 5));
    }];
    
    
    [self.commentCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(weakSelf.merchantImageView.mas_right).with.offset(10);
        make.top.equalTo(weakSelf.merchantNameLabel.mas_bottom).with.offset(10);
        
    }];
    
    [self.consumptionPerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView).with.offset(-10);
        make.top.equalTo(weakSelf.commentCountLabel);
        
    }];
    
    
    [self.categoryAndLocationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(weakSelf.merchantNameLabel);
        make.bottom.equalTo(weakSelf.merchantImageView.mas_bottom);
        
    }];
    

    
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView).with.offset(-10);
        make.top.equalTo(weakSelf.categoryAndLocationLabel);
        
    }];
    
    
//    [self.merchantNameLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
//    [self.merchantNameLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
//    
//    [self.tuanTagLabel setContentHuggingPriority:UILayoutPriorityRequired
//                                     forAxis:UILayoutConstraintAxisHorizontal];
//    [self.tuanTagLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow
//                                                   forAxis:UILayoutConstraintAxisHorizontal];
//    
//    [self.waiTagLabel setContentHuggingPriority:UILayoutPriorityRequired
//                                    forAxis:UILayoutConstraintAxisHorizontal];
//    [self.waiTagLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow
//                                                  forAxis:UILayoutConstraintAxisHorizontal];
//    
//    [self.jianTagLabel setContentHuggingPriority:UILayoutPriorityRequired
//                                     forAxis:UILayoutConstraintAxisHorizontal];
//    [self.jianTagLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow
//                                                   forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)setMerchant:(NSDictionary *)merchant{
    _merchant = merchant;
    
    NSString *imgUrl = [merchant[@"frontImg"] stringByReplacingOccurrencesOfString:@"w.h" withString:@"160.0"];
    [self.merchantImageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"bg_customReview_image_default"]];
    
    self.merchantNameLabel.text = merchant[@"name"];
    
    self.commentCountLabel.text = [NSString stringWithFormat:@"%@评论",merchant[@"markNumbers"]];
    self.consumptionPerLabel.text = [NSString stringWithFormat:@"人均￥%@",merchant[@"avgPrice"]];
    self.categoryAndLocationLabel.text = [NSString stringWithFormat:@"%@ %@",merchant[@"cateName"],merchant[@"areaName"]];
    self.distanceLabel.text = @"<1km";
    
//    
//    BOOL hasGroup = [merchant[@"hasGroup"] boolValue];
//    BOOL isWaimai = [merchant[@"isWaimai"] boolValue];

//    
//    if (!hasGroup) {
//        [self.tuanTagLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.width.equalTo(@0);
//        }];
//    }
//    [self.waiTagLabel updateConstraints];
//
//    if (!isWaimai) {
//        [self.waiTagLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.width.equalTo(@0);
//        }];
//    }
//    [self.jianTagLabel updateConstraints];
    
}

@end

//
//  MTHotBuyCell.m
//  MeiTuan
//
//  Created by kehwa on 16/7/19.
//  Copyright © 2016年 kehwa. All rights reserved.
//

#import "MTHotBuyCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "OMNetworkingConfiguration.h"
@interface MTHotBuyCell()

@property (nonatomic , strong)UIImageView *titleImageView;

@end

@implementation MTHotBuyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _titleImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"todaySpecialHeaderTitleImage"]];
        [self.contentView addSubview:_titleImageView];
        
    }
    return self;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).with.offset(10);
        make.top.equalTo(self.contentView).with.offset(5);
        
    }];
    
}

- (void)setHotBuyTable:(NSArray *)hotBuyTable{
    _hotBuyTable = hotBuyTable;
    
    //200 x 120
    CGFloat w = ([UIScreen mainScreen].bounds.size.width - 20 *3) / 3;
    CGFloat h = 120 * w / 200;
    __block UIImageView *lastImageView = nil;
    __weak typeof(self) weakSelf = self;
    for (int index = 0; index <hotBuyTable.count; index++) {
        
        UIImageView *imageview = [[UIImageView alloc]init];
        [self.contentView addSubview:imageview];
        
        [imageview sd_setImageWithURL:[NSURL URLWithString:hotBuyTable[index][@"mdcLogoUrl"]] placeholderImage:[UIImage imageNamed:@"bg_customReview_image_default"]];
        
        [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.width.width.equalTo(@(w));
            make.top.equalTo(weakSelf.titleImageView.mas_bottom).with.offset(10);
            make.height.equalTo(@(h));
            if (lastImageView) {
                make.left.equalTo(lastImageView.mas_right).with.offset(20);
            }else{
                make.left.equalTo(weakSelf.contentView).with.offset(10);
            }
            lastImageView = imageview;
            
        }];
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = RGB(235, 235, 241);
        [self.contentView addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            if (index < hotBuyTable.count - 1) {
                make.top.equalTo(imageview);
                make.left.equalTo(imageview.mas_right).with.offset(10);
                make.width.equalTo(@1);
                make.height.equalTo(imageview).with.offset(20);
            }
        }];
        
        
        UILabel *currentPrice = [[UILabel alloc]init];
        currentPrice.backgroundColor = [UIColor whiteColor];
        currentPrice.textColor = RGB(245, 185, 98);
        currentPrice.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:currentPrice];
        
        currentPrice.text = [NSString stringWithFormat:@"%.2f",[hotBuyTable[index][@"campaignprice"] floatValue]];
        
        [currentPrice mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(imageview);
            make.top.equalTo(imageview.mas_bottom).with.offset(5);
            
        }];
        
        
        UILabel *oldPrice = [[UILabel alloc]init];
        oldPrice.backgroundColor = [UIColor whiteColor];
        oldPrice.textColor = [UIColor grayColor];
        oldPrice.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:oldPrice];
        
        NSString *oldPriceStr = [NSString stringWithFormat:@"%.2f",[hotBuyTable[index][@"campaignprice"] floatValue]];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:oldPriceStr attributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]}];
        oldPrice.attributedText = str;
        
        [oldPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(currentPrice.mas_right).with.offset(5);
            make.centerY.equalTo(currentPrice.mas_centerY);
            
        }];
        
        
    }
    
}


@end

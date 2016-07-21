//
//  TabbarItem.m
//  新浪微博
//
//  Created by cong on 14-9-10.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "OMTabbarItem.h"
#define kTitleRatio 0.3

@interface OMTabbarItem()

//@property (nonatomic, strong) UIImageView *redTips;
//@property (nonatomic, strong) UILabel *tipLabel;

@end

@implementation OMTabbarItem


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //[self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        
//        _redTips = [[UIImageView alloc] initWithFrame:CGRectZero];
//        _redTips.backgroundColor = [UIColor clearColor];
//        _redTips.hidden = YES;
//        [_redTips setImage:[UIImage imageNamed:@"red_bg"]];
//        [self addSubview:_redTips];
        
//        _tipLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        _tipLabel.backgroundColor = [UIColor clearColor];
//        _tipLabel.textColor = [UIColor whiteColor];
//        _tipLabel.font = [UIFont systemFontOfSize:14];
//        _tipLabel.textAlignment = 1;
//        [_redTips addSubview:_tipLabel];
        
        
        //设置button的文本居中
        self.titleLabel.textAlignment = 1;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        //设置button图片的显示
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
//        [self setBackgroundImage:[UIImage imageNamed:@"tabbar_slider.png"] forState:UIControlStateSelected];
    }
    return self;
}

//覆盖父类在highlight时的操作
-(void)setHighlighted:(BOOL)highlighted
{
    
}

//调整button内部文字的位置
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleheight = contentRect.size.height * kTitleRatio;
    CGFloat titleY = contentRect.size.height - titleheight - 3;
    CGFloat titlewidth = contentRect.size.width;
    return CGRectMake(titleX,titleY,titlewidth,titleheight);
}

//调整button内部图片的位置
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = 0;
    CGFloat imageheight = contentRect.size.height *(1- kTitleRatio - 0.1) - 5;
    CGFloat imageY = 5;
    CGFloat imagewidth = contentRect.size.width;
    return CGRectMake(imageX,imageY,imagewidth,imageheight);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    _redTips.frame = CGRectMake(self.frame.size.width - 26, 4, 20, 20);
//    _tipLabel.frame = CGRectMake(0, 0, 20, 20);
//    _redTips.frame = CGRectMake(self.frame.size.width - 26, 4, 7, 7);
}

//- (void)isShowRedTips:(BOOL)isShow withNum:(NSString *)num
//{
//    if (isShow) {
//        _redTips.hidden = NO;
//        _tipLabel.text = num;
//    }
//    else {
//        _redTips.hidden = YES;
//        _tipLabel.text = num;
//    }
//}


@end

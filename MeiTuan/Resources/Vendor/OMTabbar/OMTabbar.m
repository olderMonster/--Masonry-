//
//  Tabbar.m
//  新浪微博
//
//  Created by cong on 14-9-10.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "OMTabbar.h"

@implementation OMTabbar
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbarBackground.png"]];
    }
    return self;
}


//添加选项卡
-(void)addItemwithIcon:(NSString *)icon selectedIcon:(NSString *)selectedIcon title:(NSString *)title
{
    //创建Item
    OMTabbarItem *item = [[OMTabbarItem alloc]init];
    //设置按钮的文本
    [item setTitle:title forState:UIControlStateNormal];
    //设置按钮普通状态下文本颜色
    [item setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //设置按钮高亮状态下文本颜色
    [item setTitleColor:[UIColor colorWithRed:96.0/255.0 green:182.0/255.0 blue:175.0/255.0 alpha:1.0] forState:UIControlStateSelected];
    //设置按钮图片
    [item setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    //调整按钮在高亮状态下不适应变化（不变形）
    item.adjustsImageWhenHighlighted = NO;
    //设置高亮状态下按钮的图片
    [item setImage:[UIImage imageNamed:selectedIcon] forState:UIControlStateSelected];
    //添加按钮点击事件
    [item addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchDown];
    //字体大小
    item.titleLabel.font = [UIFont systemFontOfSize:10];
    //先添加Item
    [self addSubview:item];
    
    //然后调整Item的frame
    NSInteger count = self.subviews.count;
    if (count == 1) {
        [self itemAction:item];
    }
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width / count;
    for (int i= 0; i<count; i++) {
        OMTabbarItem *tabbarItem = [self.subviews objectAtIndex:i];
        tabbarItem.frame = CGRectMake(width * i, 0, width, height);
        tabbarItem.tag = i;

        
    }
}

-(void)itemAction:(OMTabbarItem *)item
{
    if ([delegate respondsToSelector:@selector(tabbar:itemSelectedFrom:to:)]) {
        [delegate tabbar:self itemSelectedFrom:(int)_tabbarItem.tag to:(int)item.tag];
        
    }
    
    for (OMTabbarItem *item in self.subviews) {
        item.selected = NO;
    }
    if (_tabbarItem.tag == item.tag && _tabbarItem.tag == 1) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"click the current page and refresh the data" object:nil];
    }
    
    //取消当前选中item
    _tabbarItem.selected = NO;
    //选中点击的item
    item.selected = YES;
    //记录选中的item    
    _tabbarItem = item;
}


- (void)isShowRedTips:(BOOL)isShow withBtnIndex:(NSInteger)index withNum:(NSInteger)num
{
    OMTabbarItem *tabbarItem = [self.subviews objectAtIndex:index];
    
    NSString *numStr = [NSString stringWithFormat:@"%ld", (long)num];
    
    if (num > 99) {
        numStr = @"99";
    }
    
    [tabbarItem isShowRedTips:isShow withNum:numStr];
}


@end

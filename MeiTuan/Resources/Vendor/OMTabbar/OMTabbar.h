//
//  Tabbar.h
//  新浪微博
//
//  Created by cong on 14-9-10.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OMTabbarItem.h"

@class OMTabbar;
@protocol OMTabbarDelegate <NSObject>

-(void)tabbar:(OMTabbar *)tabbar itemSelectedFrom:(int)from to:(int)to;

@end

 
@interface OMTabbar : UIView
{
    OMTabbarItem *_tabbarItem;
}
@property(nonatomic,weak)id<OMTabbarDelegate> delegate;

-(void)addItemwithIcon:(NSString *)icon selectedIcon:(NSString *)selectedIcon title:(NSString *)title;

-(void)itemAction:(OMTabbarItem *)item;

@end

//
//  MTDropdownListView.h
//  MeiTuan
//
//  Created by kehwa on 16/7/20.
//  Copyright © 2016年 kehwa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , MTDropdownListViewType) {
    MTDropdownListViewTypeDoubleList,  //双列表
    MTDropdownListViewTypeOnlyList     //单列表
};

typedef NS_ENUM(NSInteger , MTDropdownListViewRightTableViewType) {
    MTDropdownListViewRightTableViewTypeNormal,  //双列表
    MTDropdownListViewRightTableViewTypeShow     //单列表
};

@interface MTDropdownListView : UIView

@property (nonatomic , strong)NSArray *categoryTable;
@property (nonatomic , strong)NSArray *zoneTable;
@property (nonatomic , strong)NSArray *sortTable;

@end

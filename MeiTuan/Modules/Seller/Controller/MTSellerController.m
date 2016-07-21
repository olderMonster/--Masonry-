//
//  MTSellerController.m
//  MeiTuan
//
//  Created by kehwa on 16/7/19.
//  Copyright © 2016年 kehwa. All rights reserved.
//

#import "MTSellerController.h"
#import "OMNetworkingConfiguration.h"
#import <Masonry/Masonry.h>

#import "OMSegmentedControl.h"

#import "MTMerchantCell.h"
#import "MTAllSellerManager.h"
#import "MTCategoryManager.h"

#import "MTDropdownListView.h"

#import "MTSellerDetailController.h"

@interface MTSellerController ()<UITableViewDataSource , UITableViewDelegate , OMApiManagerParamsSourceDelegate , OMApiManagerCallBackDelegate>

@property (nonatomic , strong)OMSegmentedControl *segmentControl;

@property (nonatomic , strong)MTDropdownListView *dropListView;
@property (nonatomic , strong)UITableView *merchantTableView;

@property (nonatomic , strong)MTAllSellerManager *allSellerManager;
@property (nonatomic , strong)NSMutableArray *allSellerTable;

@property (nonatomic , strong)MTCategoryManager *categoryManager;
@property (nonatomic , strong)NSArray *categoryTable;

@property (nonatomic , strong)NSArray *zoneTable;
@property (nonatomic , strong)NSArray *sortTable;

@end

@implementation MTSellerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"商家";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.dropListView];
    [self.view addSubview:self.merchantTableView];
    
    [self.allSellerManager loadData];
    [self.categoryManager loadData];
    
    [self addTitleView];
    
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.dropListView.frame = CGRectMake(0, 64, kScreenWidth, 25);
    self.merchantTableView.frame = CGRectMake(0, CGRectGetMaxY(self.dropListView.frame), kScreenWidth, self.view.frame.size.height - CGRectGetMaxY(self.dropListView.frame));
    
}

#pragma mark - private method
- (void)addTitleView{
    self.segmentControl.frame = CGRectMake(0, 0, 160, 30);
    self.navigationItem.titleView = self.segmentControl;
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allSellerTable.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    MTMerchantCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[MTMerchantCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.merchant = self.allSellerTable[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    headerView.backgroundColor = RGB(219, 219, 221);
    
    UILabel *currentLocationLabel = [[UILabel alloc]init];
    currentLocationLabel.textColor = [UIColor grayColor];
    currentLocationLabel.text = @"当前：静安区静安体育中心";
    currentLocationLabel.font = [UIFont systemFontOfSize:10];
    [headerView addSubview:currentLocationLabel];
    
    [currentLocationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(@10);
        make.top.equalTo(@0);
        make.height.equalTo(@(headerView.bounds.size.height));
        
    }];
    
    
    UIButton *refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [refreshButton setBackgroundImage:[UIImage imageNamed:@"icon_dellist_locate_refresh"] forState:UIControlStateNormal];
    [headerView addSubview:refreshButton];
    
    [refreshButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-10));
        make.centerY.equalTo(currentLocationLabel);
        make.width.equalTo(@(headerView.bounds.size.height - 15));
        make.height.equalTo(@(headerView.bounds.size.height - 15));
    }];
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MTSellerDetailController *detailVC = [[MTSellerDetailController alloc]init];
    detailVC.merchantId = self.allSellerTable[indexPath.row][@"poiid"];
    [self.navigationController pushViewController:detailVC animated:YES];
    
}


#pragma mark - OMApiManagerParamsSourceDelegate
- (NSDictionary *)paramsForApi:(OMBaseApiManager *)manager{
    return nil;
}

#pragma mark - OMApiManagerCallBackDelegate

- (void)managerCallApiDidSuccess:(OMBaseApiManager *)manager{
    NSDictionary *dict = [manager fetchDataWithReformer:nil];
    if (manager == self.allSellerManager) {
        self.allSellerTable = [NSMutableArray arrayWithArray:dict[@"data"]];
        [self.merchantTableView reloadData];
    }
    
    if (manager == self.categoryManager) {
        self.categoryTable = dict[@"data"];
        self.dropListView.categoryTable = self.categoryTable;
        self.dropListView.zoneTable = self.zoneTable;
        self.dropListView.sortTable = self.sortTable;
    }
}
- (void)managerCallApiDidFailure:(OMBaseApiManager *)manager{
    
}

#pragma mark - getters and setters

- (OMSegmentedControl *)segmentControl{
    if (_segmentControl == nil) {
        _segmentControl = [[OMSegmentedControl alloc]initWithItems:@[@"全部商家",@"优惠商家"]];
        _segmentControl.segmentMode = OMSegmentedControlModeNormal;
        _segmentControl.selectedBackgroundColor = RGB(96, 182, 175);
        _segmentControl.normalBackgroundColor = [UIColor whiteColor];
        _segmentControl.selectedTextColor = [UIColor whiteColor];
        _segmentControl.normalTextColor = RGB(96, 182, 175);
        _segmentControl.borderColor = RGB(96, 182, 175);
        _segmentControl.borderWidth = 1.0f;
        _segmentControl.borderRadius = 2.0f;
    }
    return _segmentControl;
}

- (MTDropdownListView *)dropListView{
    if (_dropListView == nil) {
        _dropListView = [[MTDropdownListView alloc]init];
    }
    return _dropListView;
}

- (UITableView *)merchantTableView{
    if (_merchantTableView == nil) {
        _merchantTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _merchantTableView.backgroundColor = [UIColor whiteColor];
        _merchantTableView.dataSource = self;
        _merchantTableView.delegate = self;
        _merchantTableView.tableFooterView = [[UIView alloc]init];
        _merchantTableView.rowHeight = 90;
    }
    return _merchantTableView;
}

- (MTAllSellerManager *)allSellerManager{
    if (_allSellerManager == nil) {
        _allSellerManager = [[MTAllSellerManager alloc]init];
        _allSellerManager.sourceDelegate = self;
        _allSellerManager.callBackDelegate = self;
    }
    return _allSellerManager;
}
- (NSMutableArray *)allSellerTable{
    if (_allSellerTable == nil) {
        _allSellerTable = [NSMutableArray array];
    }
    return _allSellerTable;
}

- (MTCategoryManager *)categoryManager{
    if (_categoryManager == nil) {
        _categoryManager = [[MTCategoryManager alloc]init];
        _categoryManager.sourceDelegate = self;
        _categoryManager.callBackDelegate = self;
    }
    return _categoryManager;
}

- (NSArray *)categoryTable{
    if (_categoryTable == nil) {
        _categoryTable = [NSArray array];
    }
    return _categoryTable;
}

- (NSArray *)zoneTable{
    if (_zoneTable == nil) {
        _zoneTable = @[@{@"name":@"杨浦区"},@{@"name":@"闵行区"},@{@"name":@"宝山区"},@{@"name":@"奉贤区"},@{@"name":@"金山区"},@{@"name":@"崇明县"},@{@"name":@"松江区"},@{@"name":@"嘉定区"},@{@"name":@"青浦区"},@{@"name":@"全部商圈"}];
    }
    return _zoneTable;
}

- (NSArray *)sortTable{
    if (_sortTable == nil) {
        _sortTable = @[@{@"name":@"智能排序"},@{@"name":@"好评优先"},@{@"name":@"离我最近"},@{@"name":@"优惠价最低"}];
    }
    return _sortTable;
}


@end

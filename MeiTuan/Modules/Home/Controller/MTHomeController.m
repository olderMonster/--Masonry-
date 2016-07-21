//
//  MTHomeController.m
//  MeiTuan
//
//  Created by kehwa on 16/7/19.
//  Copyright © 2016年 kehwa. All rights reserved.
//

#import "MTHomeController.h"

#import "MTChannelCell.h"
#import "MTHotBuyCell.h"
#import "MTDiscountCell.h"
#import "MTRecommendCell.h"

#import "MTDiscountManager.h"
#import "MTRecommendManager.h"
#import "MTHotBuyManager.h"

NSString *const kChannelCell = @"kChannelCell";
NSString *const kHotbuyCell = @"kHotbuyCell";
NSString *const kDiscountCell = @"kDiscountCell";
NSString *const kRecommendCell = @"kRecommendCell";


@interface MTHomeController ()<UITableViewDataSource,UITableViewDelegate , OMApiManagerParamsSourceDelegate , OMApiManagerCallBackDelegate>

@property (nonatomic , strong)UITableView *homeTableView;

@property (nonatomic , strong)MTDiscountManager *discountManager;  //折扣
@property (nonatomic , strong)MTRecommendManager *recommendManager;  //推荐
@property (nonatomic , strong)MTHotBuyManager *buyManager;

@property (nonatomic , strong)NSArray *channelTable;
@property (nonatomic , strong)NSArray *hotBuyTable;
@property (nonatomic , strong)NSArray *discountTable;
@property (nonatomic , strong)NSMutableArray *recommendTable;


@end

@implementation MTHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.homeTableView];
    
    [self.discountManager loadData];
    [self.recommendManager loadData];
    [self.buyManager loadData];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.homeTableView.frame = self.view.bounds;
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section != 4) {
        return 1;
    }else{
        return self.recommendTable.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        MTChannelCell *cell = [tableView dequeueReusableCellWithIdentifier:kChannelCell];
        if (!cell) {
            cell = [[MTChannelCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kChannelCell];
        }
        cell.channelTable = self.channelTable;
        return cell;
    }
    if (indexPath.section == 1) {
        MTHotBuyCell *cell = [tableView dequeueReusableCellWithIdentifier:kHotbuyCell];
        if (!cell) {
            cell = [[MTHotBuyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kHotbuyCell];
        }
        cell.hotBuyTable = self.hotBuyTable;
        return cell;
    }
    if (indexPath.section == 2) {
        MTDiscountCell *cell = [tableView dequeueReusableCellWithIdentifier:kDiscountCell];
        if (!cell) {
            cell = [[MTDiscountCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kDiscountCell];
        }
        cell.discountTable = self.discountTable;
        return cell;
    }
    if (indexPath.section == 4) {
        MTRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:kRecommendCell];
        if (!cell) {
            cell = [[MTRecommendCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kRecommendCell];
        }
        cell.recommend = self.recommendTable[indexPath.row];
        return cell;
    }
    
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        //5列2行
        return kChannelCellHeight * 2 + 20;
    }
    if (indexPath.section == 1) {
        return 120;
    }
    if (indexPath.section == 2) {
        return (self.discountTable.count + 1)/2 * kDiscountCellHeight;
    }
    if (indexPath.section == 4) {
        return 80;
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

#pragma mark - OMApiManagerParamsSourceDelegate
- (NSDictionary *)paramsForApi:(OMBaseApiManager *)manager{
    return nil;
}

#pragma mark - OMApiManagerCallBackDelegate
- (void)managerCallApiDidSuccess:(OMBaseApiManager *)manager{
    NSDictionary *dict = [manager fetchDataWithReformer:nil];
    if (manager == self.buyManager) {
        self.hotBuyTable = dict[@"data"][@"deals"];
        [self.homeTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];

    }
    if (manager == self.discountManager) {
        self.discountTable = dict[@"data"];
        [self.homeTableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];
    }
    if (manager == self.recommendManager) {
        self.recommendTable = dict[@"data"];
        [self.homeTableView reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationFade];
    }

}
- (void)managerCallApiDidFailure:(OMBaseApiManager *)manager{
    
}


#pragma mark - getters and setters
- (UITableView *)homeTableView{
    if (_homeTableView == nil) {
        _homeTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _homeTableView.backgroundColor = RGB(235, 235, 241);
        _homeTableView.dataSource = self;
        _homeTableView.delegate = self;
        _homeTableView.tableFooterView = [[UIView alloc]init];
        _homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _homeTableView;
}

- (MTDiscountManager *)discountManager{
    if (_discountManager == nil) {
        _discountManager = [[MTDiscountManager alloc]init];
        _discountManager.sourceDelegate = self;
        _discountManager.callBackDelegate = self;
    }
    return _discountManager;
}

- (NSArray *)discountTable{
    if (_discountTable == nil) {
        _discountTable = [[NSArray alloc]init];
    }
    return _discountTable;
}

- (MTRecommendManager *)recommendManager{
    if (_recommendManager == nil) {
        _recommendManager = [[MTRecommendManager alloc]init];
        _recommendManager.sourceDelegate = self;
        _recommendManager.callBackDelegate = self;
    }
    return _recommendManager;
}

- (NSMutableArray *)recommendTable{
    if (_recommendTable == nil) {
        _recommendTable = [NSMutableArray array];
    }
    return _recommendTable;
}


- (MTHotBuyManager *)buyManager{
    if (_buyManager == nil) {
        _buyManager = [[MTHotBuyManager alloc]init];
        _buyManager.sourceDelegate = self;
        _buyManager.callBackDelegate = self;
    }
    return _buyManager;
}


- (NSArray *)channelTable{
    if (_channelTable == nil) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"menuData" ofType:@"plist"];
        _channelTable = [[NSArray alloc]initWithContentsOfFile:plistPath];
    }
    return _channelTable;
}

- (NSArray *)hotBuyTable{
    if (_hotBuyTable == nil) {
        _hotBuyTable = [[NSArray alloc]init];
    }
    return _hotBuyTable;
}

@end

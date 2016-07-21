//
//  MtSellerDetailController.m
//  MeiTuan
//
//  Created by kehwa on 16/7/21.
//  Copyright © 2016年 kehwa. All rights reserved.
//

#import "MTSellerDetailController.h"
#import "MTSellerDetailManager.h"
@interface MTSellerDetailController ()<OMApiManagerParamsSourceDelegate,OMApiManagerCallBackDelegate>

@property (nonatomic , strong)MTSellerDetailManager *detailManager;

@end

@implementation MTSellerDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"商家详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.detailManager loadData];
    
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
}

#pragma mark - OMApiManagerParamsSourceDelegate
- (NSDictionary *)paramsForApi:(OMBaseApiManager *)manager{
    return nil;
}

#pragma mark - OMApiManagerCallBackDelegate
- (void)managerCallApiDidSuccess:(OMBaseApiManager *)manager{
    NSDictionary *dict = [manager fetchDataWithReformer:nil];
    NSLog(@"dict ====>> %@",dict);
}
- (void)managerCallApiDidFailure:(OMBaseApiManager *)manager{
    NSLog(@"errorType====>> %lu",(unsigned long)manager.errorType);
}


#pragma mark - getters and setters
- (MTSellerDetailManager *)detailManager{
    if (_detailManager == nil) {
        _detailManager = [[MTSellerDetailManager alloc]init];
        _detailManager.sourceDelegate = self;
        _detailManager.callBackDelegate = self;
    }
    return _detailManager;
}


@end

//
//  MTSellerDetailManager.m
//  MeiTuan
//
//  Created by kehwa on 16/7/21.
//  Copyright © 2016年 kehwa. All rights reserved.
//

#import "MTSellerDetailManager.h"

@implementation MTSellerDetailManager

- (instancetype)init{
    self = [super init];
    if (self) {
        self.validator = self;
    }
    return self;
}

- (NSString *)methodName{
    return @"group/v1/poi/6679235";
}

- (OMAPIManagerRequestType)requestType{
    return OMAPIManagerRequestTypeGet;
}

- (NSString *)serviceType{
    return kMTService;
}

- (NSDictionary *)reformParams:(NSDictionary *)params{
    NSMutableDictionary *apiParams = [NSMutableDictionary dictionaryWithDictionary:params];
    
    apiParams[@"__skck"] = @"40aaaf01c2fc4801b9c059efcd7aa146";
    apiParams[@"__skcy"] = @"8s5pIPqAHXfwBBOWjWssJ6yhpP4%3D";
    apiParams[@"__skno"] = @"3A22D2FC-4CE5-461F-8022-49617F529895";
    apiParams[@"__skts"] = @"1437114388.938075";
    apiParams[@"__skua"] = @"bd6b6e8eadfad15571a15c3b9ef9199a";
    apiParams[@"__vhost"] = @"api.mobile.meituan.com";
    apiParams[@"ci"] = @"1";
    apiParams[@"client"] = @"iphone";
    apiParams[@"movieBundleVersion"] = @"100";
    apiParams[@"msid"] = @"48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-17-14-20300";
    apiParams[@"userid"] = @"10086";
    apiParams[@"utm_campaign"] = @"AgroupBgroupE72175652459578368_c0_eb21e98ced02c66e9539669c2efedfec0D100Fa20141120nanning__m1__leftflow___ab_pindaochangsha__a__leftflow___ab_gxtest__gd__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_i550poi_ktv__d__j___ab_chunceshishuju__a__a___ab_gxh_82__nostrategy__leftflow___ab_i_group_5_3_poidetaildeallist__a__b___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi0202__b__a___ab_pindaoquxincelue0630__b__b1___ab_i550poi_xxyl__b__leftflow___ab_i_group_5_6_searchkuang__a__leftflow___i_group_5_2_deallist_poitype__d__d___ab_pindaoshenyang__a__leftflow___ab_b_food_57_purepoilist_extinfo__a__a___ab_waimaiwending__b__a___ab_waimaizhanshi__b__b1___ab_i550poi_lr__d__leftflow___ab_i_group_5_5_onsite__b__b___ab_xinkeceshi__b__leftflowGmerchant";
    apiParams[@"utm_content"] = @"4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D";
    apiParams[@"utm_medium"] = @"iphone";
    apiParams[@"utm_source"] = @"AppStore";
    apiParams[@"utm_term"] = @"5.7";
    apiParams[@"uuid"] = @"4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D";
    apiParams[@"version_name"] = @"5.7";
    return apiParams;
}

#pragma mark - OMApiManagerValidator
- (BOOL)manager:(OMBaseApiManager *)manager isCorrectWithParamsData:(NSDictionary *)params{
    return YES;
}
- (BOOL)manager:(OMBaseApiManager *)manager isCorrectWithCallBackData:(NSDictionary *)responseData{
    return YES;
}


@end

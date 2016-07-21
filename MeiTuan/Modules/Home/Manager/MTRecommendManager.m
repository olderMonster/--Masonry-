//
//  MTRecommendManager.m
//  MeiTuan
//
//  Created by kehwa on 16/7/19.
//  Copyright © 2016年 kehwa. All rights reserved.
//

#import "MTRecommendManager.h"

@implementation MTRecommendManager

- (instancetype)init{
    self = [super init];
    if (self) {
        self.validator = self;
    }
    return self;
}

- (NSString *)methodName{
    return @"group/v1/recommend/homepage/city/1";
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
        apiParams[@"__skcy"] = @"mrUZYo7999nH8WgTicdfzaGjaSQ=";
        apiParams[@"__skno"] = @"51156DC4-B59A-4108-8812-AD05BF227A47";
        apiParams[@"__skts"] = @"1434530933.303717";
        apiParams[@"__skua"] = @"bd6b6e8eadfad15571a15c3b9ef9199a";
        apiParams[@"__vhost"] = @"api.mobile.meituan.com";
        apiParams[@"ci"] = @"1";
        apiParams[@"client"] = @"iphone";
        apiParams[@"limit"] = @"40";
        apiParams[@"movieBundleVersion"] = @"100";
        apiParams[@"msid"] = @"48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-06-17-14-50363";
        apiParams[@"offset"] = @"0";
        apiParams[@"position"] = @"39.983497,116.318042";
        apiParams[@"userId"] = @"10086";
        apiParams[@"userid"] = @"10086";
        apiParams[@"utm_campaign"] = @"AgroupBgroupD100Fab_chunceshishuju__a__a___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_gxhceshi0202__b__a___ab_pindaochangsha__a__leftflow___ab_xinkeceshi__b__leftflow___ab_gxtest__gd__leftflow___ab_gxh_82__nostrategy__leftflow___ab_pindaoshenyang__a__leftflow___i_group_5_2_deallist_poitype__d__d___ab_b_food_57_purepoilist_extinfo__a__a___ab_trip_yidizhoubianyou__b__leftflow___ab_i_group_5_3_poidetaildeallist__a__b___ab_waimaizhanshi__b__b1___a20141120nanning__m1__leftflow___ab_pind";
    
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

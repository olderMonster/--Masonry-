//
//  MTService.m
//  MeiTuan
//
//  Created by kehwa on 16/7/19.
//  Copyright © 2016年 kehwa. All rights reserved.
//

#import "MTService.h"

@implementation MTService
//是否线上
- (BOOL)isOnline{
    return YES;
}

//线上的baseurl
- (NSString *)onlineApiBaseUrl{
    return @"http://api.meituan.com/";
}

//线上的版本
- (NSString *)onlineApiVersion{
    return @"";
}

- (NSString *)onlinePrivateKey{
    return @"";
}

- (NSString *)onlinePublicKey{
    return @"";
}


- (NSString *)offlineApiBaseUrl{
    return self.onlineApiBaseUrl;
}

- (NSString *)offlineApiVersion{
    return self.onlineApiVersion;
}

- (NSString *)offlinePrivateKey{
    return self.onlinePrivateKey;
}

- (NSString *)offlinePublicKey{
    return self.onlinePublicKey;
}
@end

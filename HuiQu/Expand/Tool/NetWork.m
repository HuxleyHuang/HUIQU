//
//  NetWork.m
//  HuiQu
//
//  Created by Huxley on 16/11/2.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "NetWork.h"

@implementation NetWork


+(NetWork *)shareInstance{
    static id networkInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkInstance = [[self alloc] init];
        
    });
    
    return networkInstance;
}

-(NSString *)networkStatus{
    if (!_networkStatus) {
        _networkStatus = @"未知网络";
    }
    
    return _networkStatus;
}


-(void)changeNetworkStatus:(NSString *)status{
    self.networkStatus = status;
}




@end

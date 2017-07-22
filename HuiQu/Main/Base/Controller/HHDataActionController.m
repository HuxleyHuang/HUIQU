//
//  HHDataActionController.m
//  HuiQu
//
//  Created by Huxley on 16/11/3.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "HHDataActionController.h"

@implementation HHDataActionController

- (BOOL)isConnected {
    struct sockaddr zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sa_len = sizeof(zeroAddress);
    zeroAddress.sa_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability =
    SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags =
    SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags) {
        printf("Error. Count not recover network reachability flags\n");
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

//-(void)Reachability {
//    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
//    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        NSLog(@"%@",[NSThread currentThread]);
//        switch (status) {
//            case AFNetworkReachabilityStatusNotReachable:
//            {
//                NSLog(@"无网络");
//                self.isNotReachable = NO;
//            }
//                break;
//            case AFNetworkReachabilityStatusReachableViaWWAN:
//            {
//                NSLog(@"有网络");
//                //isuse = @"有网络";
//                 self.isNotReachable = YES;
//            }
//                break;
//            case AFNetworkReachabilityStatusReachableViaWiFi:
//            {
//                NSLog(@"有网络wifi");
//                 self.isNotReachable = YES;
//            }
//                break;
//            default:
//                break;
//        }
//    }];
//}



+ (AFHTTPSessionManager *)requestAFWithURL:(NSString *)url
                                    params:(NSDictionary *)params
                                httpMethod:(NSString *)httpMethod
                               finishBlock:(FinishBlock)finishBlock
                                errorBlock:(ErrorBlock)errorBlock
{
    
    MBProgressHUD *hud =  [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.labelText = @"请求中";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    RequestType1 type;
    if ([httpMethod isEqualToString:@"GET"])
    {
        type = RequestGetType1;
    }else{
        type = RequestPostType1;
        
    }
    switch (type) {
        case RequestGetType1:
        {
            
            [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                NSLog(@"请求进度：%lld/%lld,",downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
                if (finishBlock != nil) {
                    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                    finishBlock(result);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"Error: %@", [error localizedDescription]);
                hud.labelText = @"请求失败";
                [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
                
                if (errorBlock != nil) {
                    
                    errorBlock(error);
                }
            }];
            
            
        }
            break;
        case RequestPostType1:
        {
            [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                NSLog(@"上传进度：%lld/%lld,",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
                if (finishBlock != nil) {
                    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                    finishBlock(result);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (errorBlock != nil) {
                    
                    errorBlock(error);
                }
            }];
            
        }
            break;
        default:
            break;
    }
   
    return manager;
    
    
}

+ (AFHTTPSessionManager *)postMP3:(NSString *)url
                           params:(NSDictionary *)params
                         fileData:(NSData *)fileData
                      finishBlock:(FinishBlock)finishBlock
                       errorBlock:(ErrorBlock)errorBlock
{
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:fileData name:@"recoder" fileName:@"recoder.mp3" mimeType:@"mp3"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"上传进度：%lld/%lld,",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
        if (finishBlock != nil) {
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            finishBlock(result);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
        if (errorBlock != nil) {
            
            errorBlock(error);
        }
    }];
    
    return manager;
    
    
    
}


+ (AFHTTPSessionManager *)syncrequestAFWithURL:(NSString *)url
                                        params:(NSDictionary *)params
                                    httpMethod:(NSString *)httpMethod
                                   finishBlock:(FinishBlock)finishBlock
                                    errorBlock:(ErrorBlock)errorBlock
{
    
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    RequestType1 type;
    if ([httpMethod isEqualToString:@"GET"])
    {
        type = RequestGetType1;
    }else{
        type = RequestPostType1;
        
    }
    switch (type) {
        case RequestGetType1:
        {
            [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                NSLog(@"下载进度：%lld/%lld,",downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
                if (finishBlock != nil) {
                    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                    finishBlock(result);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"Error: %@", [error localizedDescription]);
                
                [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
                if (errorBlock != nil) {
                    
                    errorBlock(error);
                }
            }];
            
            
            
            
        }
            break;
        case RequestPostType1:
        {
            [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                 NSLog(@"上传进度：%lld/%lld,",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
                if (finishBlock != nil) {
                    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                    finishBlock(result);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
                if (errorBlock != nil) {
                    
                    errorBlock(error);
                }
            }];
            
            
        }
            break;
        default:
            break;
    }
    
    
    return manager;
    
    
}

+ (AFHTTPSessionManager *)requestAFNoCoverWithURL:(NSString *)url
                                           params:(NSDictionary *)params
                                       httpMethod:(NSString *)httpMethod
                                      finishBlock:(FinishBlock)finishBlock
                                       errorBlock:(ErrorBlock)errorBlock{

    //MBProgressHUD *hud =  [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    //hud.labelText = @"请求中";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    RequestType1 type;
    if ([httpMethod isEqualToString:@"GET"])
    {
        type = RequestGetType1;
    }else{
        type = RequestPostType1;
        
    }
    switch (type) {
        case RequestGetType1:
        {
            
            [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                NSLog(@"请求进度：%lld/%lld,",downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                //[MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
                if (finishBlock != nil) {
                    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                    finishBlock(result);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"Error: %@", [error localizedDescription]);
                //hud.labelText = @"请求失败";
               // [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
                
                if (errorBlock != nil) {
                    
                    errorBlock(error);
                }
            }];
            
            
        }
        break;
        case RequestPostType1:
        {
            [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                NSLog(@"上传进度：%lld/%lld,",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                //[MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
                if (finishBlock != nil) {
                    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                    finishBlock(result);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (errorBlock != nil) {
                    
                    errorBlock(error);
                }
            }];
            
        }
        break;
        default:
        break;
    }
    
    return manager;
}





@end

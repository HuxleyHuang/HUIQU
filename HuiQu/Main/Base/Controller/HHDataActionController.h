//
//  HHDataActionController.h
//  HuiQu
//
//  Created by Huxley on 16/11/3.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>
typedef void(^FinishBlock) (id result);
typedef void(^ErrorBlock) (NSError *error);
typedef NS_ENUM(NSInteger, RequestType1) {
    RequestPostType1,
    RequestGetType1
};
@interface HHDataActionController : NSObject
@property (nonatomic, assign, getter=isConnected) BOOL connected;/**<网络是否连接*/
@property (nonatomic,assign)BOOL isNotReachable;

/**
 *  请求通过回调
 *
 *  @param url          上传文件的 url 地址
 *  @param params   参数字典
 *  @param httpMethod   请求类型
 *  @param finishBlock  成功
 *  @param errorBlock   失败
 *
 */
+ (AFHTTPSessionManager *)requestAFWithURL:(NSString *)url
                                    params:(NSDictionary *)params
                                httpMethod:(NSString *)httpMethod
                               finishBlock:(FinishBlock)finishBlock
                                errorBlock:(ErrorBlock)errorBlock;



+ (AFHTTPSessionManager *)requestAFNoCoverWithURL:(NSString *)url
                                    params:(NSDictionary *)params
                                httpMethod:(NSString *)httpMethod
                               finishBlock:(FinishBlock)finishBlock
                                errorBlock:(ErrorBlock)errorBlock;


+ (AFHTTPSessionManager *)postMP3:(NSString *)url
                           params:(NSDictionary *)params
                         fileData:(NSData *)fileData
                      finishBlock:(FinishBlock)finishBlock
                       errorBlock:(ErrorBlock)errorBlock;



@end

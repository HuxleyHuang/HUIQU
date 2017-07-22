//
//  OperationQueue.h
//  HuiQu
//
//  Created by Huxley on 17/3/7.
//  Copyright © 2017年 Huxley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/** 处理事务队列 */
@interface OperationQueue : NSObject

/**图片 */
@property(strong, nonatomic) UIImage *image;


/** 异步下载网络图片 */
+(UIImage *)getAsyncDownloadImage:(NSString *)imageUrl;

@end

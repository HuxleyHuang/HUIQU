//
//  OperationQueue.m
//  HuiQu
//
//  Created by Huxley on 17/3/7.
//  Copyright © 2017年 Huxley. All rights reserved.
//

#import "OperationQueue.h"

@implementation OperationQueue


+(UIImage *)getAsyncDownloadImage:(NSString *)imageUrl{
    UIImage *image = [[UIImage alloc] init];
    
    NSOperationQueue *opeartionQueue = [[NSOperationQueue alloc] init];
    
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage) object:nil];
    
    [opeartionQueue addOperation:operation];
    
//    NSURL *urlString = [NSURL URLWithString:imageUrl];
//    UIImage *image =  [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:urlString]];
    
    return image;
}




@end

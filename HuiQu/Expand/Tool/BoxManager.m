//
//  BoxManager.m
//  HuiQu
//
//  Created by Huxley on 16/12/30.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "BoxManager.h"

@implementation BoxManager


//保存图片到沙盒
+(void)savePictureToBoxName:(NSString *)picName andURL:(NSString *)picURL{
    //首先,需要获取沙盒路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 拼接图片名为"currentImage.png"的路径
    NSString *imageFilePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",picName]];
    //获取网络请求中的url地址
    NSData *data = [NSData dataWithContentsOfURL:[NSURL  URLWithString:picURL]];
    //转换为图片保存到以上的沙盒路径中
    UIImage * currentImage = [UIImage imageWithData:data];
    //其中参数0.5表示压缩比例，1表示不压缩，数值越小压缩比例越大
    [UIImageJPEGRepresentation(currentImage, 0.5) writeToFile:imageFilePath  atomically:YES];


}


/** 读取沙盒中的图片 */
+(UIImage *)getPictureToBoxName:(NSString *)picName{
    //首先,需要获取沙盒路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    //借助以上获取的沙盒路径读取图片
    NSString *imageFilePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",picName]];
    
    //获取图片
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:imageFilePath];
    
    
    return image;
}





@end

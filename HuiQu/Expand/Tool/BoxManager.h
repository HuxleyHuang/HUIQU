//
//  BoxManager.h
//  HuiQu
//
//  Created by Huxley on 16/12/30.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BoxManager : NSObject


/** 保存图片到沙盒 */
+(void)savePictureToBoxName:(NSString *)picName andURL:(NSString *)picURL;


/** 读取沙盒中的图片 */
+(UIImage *)getPictureToBoxName:(NSString *)picName;


@end

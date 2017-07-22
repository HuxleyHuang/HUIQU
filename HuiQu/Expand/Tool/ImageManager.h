//
//  ImageManager.h
//  HuiQu
//
//  Created by Huxley on 16/10/9.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ImageManager : NSObject

+(UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;

@end

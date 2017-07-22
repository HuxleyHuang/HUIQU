//
//  TextTool.h
//  InternetReptile
//
//  Created by Huxley on 16/6/13.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextTool : NSObject

+(CGSize )getTextSizeWithFont:(NSString *)fontText withFont:(UIFont *)font;


+(CGSize )getTextSizeWithFont:(NSString *)fontText withFont:(UIFont *)font withWidth:(CGFloat ) showWidth;


@end

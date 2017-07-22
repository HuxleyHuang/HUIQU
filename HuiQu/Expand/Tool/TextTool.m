//
//  TextTool.m
//  InternetReptile
//
//  Created by Huxley on 16/6/13.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "TextTool.h"

@implementation TextTool
+(CGSize )getTextSizeWithFont:(NSString *)fontText withFont:(UIFont *)font{
    
    CGRect screen = [UIScreen mainScreen].bounds;
    
    CGFloat maxWidth = screen.size.width-30;
    
    
    CGSize maxSize =  CGSizeMake(maxWidth, MAXFLOAT);
    
    
    CGSize textSize = CGSizeZero;
    // iOS7以后使用boundingRectWithSize，之前使用sizeWithFont
    if ([fontText respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        
        // 多行必需使用NSStringDrawingUsesLineFragmentOrigin，网上有人说不是用NSStringDrawingUsesFontLeading计算结果不对
        NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineBreakMode:NSLineBreakByCharWrapping];
        
        NSDictionary *attributes = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:style};
        
        NSStringDrawingContext *context = nil;
        
        
        CGRect textRect =  [fontText boundingRectWithSize:maxSize options:options attributes:attributes context:context];
        
        textSize = textRect.size;
        
        
    }else{
        
        textSize =  [fontText sizeWithFont:font constrainedToSize:maxSize lineBreakMode:NSLineBreakByCharWrapping];
    }
    
    
    return textSize;
}

+(CGSize)getTextSizeWithFont:(NSString *)fontText withFont:(UIFont *)font withWidth:(CGFloat)showWidth{

    
    CGFloat maxWidth = showWidth;
    
    
    CGSize maxSize =  CGSizeMake(maxWidth, MAXFLOAT);
    
    
    CGSize textSize = CGSizeZero;
    // iOS7以后使用boundingRectWithSize，之前使用sizeWithFont
    if ([fontText respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        
        // 多行必需使用NSStringDrawingUsesLineFragmentOrigin，网上有人说不是用NSStringDrawingUsesFontLeading计算结果不对
        NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineBreakMode:NSLineBreakByCharWrapping];
        
        NSDictionary *attributes = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:style};
        
        NSStringDrawingContext *context = nil;
        
        
        CGRect textRect =  [fontText boundingRectWithSize:maxSize options:options attributes:attributes context:context];
        
        textSize = textRect.size;
        
        
    }else{
        
        textSize =  [fontText sizeWithFont:font constrainedToSize:maxSize lineBreakMode:NSLineBreakByCharWrapping];
    }
    
    return textSize;
}
@end

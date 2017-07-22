//
//  DrawBorder.m
//  HuiQu
//
//  Created by Huxley on 16/10/23.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "DrawBorder.h"

@implementation DrawBorder

+(CALayer *)boderLayerWithView:(CGRect)viewFrame andBorderColor:(UIColor *)color andSiteType:(DrawBorderSiteType) borderSiteType{
    CALayer *borderLayer = [CALayer layer];
    if (borderSiteType == DrawBorderSiteTop) {
        float width=viewFrame.size.width;
        borderLayer.frame = CGRectMake(0.0f, 1.0f, width, 1.0f);
        borderLayer.backgroundColor = color.CGColor;
    }else if (borderSiteType == DrawBorderSiteRight){
        float height=viewFrame.size.height;
        float width=viewFrame.size.width-1.0f;
        borderLayer.frame = CGRectMake(width, 0.0f, 1.0f,height);
        borderLayer.backgroundColor = color.CGColor;
    }else if (borderSiteType == DrawBorderSiteBottom){
        float height=viewFrame.size.height-1.0f;
        float width=viewFrame.size.width;
        borderLayer.frame = CGRectMake(0.0f, height, width, 1.0f);
        borderLayer.backgroundColor = color.CGColor;
    }else if (borderSiteType == DrawBorderSiteLeft){
        float height=viewFrame.size.height;
        borderLayer.frame = CGRectMake(1.0f, 0.0f, 1.0f,height);
        borderLayer.backgroundColor = color.CGColor;
        
    }
    
    return borderLayer;
}


+(CALayer *)boderLayerWithView:(CGRect)viewFrame andBorderColor:(UIColor *)color andSiteType:(DrawBorderSiteType) borderSiteType andLength:(CGFloat)length{
    CALayer *borderLayer = [CALayer layer];
    if (borderSiteType == DrawBorderSiteTop) {
        float width=viewFrame.size.width;
        length = length>viewFrame.size.width?viewFrame.size.width:length;
        borderLayer.frame = CGRectMake((width-length)/2, 1.0f, length, 1.0f);
        borderLayer.backgroundColor = color.CGColor;
    }else if (borderSiteType == DrawBorderSiteRight){
        length = length>viewFrame.size.height?viewFrame.size.height:length;
        float height=viewFrame.size.height;
        float width=viewFrame.size.width-1.0f;
        borderLayer.frame = CGRectMake(width, (height-length)/2, 1.0f,length);
        borderLayer.backgroundColor = color.CGColor;
    }else if (borderSiteType == DrawBorderSiteBottom){
        length = length>viewFrame.size.width?viewFrame.size.width:length;
        float height=viewFrame.size.height-1.0f;
        float width=viewFrame.size.width;
        borderLayer.frame = CGRectMake((width-length)/2, height, length, 1.0f);
        borderLayer.backgroundColor = color.CGColor;
    }else if (borderSiteType == DrawBorderSiteLeft){
        length = length>viewFrame.size.height?viewFrame.size.height:length;
        float height=viewFrame.size.height;
        borderLayer.frame = CGRectMake(1.0f, (height-length)/2, 1.0f,length);
        borderLayer.backgroundColor = color.CGColor;
        
    }
    
    return borderLayer;
    
    
}



@end

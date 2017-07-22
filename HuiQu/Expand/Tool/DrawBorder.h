//
//  DrawBorder.h
//  HuiQu
//
//  Created by Huxley on 16/10/23.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DrawBorder : NSObject

typedef NS_ENUM(NSInteger, DrawBorderSiteType){
    DrawBorderSiteTop = 0,      //顶部
    DrawBorderSiteRight,        //右边
    DrawBorderSiteBottom,       //底部
    DrawBorderSiteLeft          //左边
};



+(CALayer *)boderLayerWithView:(CGRect)viewFrame andBorderColor:(UIColor *)color andSiteType:(DrawBorderSiteType) borderSiteType;

+(CALayer *)boderLayerWithView:(CGRect)viewFrame andBorderColor:(UIColor *)color andSiteType:(DrawBorderSiteType) borderSiteTyp andLength:(CGFloat)length;


@end

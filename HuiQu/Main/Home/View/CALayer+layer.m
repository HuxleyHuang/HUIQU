//
//  CALayer+layer.m
//  HuiQu
//
//  Created by Huxley on 16/10/12.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "CALayer+layer.h"

@implementation CALayer(layer)

- (void)setBorderColorFromUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
}
@end

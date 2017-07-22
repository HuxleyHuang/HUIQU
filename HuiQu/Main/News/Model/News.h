//
//  News.h
//  HuiQu
//
//  Created by Huxley on 16/10/17.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject

@property(copy, nonatomic) NSString *title;
@property(copy, nonatomic) NSString *imageName;
@property(copy, nonatomic) NSString *explain;
@property(copy, nonatomic) NSString *content;

+(News *)initNewsData:(NSString *)title andImageName:(NSString *)imageName andExplain:(NSString *)explain andContent:(NSString *)content;
@end

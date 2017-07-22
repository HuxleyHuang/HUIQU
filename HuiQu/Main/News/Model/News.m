//
//  News.m
//  HuiQu
//
//  Created by Huxley on 16/10/17.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "News.h"

@implementation News

+(News *)initNewsData:(NSString *)title andImageName:(NSString *)imageName andExplain:(NSString *)explain andContent:(NSString *)content{
    News *news =[[News alloc] init];
    news.title = title;
    news.imageName = imageName;
    news.explain = explain;
    news.content = content;
    return news;
}

@end

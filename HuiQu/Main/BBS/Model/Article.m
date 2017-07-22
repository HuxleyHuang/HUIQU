//
//  Article.m
//  HuiQu
//
//  Created by Huxley on 16/10/14.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "Article.h"

@implementation Article

+(Article *)initArticleImageName:(NSString *)imageName andAppearName:(NSString *)appearName andAppearTime:(NSString *)appearTime andTitle:(NSString *)title andRevertNum:(NSInteger )revertNum andCallerNum:(NSInteger)callerNum andContent:(NSString *)content andExplain:(NSString *)explain{
    Article *article = [[Article alloc] init];
    article.appearName = appearName;
    article.appearTime = appearTime;
    article.imageName = imageName;
    article.title = title;
    article.revertNum = revertNum;
    article.callerNum = callerNum;
    article.content = content;
    article.explain = explain;

    return article;
}

@end

//
//  Article.h
//  HuiQu
//
//  Created by Huxley on 16/10/14.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article : NSObject

/**  帖子标题 */
@property(copy, nonatomic) NSString *title;

/** 用户头像 */
@property(copy, nonatomic) NSString *imageName;

/** 帖子描述 */
@property(copy, nonatomic) NSString *explain;

/** 帖子内容 */
@property(copy, nonatomic) NSString *content;

/** 发表名 */
@property(copy, nonatomic) NSString *appearName;

/** 发表时间 */
@property(copy, nonatomic) NSString *appearTime;

/** 评论量 */
@property(assign, nonatomic) NSInteger revertNum;

/** 访问量*/
@property(assign, nonatomic) NSInteger callerNum;



/** 初始化数据 */
+(Article *)initArticleImageName:(NSString *)imageName andAppearName:(NSString *)appearName andAppearTime:(NSString *)appearTime andTitle:(NSString *)title andRevertNum:(NSInteger )revertNum andCallerNum:(NSInteger )callerNum andContent:(NSString *)content andExplain:(NSString *)explain;


@end

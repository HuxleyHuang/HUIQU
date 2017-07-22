//
//  GlobalData.h
//  HuiQu
//
//  Created by Huxley on 16/11/8.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalData : NSObject


typedef NS_ENUM(NSInteger,HQLoginUserSex) {
    HQLoginUserSexWoman=0,
    HQLoginUserSexMan
};

/** 用户ID **/
@property(copy, nonatomic) NSString *user_id;


/** 用户名 **/
@property(copy, nonatomic) NSString *user_name;


/** 地址 */
@property(copy, nonatomic) NSString *user_addr;


/** 用户手机号 **/
@property(copy, nonatomic) NSString *user_phone;

/** 用户头像地址 */
@property(copy,nonatomic) NSString *user_head_url;

/** 用户级别 */
@property(copy, nonatomic) NSString *user_level;

/** 是否是管理员 */
@property(nonatomic) BOOL isManager;

/** 性别 */
@property(assign,nonatomic) HQLoginUserSex user_sex;


/** 用户慧币 */
@property(assign, nonatomic) NSInteger user_money;


+(GlobalData *)instanceGlobal;


@end

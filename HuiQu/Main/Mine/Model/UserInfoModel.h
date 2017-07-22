//
//  UserInfoModel.h
//  HuiQu
//
//  Created by Huxley on 16/12/22.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject

@property(copy, nonatomic) NSString *user_id;

@property(assign, nonatomic) NSInteger user_sex;

@property(copy, nonatomic) NSString *user_address;

@property(copy, nonatomic) NSString *user_name;

@property(copy, nonatomic) NSString *user_headUrl;

@property(copy, nonatomic) NSString *user_level;

@property(copy, nonatomic) NSString *user_qianming;

@property(copy, nonatomic) NSString *user_age;

@end

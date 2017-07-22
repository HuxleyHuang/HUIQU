//
//  LiveItemModel.h
//  HuiQu
//
//  Created by Huxley on 16/12/15.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CreatorItemModel;

@interface LiveItemModel : NSObject


/** 直播流地址 */
@property (nonatomic, copy) NSString *stream_addr;
/** 关注人 */
@property (nonatomic, assign) NSUInteger online_users;
/** 城市 */
@property (nonatomic, copy) NSString *city;
/** 主播 */
@property (nonatomic, strong) CreatorItemModel *creator;

@end

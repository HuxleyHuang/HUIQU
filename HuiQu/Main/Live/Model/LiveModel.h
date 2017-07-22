//
//  LiveModel.h
//  HuiQu
//
//  Created by Huxley on 16/12/15.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LiveModel : NSObject

/** 采流地址 */
@property(copy, nonatomic) NSString *live_play_url;


/** 推流地址 */
@property(copy, nonatomic) NSString *live_push_url;


/** 播放秘钥 */
@property(copy, nonatomic) NSString *live_play_key;


/** 推流秘钥 */
@property(copy, nonatomic) NSString *live_push_key;


@end

//
//  ExpectModel.h
//  HuiQu
//
//  Created by Huxley on 16/11/8.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpectModel : NSObject


/** 期数ID **/
@property(copy,nonatomic) NSString *expect_id;

/**  期数 **/
@property(copy,nonatomic) NSString *expect_number;

/**  投注人数 **/
@property(copy,nonatomic) NSString *actor_number;

/** 投注金额  **/
@property(copy,nonatomic) NSString *current_money;

/**  开始投注时间 **/
@property(copy,nonatomic) NSString *cast_begin_time;

/**  结束投注时间 **/
@property(copy,nonatomic) NSString *cast_stop_time;

/**  抽奖时间 **/
@property(copy,nonatomic) NSString *take_begin_time;

/**  停止抽奖时间  **/
@property(copy,nonatomic) NSString *take_stop_time;

/**  直播领奖时间 **/
@property(copy,nonatomic) NSString *live_begin_time;

/**  直播领奖结束时间 **/
@property(copy,nonatomic) NSString *live_stop_time;

/**  该期状态 **/
@property(assign,nonatomic) NSNumber *openAward_status;

/**  该期创建时间 **/
@property(copy,nonatomic) NSString *create_time;

/** 当前服务器上的时间 **/
@property(copy, nonatomic) NSString *current_time;

/** 是否为投注时间 **/
@property(nonatomic) BOOL isCastTime;

/** 是否为抽奖时间 **/
@property(nonatomic) BOOL isTakeTime;

/** 是否为直播时间 **/
@property(nonatomic) BOOL isLiveTime;

/** 用户是否投注 **/
@property(nonatomic) BOOL  userIsCast;

/** 用户是否抽奖 **/
@property(nonatomic) BOOL  userIsTake;

/** 该用户是否领奖 **/
@property(nonatomic) BOOL isGetMoney;


/** 下期开始时间 */
@property(copy, nonatomic) NSString *next_begin_time;


/**特等奖名额是否存在*/
@property(nonatomic) BOOL isHaveTDJ;

/**一等奖名额是否存在*/
@property(nonatomic) BOOL isHaveYDJ;

/**二等奖名额是否存在*/
@property(nonatomic) BOOL isHaveEDJ;

/**二等奖名额是否存在*/
@property(nonatomic) BOOL isHaveSDJ;

/** 中奖用户 */
@property(strong, nonatomic) NSArray *awardArr;

/** 其它状态 **/
@property(copy, nonatomic) NSString *otherStatus;


/** 当前是否存在大转盘活动 */
@property(nonatomic) BOOL isExist;


/** 领奖方式 **/
typedef NS_ENUM(NSInteger,getMoneyWay){
    getMoneyByLiveWay,
    getMoneyByAutoGrant
};

/** 用户抽中的奖项 **/
@property(copy, nonatomic) NSString *userGainAward;

/** 用户慧币数量 **/
@property(copy, nonatomic) NSString *user_money;




@end

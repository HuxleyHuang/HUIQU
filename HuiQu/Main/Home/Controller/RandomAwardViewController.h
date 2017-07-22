//
//  RandomAwardViewController.h
//  HuiQu
//
//  Created by Huxley on 16/10/31.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>

@class ExpectModel;
@class TimeLabel;

@interface RandomAwardViewController : UIViewController<CAAnimationDelegate,UITableViewDelegate,UITableViewDataSource>

@property (retain, nonatomic) UIView  *popView;
@property (retain, nonatomic) UIButton *btn;

/** 奖项 */
@property (nonatomic, strong)   NSArray *awards;

/** 随机整数 */
@property (nonatomic, assign)   NSInteger intRandom;



/** 旋转的起始角度 */
@property (nonatomic, assign)   CGFloat beginAngle;

/** 旋转的终止角度 */
@property (nonatomic, assign)   CGFloat endAngle;



/** 该期数据源 **/
@property(strong, nonatomic) ExpectModel *expectModel;




//控件
/** 全局滚动视图 */
@property(strong, nonatomic) UIScrollView *scrollView;

/** 背景图  **/
@property(strong, nonatomic) UIImageView *backgroundImageView;

/** 转盘 **/
@property (retain, nonatomic) UIImageView *zhuanpan;

/** 手指 **/
@property (strong, nonatomic) UIImageView *handerView;

/** 直播按钮  观看直播 */
@property(strong, nonatomic) UIButton *liveButton;

/** 显示时间 **/
@property(strong, nonatomic) UILabel *showTimeLabel;

/** 倒计时 **/
@property(strong, nonatomic) TimeLabel *countDownTimeLabel;

/** 倒计时提示 **/
@property(strong, nonatomic) UILabel *countDownTipLabel;

/** 投注按钮 **/
@property(strong, nonatomic) UIButton *castButton;

/** 提示信息 **/
@property(strong, nonatomic) UILabel *tipLabel;

/** 中奖名单 **/
@property(strong, nonatomic) UIView *awardView;

/** 用户领奖 **/
@property(strong, nonatomic) UIButton *userliveButton;

/** 用户中的奖项 **/
@property(strong, nonatomic) UILabel *userAwardLabel;

/** 中奖提示 */
@property(strong, nonatomic) UILabel *awardTipLabel;

/** 中奖提示2 注 */
@property(strong, nonatomic) UILabel *awardNoticeLabel;


/** 领奖按钮 */
@property(strong, nonatomic) UIButton *beginLiveBtn;


/**更新数据定时器 */
@property(strong, nonatomic) NSTimer *updateDataTimer;



//底部
/** 底部投注详情 */
@property(strong, nonatomic) UIView *footView;
@property(strong, nonatomic) UILabel *peopleNumLabel;
@property(strong, nonatomic) UILabel *moneyNumLabel;
@property(strong, nonatomic) UILabel *numPeopleLabel;
@property(strong, nonatomic) UILabel *allMoneyLabel;



/** 投注弹窗 */
@property(strong, nonatomic) UIAlertController *castMoneyController;
@property(strong, nonatomic) UIAlertAction *YESAlertAction;
@property(strong, nonatomic) UIAlertAction *NOAlertAction;



/** 刷新  */
@property(strong, nonatomic) MJRefreshHeader *freshHeader;



/** 弹框提示 */
@property(strong, nonatomic) UIAlertController *alertTipController;
@property(strong, nonatomic) UIAlertAction *okTipAlertAction;





@end

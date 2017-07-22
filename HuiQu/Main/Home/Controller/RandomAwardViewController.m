//
//  RandomAwardViewController.m
//  HuiQu
//
//  Created by Huxley on 16/10/31.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "RandomAwardViewController.h"
#import "ColorManager.h"
#import "RollTableViewCell.h"
#import "TextTool.h"
#import "HHDataActionController.h"
#import "ExpectModel.h"
#import "TimeLabel.h"
#import "DateFormat.h"
#import "GlobalData.h"
#import "Macros.h"
#import "MBProgressHUD+MJ.h"
#import "DrawBorder.h"

#define actionURL @"http://120.77.17.190/app/appAction.php"


@interface RandomAwardViewController ()
{
    NSString *strPrise;
    CGFloat  cellHeight;
    NSMutableArray *awardList;
   
}


@property (strong, nonatomic) UIView *theadView;

@end

@implementation RandomAwardViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
     [self layoutUI];
    
    _freshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getData)];
    _scrollView.mj_header = _freshHeader;
    [_freshHeader beginRefreshing];
    
    
    //隔30秒获取服务器时间
    _updateDataTimer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(updateCurrentServerTime) userInfo:nil
                                                       repeats:YES];
    
    
}



/** 获取服务器当前时间  */
-(void)updateCurrentServerTime{
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"getTime",@"method", nil];
    
    [HHDataActionController requestAFNoCoverWithURL:actionURL params:dic httpMethod:@"GET" finishBlock:^(id result) {
        NSDictionary *resultDic = (NSDictionary *)result;
        _expectModel.current_time = [resultDic objectForKey:@"time"];
        NSLog(@"%@",_expectModel.current_time);
    } errorBlock:^(NSError *error) {
        
    }];

}


#pragma mark 初始化子视图
-(void)layoutUI{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"活动规则" style:UIBarButtonItemStylePlain target:self action:@selector(showRuleExplainAction)];
    self.navigationItem.title = @"幸运大转盘";
    
    //初始化按钮
    _scrollView = [[UIScrollView alloc] init];
    _backgroundImageView = [[UIImageView alloc] init];
    _zhuanpan = [[UIImageView alloc] init];
    _handerView = [[UIImageView alloc] init];
    _liveButton = [[UIButton alloc] init];
    _showTimeLabel = [[UILabel alloc] init];
    _countDownTimeLabel = [[TimeLabel alloc] init];
    _countDownTipLabel = [[UILabel alloc] init];
    _castButton = [[UIButton alloc] init];
    _tipLabel = [[UILabel alloc] init];
    _awardView = [[UIView alloc] init];
    _footView = [[UIView alloc] init];
    _peopleNumLabel = [[UILabel alloc] init];
    _moneyNumLabel = [[UILabel alloc] init];
    _numPeopleLabel = [[UILabel alloc] init];
    _allMoneyLabel = [[UILabel alloc] init];
    _userAwardLabel = [[UILabel alloc] init];
    _awardTipLabel = [[UILabel alloc] init];
    _awardNoticeLabel = [[UILabel alloc] init];
    _beginLiveBtn = [[UIButton alloc] init];
    
    

    
    UIFont *textFont = [UIFont systemFontOfSize:14];
    CGSize textSize = [TextTool getTextSizeWithFont:@"本期参与抽奖人数:" withFont:textFont];
    CGSize textMoneySize = [TextTool getTextSizeWithFont:@"投入慧币:" withFont:textFont];
    
    //布局
    //全局视图
    _scrollView.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-20-44-30);
    _scrollView.contentSize = CGSizeMake(Main_Screen_Width, Main_Screen_Height-20-44-30);
    
    
    //背景视图
    _backgroundImageView.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-20-44);
    
    //转盘
    _zhuanpan.frame = CGRectMake((Main_Screen_Width-250)/2, 40, 250, 250);
    
    
    //转盘手指
    _handerView.frame = CGRectMake(0, 0, 83, 107);
    _handerView.center = CGPointMake(_zhuanpan.center.x, _zhuanpan.center.y);
    
    //直播
    _liveButton.frame = CGRectMake(0, 60, 60, 30);
    
    
    //投注按钮
    _castButton.frame = CGRectMake(Main_Screen_Width/2-45, CGRectGetMaxY(_zhuanpan.frame)+25, 90, 30);
    
    //倒计时提示
    _tipLabel.frame = CGRectMake(Main_Screen_Width/2-70, CGRectGetMaxY(_castButton.frame)+5, 140, 25);
    
    
    
    //倒计时提示
    _countDownTipLabel.frame = CGRectMake(0, CGRectGetMaxY(_tipLabel.frame)+15, Main_Screen_Width/2, 30);
    
    //倒计时
    _countDownTimeLabel.frame = CGRectMake(CGRectGetMaxX(_countDownTipLabel.frame), CGRectGetMaxY(_tipLabel.frame)+15, Main_Screen_Width/2, 30);
    
    //显示时间
    _showTimeLabel.frame = CGRectMake(CGRectGetMaxX(_countDownTipLabel.frame), CGRectGetMaxY(_tipLabel.frame)+15, Main_Screen_Width/2, 30);

    //用户中的奖项
    _userAwardLabel.frame = CGRectMake(Main_Screen_Width/4, CGRectGetMaxY(_castButton.frame)+15, Main_Screen_Width/2, 30);
    
    
    
    //中奖名单
    _awardView.frame = CGRectMake(20,CGRectGetMaxY(_countDownTipLabel.frame)+20, Main_Screen_Width-40, 130);
    
    _theadView = [[UIView alloc] init];
    //上期获奖名单
    UILabel *lastLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, GetViewWidth(_awardView), 28)];
    lastLabel.textAlignment = NSTextAlignmentCenter;
    lastLabel.text = @"上期获奖名单";
    lastLabel.font = [UIFont systemFontOfSize:16];
    lastLabel.backgroundColor = [UIColor orangeColor];
    CALayer *lay =  [DrawBorder boderLayerWithView:lastLabel.frame andBorderColor:[UIColor whiteColor] andSiteType:DrawBorderSiteBottom];
    [lastLabel.layer addSublayer:lay];
    
    _theadView.frame = CGRectMake(0, CGRectGetMaxY(lastLabel.frame)+1, GetViewWidth(_awardView), 30);
    _theadView.backgroundColor = [UIColor orangeColor];
    
    UIFont *awardFont = [UIFont systemFontOfSize:13];
    
    UILabel *xuhaoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, GetViewWidth(_theadView)/3, 30)];
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(xuhaoLabel.frame), 0, GetViewWidth(_theadView)/3, 30)];
    UILabel *awardLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(phoneLabel.frame), 0, GetViewWidth(_theadView)/3, 30)];
    xuhaoLabel.text = @"序号";
    phoneLabel.text = @"手机号码";
    awardLabel.text = @"获得奖项";
    xuhaoLabel.textAlignment = NSTextAlignmentCenter;
    phoneLabel.textAlignment = NSTextAlignmentCenter;
    awardLabel.textAlignment = NSTextAlignmentCenter;
    xuhaoLabel.font = awardFont;
    phoneLabel.font = awardFont;
    awardLabel.font = awardFont;
    CALayer *theadLay =  [DrawBorder boderLayerWithView:_theadView.frame andBorderColor:[UIColor whiteColor] andSiteType:DrawBorderSiteBottom];
    [_theadView.layer addSublayer:theadLay];
    
    [_awardView addSubview:lastLabel];
    [_awardView addSubview:_theadView];
    [_theadView addSubview:xuhaoLabel];
    [_theadView addSubview:phoneLabel];
    [_theadView addSubview:awardLabel];
    
    
    
    //底部
    _footView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_scrollView.frame), Main_Screen_Width, 30)];
    _numPeopleLabel.frame = CGRectMake(0, 0,textSize.width, GetViewHeight(_footView));
    _peopleNumLabel.frame= CGRectMake(CGRectGetMaxX(_numPeopleLabel.frame), 0, GetViewWidth(_footView)*0.6-GetViewWidth(_numPeopleLabel), GetViewHeight(_footView));
    _allMoneyLabel.frame = CGRectMake(CGRectGetMaxX(_peopleNumLabel.frame), 0, textMoneySize.width, GetViewHeight(_footView));
    _moneyNumLabel.frame = CGRectMake(CGRectGetMaxX(_allMoneyLabel.frame), 0, GetViewWidth(_footView)*.4-GetViewWidth(_allMoneyLabel), GetViewHeight(_footView));
    
    
   
    
    
    _backgroundImageView.userInteractionEnabled = YES;
    _backgroundImageView.multipleTouchEnabled = YES;
    _handerView.userInteractionEnabled = NO;
    _handerView.multipleTouchEnabled = NO;
    _zhuanpan.userInteractionEnabled = YES;
    _zhuanpan.multipleTouchEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    
    _backgroundImageView.image = [UIImage imageNamed:@"award_background.png"];
    _zhuanpan.image = [UIImage imageNamed:@"zhuanpan.png"];
    _handerView.image = [UIImage imageNamed:@"take_normal"];
    
    
    _tipLabel.font = [UIFont systemFontOfSize:12];
    
    _tipLabel.textAlignment = NSTextAlignmentCenter;
    
    
    //_countDownTipLabel.text = @"倒计时提示信息:";
    _countDownTipLabel.textAlignment = NSTextAlignmentRight;
    _countDownTimeLabel.textAlignment = NSTextAlignmentLeft;
//    _countDownTimeLabel.hour = 00;
//    _countDownTimeLabel.minute = 20;
//    _countDownTimeLabel.second = 00;
    
    
    _showTimeLabel.textAlignment = NSTextAlignmentLeft;
    _userAwardLabel.textAlignment = NSTextAlignmentCenter;
    _userAwardLabel.textColor = [UIColor orangeColor];
    _awardTipLabel.textAlignment = NSTextAlignmentCenter;
    _awardNoticeLabel.textAlignment = NSTextAlignmentCenter;
    _awardNoticeLabel.textColor = [UIColor redColor];
    _awardNoticeLabel.font = [UIFont systemFontOfSize:12];
    
    
    _castButton.layer.borderWidth = 0.5;
    _castButton.layer.borderColor = [UIColor grayColor].CGColor;
    [_castButton setTitle:@"开始投注" forState:UIControlStateNormal];
    [_castButton addTarget:self action:@selector(castMoneyAction) forControlEvents:UIControlEventTouchUpInside];
    
    _liveButton.backgroundColor = [UIColor redColor];
    [_liveButton setTitle:@"直播中" forState:UIControlStateNormal];
    [_liveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_liveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    
    _beginLiveBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_beginLiveBtn setTitle:@"直播领奖" forState:UIControlStateNormal];
    [_beginLiveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_beginLiveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_beginLiveBtn addTarget:self action:@selector(goLiveView) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    _awardView.backgroundColor = [UIColor colorWithRed:1.0 green:0.4 blue:0.0 alpha:0.9];
    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnClick)];
    [_handerView addGestureRecognizer:tapGestureRecognizer];
    
    [_liveButton addTarget:self action:@selector(goLiveView) forControlEvents:UIControlEventTouchUpInside];
    
    UIFont *dataFont = [UIFont systemFontOfSize:12];
    
    _numPeopleLabel.text = @"本期参与抽奖人数:";
    _allMoneyLabel.text = @"投入慧币:";
    _moneyNumLabel.text = @"未知";
    _peopleNumLabel.text = @"未知";
    _allMoneyLabel.font = textFont;
    _numPeopleLabel.font = textFont;
    _moneyNumLabel.font = dataFont;
    _peopleNumLabel.font = dataFont;
    
    _moneyNumLabel.textColor = [UIColor orangeColor];
    _peopleNumLabel.textColor = [UIColor orangeColor];
    
    
    
    _liveButton.hidden = YES;
    _castButton.hidden = YES;
    _countDownTimeLabel.hidden = YES;
    _countDownTipLabel.hidden = YES;
    _tipLabel.hidden = YES;
    _showTimeLabel.hidden = YES;
    _awardView.hidden = YES;
    _userAwardLabel.hidden = YES;
    
    if (CGRectGetMaxY(_awardView.frame)>Main_Screen_Height-20-44-GetViewHeight(_footView)) {
        _scrollView.contentSize = CGSizeMake(Main_Screen_Width, CGRectGetMaxY(_awardView.frame)+20);
    }else{
        _scrollView.contentSize = CGSizeMake(Main_Screen_Width, Main_Screen_Height-20-44-GetViewHeight(_footView));
    }
    
    
    _backgroundImageView.frame = CGRectMake(0, 0, _scrollView.contentSize.width, _scrollView.contentSize.height);
    
    
    
    [_footView addSubview:_numPeopleLabel];
    [_footView addSubview:_allMoneyLabel];
    [_footView addSubview:_peopleNumLabel];
    [_footView addSubview:_moneyNumLabel];
    [_backgroundImageView addSubview:_zhuanpan];
    [_backgroundImageView addSubview:_handerView];
    [_backgroundImageView addSubview:_liveButton];
    [_backgroundImageView addSubview:_castButton];
    [_backgroundImageView addSubview:_countDownTimeLabel];
    [_backgroundImageView addSubview:_countDownTipLabel];
    [_backgroundImageView addSubview:_tipLabel];
    [_backgroundImageView addSubview:_showTimeLabel];
    [_backgroundImageView addSubview:_awardView];
    [_backgroundImageView addSubview:_userAwardLabel];
    [_backgroundImageView addSubview:_awardTipLabel];
    [_backgroundImageView addSubview:_awardNoticeLabel];
    [_backgroundImageView addSubview:_beginLiveBtn];
    
    
    [_scrollView addSubview:_backgroundImageView];
    [self.view addSubview:_scrollView];
    [self.view addSubview:_footView];
    
    
    
}


-(void)getData{

    awardList = [[NSMutableArray alloc] init];
    
    GlobalData *gdata = [GlobalData instanceGlobal];
    
    //获取该期数据
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"getExpect",@"method",gdata.user_id,@"user_id", nil];
    
    
    [HHDataActionController requestAFWithURL:actionURL params:dic httpMethod:@"GET" finishBlock:^(id result) {
        
         NSDictionary *dic = result;
        _expectModel = [[ExpectModel alloc] init];
        _expectModel.isExist =  [[dic objectForKey:@"isExist"] isEqualToString:@"1"];
         gdata.user_money = [[dic objectForKey:@"user_money"] integerValue];       //用户慧币
        
        
        _expectModel.expect_id =  [dic objectForKey:@"expect_id"];              //期数ID
        _expectModel.expect_number = [dic objectForKey:@"expect_number"];       //期数编号
        _expectModel.actor_number = [dic objectForKey:@"actor_number"];         //参与人数
        _expectModel.current_money = [dic objectForKey:@"current_money"];       //当前奖池金额
        _expectModel.cast_begin_time = [dic objectForKey:@"cast_begin_time"];   //投注开始时间
        _expectModel.cast_stop_time = [dic objectForKey:@"cast_stop_time"];     //投注结束时间
        _expectModel.take_begin_time = [dic objectForKey:@"take_begin_time"];   //抽奖开始时间
        _expectModel.take_stop_time = [dic objectForKey:@"take_stop_time"];     //抽奖结束时间
        _expectModel.live_begin_time = [dic objectForKey:@"live_begin_time"];    //直播开始时间
        _expectModel.live_stop_time = [dic objectForKey:@"live_stop_time"];     //直播停止时间
        _expectModel.openAward_status = [dic objectForKey:@"openAward_status"]; //当前期数开奖状态
        _expectModel.create_time = [dic objectForKey:@"create_time"];            //期数创建时间
        _expectModel.current_time = [dic objectForKey:@"current_time"];          //当前服务器时间
        _expectModel.isCastTime =  [[dic objectForKey:@"isCastTime"] isEqual:@1];     //是否为投注时间
        _expectModel.isLiveTime =[[dic objectForKey:@"isLiveTime"]  isEqual:@1];       //是否为直播时间
        _expectModel.isTakeTime =[[dic objectForKey:@"isTakeTime"] isEqual:@1];       //是否为抽奖时间
        _expectModel.userIsCast =[[dic objectForKey:@"userIsCast"] isEqual:@1];   //用户是否投注
        _expectModel.userIsTake =[[dic objectForKey:@"userIsTake"] isEqual:@1];   //用户是否抽奖
        _expectModel.userGainAward =[dic objectForKey:@"gain_award"];                      //用户获得奖项
        _expectModel.isGetMoney =[[dic objectForKey:@"isGetMoney"] isEqual:@1];        //用户是否领奖
        _expectModel.next_begin_time = [dic objectForKey:@"next_begin_time"];               //下期开始时间
        _expectModel.otherStatus = [dic objectForKey:@"other_status"];         //其它状态
        _expectModel.awardArr =  [dic objectForKey:@"award_user"];
        
        
        
        if (_expectModel.isTakeTime==YES) {
            _expectModel.isHaveTDJ = [[dic objectForKey:@"isHaveTDJ"] isEqualToString:@"1"];
            _expectModel.isHaveEDJ = [[dic objectForKey:@"isHaveEDJ"] isEqualToString:@"1"];
            _expectModel.isHaveYDJ = [[dic objectForKey:@"isHaveYDJ"] isEqualToString:@"1"];
            _expectModel.isHaveSDJ = [[dic objectForKey:@"isHaveSDJ"] isEqualToString:@"1"];
        }
        
        
        //模拟数据
//        _expectModel.expect_id = @"1478570400";
//        _expectModel.expect_number = @"1";
//        _expectModel.actor_number = @"120";
//        _expectModel.current_money = @"1200.00";
//        _expectModel.cast_begin_time = @"2016-11-10 16:00:00";
//        _expectModel.cast_stop_time = @"2016-11-10 16:36:42";
//        _expectModel.take_begin_time = @"2016-11-10 18:37:00";
//        _expectModel.take_stop_time = @"2016-11-10 19:37:16";
//        _expectModel.live_begin_time = @"2016-11-10 20:37:36";
//        _expectModel.live_stop_time = @"2016-11-10 22:37:46";
//        _expectModel.openAward_status = @1;
//        _expectModel.create_time = @"2016-11-08 12:38:01";
//        _expectModel.current_time = @"2016-11-17 18:44:54";
//        _expectModel.isCastTime = NO;
//        _expectModel.isTakeTime = NO;
//        _expectModel.isLiveTime = YES;
//        _expectModel.userIsCast = YES;
//        _expectModel.userIsTake = YES;
          _expectModel.userGainAward =[NSString stringWithFormat:@"%ld",[_expectModel.userGainAward integerValue]/110/119/120];
//        _expectModel.isGetMoney = NO;
//        _expectModel.next_begin_time = [DateFormat getStringFromDate:[NSDate date]];
        
        //格式化数据
        if ([_expectModel.userGainAward isEqualToString:@"1000"]) {
            _expectModel.userGainAward = @"特等奖";
        }else if([_expectModel.userGainAward isEqualToString:@"1001"]){
            _expectModel.userGainAward = @"一等奖";
        }else if([_expectModel.userGainAward isEqualToString:@"1002"]){
            _expectModel.userGainAward = @"二等奖";
        }else if([_expectModel.userGainAward isEqualToString:@"1003"]){
            _expectModel.userGainAward = @"三等奖";
        }else{
            _expectModel.userGainAward = @"未知";
        }
        
    
        
        [_freshHeader endRefreshing];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self layoutAwardView];
            
            if (_expectModel.isExist==YES) {
                if([_expectModel.openAward_status isEqual:@0]){
                    [self expectIsNoOpen];
                }else if([_expectModel.openAward_status isEqual:@1]){
                    [self expectIsBegin];
                }else if([_expectModel.openAward_status isEqual:@2]){
                    [self expectIsClose];
                }else{
                    [MBProgressHUD showError:@"获取开奖状态失败，请重试。"];
                    [self showAlertTitle:@"提示" andMessage:@"获取开奖状态失败，请重试。"];
                }
            }else{
                [self showAlertTitle:@"提示" andMessage:@"当前没有进行大转盘活动"];
            }
            
           
            
        });
        
    } errorBlock:^(NSError *error) {
        
        NSLog(@"请求失败");
        
        
    }];
    
   

}



//奖项视图
-(void)layoutAwardView{
    
    
    
    
    NSInteger count =  [_expectModel.awardArr count];
    for (int i=0; i<count; i++) {
        
        UIFont *font = [UIFont systemFontOfSize:12];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_theadView.frame)+5+i*30, GetViewWidth(_awardView), 30)];
        UILabel *xuhao = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, GetViewWidth(view)/3, GetViewHeight(view))];
        UILabel *phone = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(xuhao.frame), 0, GetViewWidth(view)/3, GetViewHeight(view))];
        UILabel *award = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(phone.frame), 0, GetViewWidth(view)/3, GetViewHeight(view))];
        
        if (i==count-1) {
            [view.layer addSublayer:[DrawBorder boderLayerWithView:view.frame andBorderColor:[UIColor whiteColor] andSiteType:DrawBorderSiteBottom]];
            NSInteger awardHeight = 60+30*(i+1)+5;
            CGRect rect =  _awardView.frame;
            rect.size.height = awardHeight;
            _awardView.frame = rect;
            
        }
        
        xuhao.textAlignment = NSTextAlignmentCenter;
        phone.textAlignment = NSTextAlignmentCenter;
        award.textAlignment = NSTextAlignmentCenter;
        xuhao.font = font;
        phone.font = font;
        award.font = font;
        xuhao.text = [NSString stringWithFormat:@"%d",i+1];
        
        NSString *phoneStr = [[_expectModel.awardArr objectAtIndex:i] objectForKey:@"user_phone"];
        NSString *front =  [phoneStr substringWithRange:NSMakeRange(0, 3)];
        NSString *suffix = [phoneStr substringWithRange:NSMakeRange(7, 4)];
        
        phone.text = [NSString stringWithFormat:@"%@xxxx%@",front,suffix];
        award.text = @"特等奖";
        
        
        
        view.tag = 1000+i;
        xuhao.tag = 10010+i;
        phone.tag = 10020+i;
        award.tag = 10030+i;
        
        [view addSubview:xuhao];
        [view addSubview:phone];
        [view addSubview:award];
        [_awardView addSubview:view];
    }
    
    
}




#pragma mark 抽奖控件显示控制
//该期未开始
-(void)expectIsNoOpen{
//    _liveButton.hidden = YES;
//    _showTimeLabel.hidden = YES;
//    _countDownTimeLabel.hidden = YES;
//    _countDownTipLabel.hidden = YES;
//    _castButton.hidden = YES;
//    _tipLabel.hidden = YES;
//    _awardView.hidden = YES;
//    _footView.hidden = YES;
//    _peopleNumLabel.hidden = YES;
//    _moneyNumLabel.hidden = YES;
//    _numPeopleLabel.hidden = YES;
//    _allMoneyLabel.hidden = YES;
//    _userAwardLabel.hidden = YES;
    
    
    //抽奖按钮灰色
    _handerView.image = [UIImage imageNamed:@"take_normal"];
    _handerView.multipleTouchEnabled = NO;
    _handerView.userInteractionEnabled = NO;
    
    //显示该期开始时间
    _countDownTipLabel.hidden = NO;
    _showTimeLabel.hidden = NO;
    _countDownTipLabel.text = @"下期开始时间:";
    _showTimeLabel.text = _expectModel.next_begin_time;
    
    
    //显示上期中奖名单
    _awardView.hidden = NO;
    
    //显示该期还未开始
    CGSize tSize  = [TextTool getTextSizeWithFont:@"活动未开始" withFont: _castButton.titleLabel.font];
    CGRect tFrame =  _castButton.frame;
    tFrame.size.width = tSize.width;
    tFrame.origin.x = Main_Screen_Width/2-tSize.width/2;
    _castButton.frame = tFrame;
    [_castButton setTitle:@"活动未开始" forState:UIControlStateNormal];
    _castButton.hidden = NO;
    _castButton.enabled = NO;
    
    
    _footView.hidden = NO;
    _liveButton.hidden = YES;
    _tipLabel.hidden = YES;
    _countDownTimeLabel.hidden = YES;
    _peopleNumLabel.text = @"活动未开始";
    _moneyNumLabel.text = @"活动未开始";
    _userAwardLabel.hidden = YES;
    _awardTipLabel.hidden = YES;
    _awardNoticeLabel.hidden = YES;
    _beginLiveBtn.hidden = YES;
    
    
}




//用户已投注
-(void)userIsYesCastLayoutUI{
    //大转盘按钮变灰
    _handerView.hidden = NO;
    _handerView.image = [UIImage imageNamed:@"take_normal"];
    _handerView.multipleTouchEnabled = NO;
    _handerView.userInteractionEnabled = NO;
    //显示开奖时间
    _countDownTipLabel.hidden = NO;
    _countDownTimeLabel.hidden = NO;
    _countDownTipLabel.text = @"距离抽奖时间还剩:";
    NSString *dateStr = [DateFormat getDate:[DateFormat getDateFromString:_expectModel.live_stop_time] andMinDate:[DateFormat getDateFromString:_expectModel.current_time]];
    NSArray *dateArr = [dateStr componentsSeparatedByString:@":"];
    _countDownTimeLabel.hour = [[dateArr objectAtIndex:0] integerValue];
    _countDownTimeLabel.minute = [[dateArr objectAtIndex:1] integerValue];
    _countDownTimeLabel.second = [[dateArr objectAtIndex:2] integerValue];
    //投注按钮显示已投注
    CGSize tSize  = [TextTool getTextSizeWithFont:@"已投注" withFont: _castButton.titleLabel.font];
    CGRect tFrame =  _castButton.frame;
    tFrame.size.width = tSize.width;
    tFrame.origin.x = Main_Screen_Width/2-tSize.width/2;
    _castButton.frame = tFrame;
    [_castButton setTitle:@"已投注" forState:UIControlStateNormal];
    _castButton.enabled = NO;
    _castButton.hidden = NO;
    //显示投注说明
    _tipLabel.hidden = NO;
    //显示当前参与人数
    _peopleNumLabel.text = _expectModel.actor_number;
    _peopleNumLabel.hidden = NO;
    //显示当前奖池金额
    _moneyNumLabel.text = _expectModel.current_money;
    _moneyNumLabel.hidden = NO;
    //显示上期中奖名单
    _awardView.hidden = NO;
    _tipLabel.text = @"注:每次投注为100慧币";
    _liveButton.hidden = YES;
    _showTimeLabel.hidden = YES;
    _footView.hidden = NO;
    _userAwardLabel.hidden = YES;
    _awardTipLabel.hidden = YES;
    _awardNoticeLabel.hidden = YES;

}




//用户已投注已抽奖
-(void)userIsYesCaseTakeLayoutUI{

    //大转盘按钮变灰不可用
    _handerView.hidden = NO;
    _handerView.image = [UIImage imageNamed:@"take_normal"];
    _handerView.multipleTouchEnabled = NO;
    _handerView.userInteractionEnabled = NO;
    
    
    //显示奖项提示
    _awardTipLabel.frame = CGRectMake(Main_Screen_Width/4, GetViewY(_userAwardLabel)-35, Main_Screen_Width/2, 30);
    //奖项注意
    _awardNoticeLabel.frame = CGRectMake(0, CGRectGetMaxY(_userAwardLabel.frame), Main_Screen_Width, 20);
    
    //显示奖项
    _userAwardLabel.hidden = NO;
    _userAwardLabel.text = _expectModel.userGainAward;
    _awardTipLabel.hidden = NO;
    _awardTipLabel.text = @"本期已抽奖已获得";
    _awardNoticeLabel.hidden = NO;
    _awardNoticeLabel.text = @"注:一二三等奖自动发放到用户账户中";
    
    
    //显示当前奖池金额
    //显示当前参与人数
    _peopleNumLabel.hidden = NO;
    _moneyNumLabel.hidden = NO;
    _peopleNumLabel.text = _expectModel.actor_number;
    _moneyNumLabel.text = _expectModel.current_money;
    
    
    
    //显示当前本期获奖名单
    _awardView.hidden = NO;
    _liveButton.hidden = YES;
    _showTimeLabel.hidden = YES;
    _countDownTimeLabel.hidden = YES;
    _countDownTipLabel.hidden = YES;
    _castButton.hidden = YES;
    _tipLabel.hidden = YES;

}



//用户未投注
-(void)userIsNoCastLayoutUI{
    //大转盘按钮变灰
    _handerView.hidden = NO;
    _handerView.image = [UIImage imageNamed:@"take_normal"];
    _handerView.multipleTouchEnabled = NO;
    _handerView.userInteractionEnabled = NO;
    //显示投注按钮
    CGSize tSize  = [TextTool getTextSizeWithFont:@"投注" withFont: _castButton.titleLabel.font];
    CGRect tFrame =  _castButton.frame;
    tFrame.size.width = tSize.width;
    tFrame.origin.x = Main_Screen_Width/2-tSize.width/2;
    _castButton.frame = tFrame;
    [_castButton setTitle:@"投注" forState:UIControlStateNormal];
    _castButton.hidden = NO;
    _castButton.enabled = YES;
    //显示剩余投注时间
    _countDownTipLabel.hidden = NO;
    _countDownTimeLabel.hidden = NO;
    _countDownTipLabel.text = @"距离投注结束还剩:";
    NSString *dateStr = [DateFormat getDate:[DateFormat getDateFromString:_expectModel.cast_stop_time] andMinDate:[DateFormat getDateFromString:_expectModel.current_time]];
    NSArray *dateArr = [dateStr componentsSeparatedByString:@":"];
    _countDownTimeLabel.hour = [[dateArr objectAtIndex:0] integerValue];
    _countDownTimeLabel.minute = [[dateArr objectAtIndex:1] integerValue];
    _countDownTimeLabel.second = [[dateArr objectAtIndex:2] integerValue];
    //显示当前参与人数
    //显示当前奖池金额
    _peopleNumLabel.hidden = NO;
    _moneyNumLabel.hidden = NO;
    _peopleNumLabel.text = _expectModel.actor_number;
    _moneyNumLabel.text = _expectModel.current_money;
    //显示上期中奖名单
    _awardView.hidden = NO;
    
    //显示投注说明
    _tipLabel.hidden = NO;
    _liveButton.hidden = YES;
    _showTimeLabel.hidden = YES;
    _userAwardLabel.hidden = YES;
    _awardTipLabel.hidden = YES;
    _awardNoticeLabel.hidden = YES;
    _tipLabel.text = @"注:每次投注为100慧币";


}




//该期进行中
-(void)expectIsBegin{
   
    //判断该期现在是什么时间
    //投注时间
    if (_expectModel.isCastTime) {
        //用户已投注
        if (_expectModel.userIsCast) {
            [self userIsYesCastLayoutUI];
        //用户未投注
        }else{
            [self userIsNoCastLayoutUI];
        }
    //抽奖时间
    }else if(_expectModel.isTakeTime){
        //用户已投注未抽奖
        if (_expectModel.userIsCast==YES&&_expectModel.userIsTake==NO) {
            //大转盘按钮可用
            _handerView.hidden = NO;
            _handerView.image = [UIImage imageNamed:@"take_highlight"];
            _handerView.multipleTouchEnabled = YES;
            _handerView.userInteractionEnabled = YES;
            
            
            //显示投注按钮
            CGSize tSize  = [TextTool getTextSizeWithFont:@"点击大转盘开始抽奖吧！" withFont: _castButton.titleLabel.font];
            CGRect tFrame =  _castButton.frame;
            tFrame.size.width = tSize.width;
            tFrame.origin.x = Main_Screen_Width/2-tSize.width/2;
            _castButton.frame = tFrame;
            [_castButton setTitle:@"点击大转盘开始抽奖吧！" forState:UIControlStateNormal];
            _castButton.enabled = NO;
            _castButton.hidden = NO;
            
            
            //显示当前参与人数
            //显示当前奖池金额
            _peopleNumLabel.hidden = NO;
            _moneyNumLabel.hidden = NO;
            _peopleNumLabel.text = _expectModel.actor_number;
            _moneyNumLabel.text = _expectModel.current_money;
            
            //显示本期获特等奖名单
            _awardView.hidden = NO;
            
            //显示奖项（如没抽奖显示 未抽奖）
            _userAwardLabel.hidden = NO;
            _userAwardLabel.text = @"未抽奖";
            
            //显示剩余抽奖时间
            _countDownTipLabel.hidden = NO;
            _countDownTimeLabel.hidden = NO;
            _countDownTipLabel.text = @"距离抽奖结束还剩:";
            
            NSString *dateStr = [DateFormat getDate:[DateFormat getDateFromString:_expectModel.take_stop_time] andMinDate:[DateFormat getDateFromString:_expectModel.current_time]];
            NSArray *dateArr =  [dateStr componentsSeparatedByString:@":"];
            
            _countDownTimeLabel.hour = [[dateArr objectAtIndex:0] integerValue];
            _countDownTimeLabel.minute = [[dateArr objectAtIndex:1] integerValue];
            _countDownTimeLabel.second = [[dateArr objectAtIndex:2] integerValue];
                _liveButton.hidden = YES;
                _showTimeLabel.hidden = YES;
                _tipLabel.hidden = YES;
                _awardTipLabel.hidden = YES;
                _awardNoticeLabel.hidden = YES;
            
        //用户已投注已抽奖
        }else if (_expectModel.userIsCast==YES&&_expectModel.userIsTake==YES){
            
            [self userIsYesCaseTakeLayoutUI];
            
            
            
        //用户未投注
        }else{
            //大转盘按钮变灰
            _handerView.hidden = NO;
            _handerView.image = [UIImage imageNamed:@"take_normal"];
            _handerView.multipleTouchEnabled = NO;
            _handerView.userInteractionEnabled = NO;
            //显示当前参与人数
            //显示当前奖池金额
            _peopleNumLabel.hidden = NO;
            _moneyNumLabel.hidden = NO;
            _peopleNumLabel.text = _expectModel.actor_number;
            _moneyNumLabel.text = _expectModel.current_money;
            
            //显示本期中奖名单
            _awardView.hidden = NO;
            
            //显示未投注 等待下一期
            _userAwardLabel.hidden = NO;
            _userAwardLabel.text = @"本期未投注哦";
            
            //下期开始时间
            _showTimeLabel.hidden = NO;
            _countDownTipLabel.hidden =NO;
            _countDownTipLabel.text = @"下期开始时间:";
            _showTimeLabel.text = _expectModel.cast_begin_time;
            
            
                _liveButton.hidden = YES;
                _countDownTimeLabel.hidden = YES;
                _castButton.hidden = YES;
                _tipLabel.hidden = YES;
            
        }
        
        _beginLiveBtn.hidden = YES;
    
    //直播时间
    }else if(_expectModel.isLiveTime){
        //显示当前参与人数
        //显示当前奖池金额
        _peopleNumLabel.hidden = NO;
        _moneyNumLabel.hidden = NO;
        _peopleNumLabel.text = _expectModel.actor_number;
        _moneyNumLabel.text = _expectModel.current_money;
        
        //显示本期中奖名单
        _awardView.hidden = NO;
        
        //大转盘按钮变灰
        _handerView.hidden = NO;
        _handerView.image = [UIImage imageNamed:@"take_normal"];
        _handerView.multipleTouchEnabled = NO;
        _handerView.userInteractionEnabled = NO;
        
        //判断用户是否投注是否抽奖是否得的是特等奖//是
        if (_expectModel.userIsCast==YES&&_expectModel.userIsTake==YES&& [_expectModel.userGainAward isEqualToString:@"特等奖"] && _expectModel.isGetMoney == NO) {
            //显示奖项 显示 直播领奖按钮
            _userAwardLabel.hidden = NO;
            _userAwardLabel.text = @"特等奖";
            _beginLiveBtn.frame = CGRectMake(CGRectGetMaxX(_userAwardLabel.frame), GetViewY(_userAwardLabel), 80, 28);
            _beginLiveBtn.hidden = NO;
            
            //奖项注意
            _awardNoticeLabel.frame = CGRectMake(0, CGRectGetMaxY(_countDownTipLabel.frame), Main_Screen_Width, 20);
            _awardNoticeLabel.hidden = NO;
            _awardNoticeLabel.text = @"注:一二三等奖自动发放到用户账户中";
            
            //显示奖项提示
            _awardTipLabel.frame = CGRectMake(Main_Screen_Width/4, GetViewY(_userAwardLabel)-35, Main_Screen_Width/2, 30);
            _awardTipLabel.hidden = NO;
            _awardTipLabel.text = @"本期已抽奖已获得奖项";
            
            
            //显示剩余领奖时间
            _countDownTipLabel.hidden = NO;
            _countDownTipLabel.text = @"剩余领奖时间:";
            _countDownTimeLabel.hidden = NO;
            _countDownTimeLabel.hour = 6;
            _countDownTimeLabel.minute = 8;
            _countDownTimeLabel.second = 11;
            //显示下期开始时间
            
                _liveButton.hidden = YES;
                _showTimeLabel.hidden = YES;
                _castButton.hidden = YES;
                _tipLabel.hidden = YES;
         //否
        }else if(_expectModel.userIsCast==YES&&_expectModel.userIsTake==YES&&[_expectModel.userGainAward isEqualToString:@"特等奖"]==NO){
            //左上角显示直播按钮(点击可观看直播)
            _liveButton.hidden = NO;
            
            //显示奖项
            _userAwardLabel.hidden = NO;
            _userAwardLabel.text = _expectModel.userGainAward;
            //显示下期开始时间
            _showTimeLabel.hidden = NO;
            _countDownTipLabel.hidden = NO;
            
            _countDownTipLabel.text  = @"下期开始时间:";
            _showTimeLabel.text = _expectModel.cast_begin_time;
            
            _castButton.hidden = YES;
            _tipLabel.hidden = YES;
            
            //奖项注意
            _awardNoticeLabel.frame = CGRectMake(0, CGRectGetMaxY(_countDownTipLabel.frame), Main_Screen_Width, 20);
            _awardNoticeLabel.hidden = NO;
            _awardNoticeLabel.text = @"注:一二三等奖自动发放到用户账户中";
            
            //显示奖项提示
            _awardTipLabel.frame = CGRectMake(Main_Screen_Width/4, GetViewY(_userAwardLabel)-35, Main_Screen_Width/2, 30);
            _awardTipLabel.hidden = NO;
            
            //显示提示信息
            _awardTipLabel.hidden = NO;
            _awardTipLabel.text = @"本期已抽奖已获得奖项";
            
        
            //抽奖
        }else{
            [self userNoTakeLayoutUI];
            
        }
        
        
    //未知情况
    }else{
        
        //投注结束与抽奖开始之间
        if ([_expectModel.otherStatus isEqualToString:@"1"]) {
            if(_expectModel.userIsCast==YES){       //用户已经投注
                [self userIsYesCastLayoutUI];
            }else{  //用户没有投注
                [self userIsNoCastLayoutUI];
            }
            
        //抽奖结束与直播开始之间
        }else if ([_expectModel.otherStatus isEqualToString:@"2"]){
            //用户有抽奖
            if(_expectModel.userIsCast==YES&&_expectModel.userIsTake==NO){       //用户已经抽奖
                //显示已抽奖
                [self userIsYesCaseTakeLayoutUI];
            }else{  //用户没有抽奖
                
                [self userNoTakeLayoutUI];
            }
         //
        }else{
            [MBProgressHUD showError:@"暂无大转盘活动"];
            [self showAlertTitle:@"提示" andMessage:@"当前没有大转盘活动"];
        }
        
        
        
    }
    
    

    
}







//该期已结束
-(void)expectIsClose{
    //大转盘按钮变灰
    _handerView.hidden = NO;
    _handerView.image = [UIImage imageNamed:@"take_normal"];
    _handerView.multipleTouchEnabled = NO;
    _handerView.userInteractionEnabled = NO;
    
    
    //投注按钮显示为 该期已结束
    CGSize tSize  = [TextTool getTextSizeWithFont:@"该期已结束" withFont: _castButton.titleLabel.font];
    CGRect tFrame =  _castButton.frame;
    tFrame.size.width = tSize.width;
    tFrame.origin.x = Main_Screen_Width/2-tSize.width/2;
    _castButton.frame = tFrame;
    [_castButton setTitle:@"该期已结束" forState:UIControlStateNormal];
    _castButton.enabled = NO;
    _castButton.hidden = NO;
    
    //显示该期的中奖名单
    _awardView.hidden = NO;
    
    //显示下期的开始时间
    _countDownTipLabel.hidden = NO;
    _showTimeLabel.hidden = NO;
    _countDownTipLabel.text = @"下期投注开始时间:";
    _showTimeLabel.text = _expectModel.next_begin_time;
    
    
}



//用户没有抽奖
-(void)userNoTakeLayoutUI{


    _liveButton.hidden = NO;
    _zhuanpan.hidden = NO;
    _handerView.hidden = NO;
    _showTimeLabel.text = _expectModel.next_begin_time;
    _awardView.hidden = NO;
    _showTimeLabel.hidden = NO;
    _countDownTipLabel.hidden = NO;
    _countDownTipLabel.text = @"下期开始时间:";
    
    //显示未投注 等待下一期
    _userAwardLabel.hidden = NO;
    _userAwardLabel.text = @"本期未抽过奖哦";
    
    _castButton.hidden = YES;
    _countDownTimeLabel.hidden = YES;
    _tipLabel.hidden = YES;
    _awardTipLabel.hidden = YES;
    _awardNoticeLabel.hidden = YES;
    _beginLiveBtn.hidden = YES;
    
    
    //显示当前参与人数
    _peopleNumLabel.text = _expectModel.actor_number;
    _peopleNumLabel.hidden = NO;
    //显示当前奖池金额
    _moneyNumLabel.text = _expectModel.current_money;
    _moneyNumLabel.hidden = NO;
}



#pragma  mark 投注控制
//投注请求
-(void)castAction{
    NSString *user_id = [GlobalData instanceGlobal].user_id;
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"userCast",@"method",user_id,@"user_id",_expectModel.expect_id,@"expect_id",@"100",@"money",nil];
    
    [HHDataActionController requestAFWithURL:actionURL params:dic httpMethod:@"GET" finishBlock:^(id result) {
        NSDictionary *resultDic = (NSDictionary *)result;
        
        NSString *statusTip =  [resultDic objectForKey:@"status"];
        NSString *isAdd =  [resultDic objectForKey:@"isAdd"];
        
        NSLog(@"%@",statusTip);
        if ([isAdd isEqualToString:@"1"]) {
            [self userIsYesCastLayoutUI];
            [self showAlertTitle:@"投注成功" andMessage:statusTip];
        }else{
            [self showAlertTitle:@"投注失败" andMessage:statusTip];
        }
        
    } errorBlock:^(NSError *error) {
        [self showAlertTitle:@"提示" andMessage:@"请求出错"];
        
    }];
    

}







//tableview 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 40;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RollTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rollCell"];
    
    if (cell == nil) {
        
        cell = [[RollTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"rollCell"];
    }
    
    //dataArray数据源
    cell.userLabel.text = @"用户12xxx53";
    cell.timeLabel.text = @"2016-11-02";
    cell.explainLabel.text = @"获得了500游戏币";
    
    cellHeight = cell.cellHeight;
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return cellHeight;
}





/** 属性延迟加载:奖项设置 */
- (NSArray *)awards{
    if (!_awards) {
        // 奖项的min和max区间由奖项在圆上分配多少决定。
        // 中奖和没中奖之间的分隔线设有1个弧度的盲区，指针不会旋转到的，避免抽奖的时候起争议。
        //        _awards = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"award.plist" ofType:nil]];
        _awards = @[
                    @{@"min" : @1,      @"max" : @17,     @"title" : @"特等奖"},
                    @{@"min" : @19,     @"max" : @53,     @"title" : @"三等奖"},
                    @{@"min" : @55,     @"max" : @89,     @"title" : @"二等奖"},
                    @{@"min" : @91,     @"max" : @125,    @"title" : @"三等奖"},
                    @{@"min" : @127,    @"max" : @161,    @"title" : @"特等奖"},
                    @{@"min" : @163,    @"max" : @197,    @"title" : @"三等奖"},
                    @{@"min" : @199,    @"max" : @233,    @"title" : @"二等奖"},
                    @{@"min" : @235,    @"max" : @269,    @"title" : @"三等奖"},
                    @{@"min" : @271,    @"max" : @305,    @"title" : @"一等奖"},
                    @{@"min" : @307,    @"max" : @341,    @"title" : @"三等奖"},
                    @{@"min" : @343,    @"max" : @360,    @"title" : @"特等奖"},
                    ];
    }
    return _awards;
}

#pragma mark 投入慧币请求
-(void)castMoneyAction{
    _castMoneyController = [UIAlertController alertControllerWithTitle:@"请确认" message:@"是否投注100慧币" preferredStyle:UIAlertControllerStyleAlert];
    _YESAlertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"投注");
        //添加投注信息
        [self castAction];
        //改变投注状态
        
        
        
    }];
    _NOAlertAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    
    [_castMoneyController addAction:_YESAlertAction];
    [_castMoneyController addAction:_NOAlertAction];
    
    [self presentViewController:_castMoneyController animated:YES completion:^{
        
    }];
    
    
    
}



#pragma mark 中奖记录
-(void)goAwardLog{
    
    
    
}






#pragma mark 抽奖请求
- (void)btnClick
{
    NSInteger iRandom;
    
    //可抽得的奖项
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    
    if (_expectModel.isHaveTDJ==NO) {
        [array addObject:@0];
        [array addObject:@4];
        [array addObject:@10];
    }
    
    if (_expectModel.isHaveYDJ==NO) {
        [array addObject:@8];
    }
    
    if (_expectModel.isHaveEDJ==NO) {
        [array addObject:@2];
        [array addObject:@6];
    }
    
    if (_expectModel.isHaveSDJ==NO) {
        [array addObject:@1];
        [array addObject:@3];
        [array addObject:@5];
        [array addObject:@7];
        [array addObject:@9];
    }
    
    
    //随机取值
    int value = arc4random() % array.count;
    iRandom = [array[value] integerValue];
    
    
    
//    if (randomNum>990 && randomNum<=1000) {        //概率10/1000
//        NSArray *arr = [NSArray arrayWithObjects:@0,@4,@10, nil];
//        int value = arc4random() % arr.count;
//        iRandom = [arr[value] integerValue];
//    } else if (randomNum>900 && randomNum<=990) {   //概率90/1000
//        NSArray *arr = [NSArray arrayWithObjects:@9,@7,@6, nil];
//        int value = arc4random() % arr.count;
//        iRandom = [arr[value] integerValue];
//    } else if (randomNum>700 && randomNum<=900) {    //概率200/1000
//        NSArray *arr = [NSArray arrayWithObjects:@4,@3, nil];
//        int value = arc4random() % arr.count;
//        iRandom = [arr[value] integerValue];
//        
//    } else {
//        NSArray *arr = [NSArray arrayWithObjects:@1,@0,nil];
//        int value = arc4random() % arr.count;
//        iRandom = [arr[value] integerValue];
//    }
    
    NSLog(@"%@",self.awards[iRandom][@"title"]);
    

    // 健壮性判断
    if (!self.awards.count) return;
    
    // 关闭按钮响应
    _handerView.userInteractionEnabled = NO;
    
    // 随机获取旋转角度
    self.endAngle = [self angleRandom:iRandom];
    
    // 创建核心动画
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.delegate = self;
    rotationAnimation.fromValue = @(self.beginAngle);   // 旋转的起始角度
    rotationAnimation.toValue = @(self.endAngle);       // 旋转的终止角度
    rotationAnimation.duration = 8.0;    // 动画持续时间
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];           // 淡入淡出效果
    rotationAnimation.removedOnCompletion = NO;         // 不移除动画完成后的效果
    rotationAnimation.fillMode = kCAFillModeBoth;       // 保持
    [_zhuanpan.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}


//动画结束
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    // 更新起始角度(下次点击旋转不会从初始角度开始)
    self.beginAngle = self.endAngle;
    
    // 防止逆向旋转和小角度旋转
    if (self.beginAngle >= self.endAngle) {
        self.beginAngle = self.beginAngle - [self angleRadian:360 * 8.0];
    }
    
    // 显示抽奖结果
    NSString *alertMessage = self.awards[self.intRandom][@"title"];
    //[self showAlertTitle:@"抽奖结果" andMessage:alertMessage];
    
    NSString *award = @"";
    double money = 0.00;
    double currMoney = [_expectModel.current_money doubleValue];
    
    if ([alertMessage isEqualToString:@"特等奖"]) {
        money = currMoney*0.2/2;
        award = [NSString stringWithFormat:@"%d",1000*110*119*120];
    }else if ([alertMessage isEqualToString:@"一等奖"]){
        money = currMoney*0.2/10;
        award = [NSString stringWithFormat:@"%d",1001*110*119*120];
    }else if([alertMessage isEqualToString:@"二等奖"]){
        money = currMoney*0.2/20;
        award = [NSString stringWithFormat:@"%d",1002*110*119*120];
    }else if ([alertMessage isEqualToString:@"三等奖"]){
        NSInteger actorNumber = [_expectModel.actor_number integerValue]-2-10-20;
        money = currMoney*0.2/actorNumber;
        award = [NSString stringWithFormat:@"%d",1003*110*119*120];
    }
    
    
    //数据请求参数
    
    
    //NSLog(@"%@-%@-%@-%f",[GlobalData instanceGlobal].user_id,_expectModel.expect_id,award,money);
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"userTake",@"method",[GlobalData instanceGlobal].user_id,@"user_id",_expectModel.expect_id,@"expect_id",award,@"award",[NSNumber numberWithDouble:money],@"money",nil];
    
    
    //抽奖请求数据
    [HHDataActionController requestAFWithURL:actionURL params:dic httpMethod:@"GET" finishBlock:^(id result) {
        
        NSDictionary *resultDic = (NSDictionary *)result;
        NSString *isUpdate = [resultDic objectForKey:@"isUpdate"];
        NSString *message = [resultDic objectForKey:@"status"];
        
        if ([isUpdate isEqualToString:@"1"]) {
            [self userIsYesCaseTakeLayoutUI];
            [self showAlertTitle:@"抽奖成功" andMessage:message];
        }else{
            [self showAlertTitle:@"抽奖失败" andMessage:message];
        }
        
        
    } errorBlock:^(NSError *error) {
        
    }];
    
    
    // 恢复开始按钮可交互
    //_handerView.userInteractionEnabled = YES;
}


#pragma mark - 私有工具方法
/** 随机获取旋转的角度 */
- (CGFloat)angleRandom:(NSInteger)random{
    // random 数组的第几个奖项
    //    self.intRandom = arc4random() % self.awards.count;
    self.intRandom = random;
    
    // 健壮性判断
    if (self.intRandom >= self.awards.count) return 0;
    
    // 取出这个奖项所在的角度
    NSDictionary *angleDict = self.awards[self.intRandom];
    int min = [angleDict[@"min"] intValue];
    int max = [angleDict[@"max"] intValue];
    
    // 获取随机角度(介于min与max之间)
    CGFloat angleRandom = arc4random() % (max - min) + min;
    
    // 360*5代表多圈旋转增添逼真效果
    // 注:如果让中心指针旋转那么计算的角度为angleRandom而不是(360 - angleRandom).
    CGFloat angle = ((360 - angleRandom) + 360 * 8.0);
    
    // 转弧度制后返回
    return [self angleRadian:angle];
}

/** 角度值转弧度制 */
- (CGFloat)angleRadian:(CGFloat)angle{
    return angle * M_PI / 180;
}





#pragma mark 规则介绍
-(void)showRuleExplainAction{
    
    

}


#pragma mark 弹框提示
-(void)showAlertTitle:(NSString *)title andMessage:(NSString *)message{
    
    
    

    _alertTipController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    _okTipAlertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
        
    }];
    
    [_alertTipController addAction:_okTipAlertAction];
    
    [self presentViewController:_alertTipController animated:YES completion:nil];
    
    
}



#pragma mark 进入直播
-(void)goLiveView{
    NSLog(@"ddd");
    //获取storyboard: 通过bundle根据storyboard的名字来获取我们的storyboard,
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"live" bundle:[NSBundle mainBundle]];
    //由storyboard根据myView的storyBoardID来获取我们要切换的视图
    UIViewController *myView = [story instantiateViewControllerWithIdentifier:@"LiveView"];
    //由navigationController推向我们要推向的view
    [self.navigationController pushViewController:myView animated:YES];
    
}

#pragma mark 横竖屏切换
- (void)viewWillLayoutSubviews{
    
   //[self _shouldRotateToOrientation:(UIDeviceOrientation)[UIApplication sharedApplication].statusBarOrientation];
    
}

-(void)_shouldRotateToOrientation:(UIDeviceOrientation)orientation {
        NSArray  *views =   [self.view subviews];
        for(UIView *v in views){
            [v removeFromSuperview];
        }
        [self viewDidLoad];
        
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)removeTimer {
    if (_updateDataTimer == nil) return;
    [_updateDataTimer invalidate];
    _updateDataTimer = nil;
}

-(void)dealloc{
    [self removeTimer];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

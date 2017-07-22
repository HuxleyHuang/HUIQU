//
//  ExchangeLogViewController.m
//  HuiQu
//
//  Created by Huxley on 16/10/27.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "ExchangeLogViewController.h"
#import "Macros.h"
#import "ExchangeLogTableViewCell.h"
#import "ExchangeLog.h"
@interface ExchangeLogViewController ()
{
    CGFloat cellHeight;
    NSArray<ExchangeLog *> *logArray;
}
@end

@implementation ExchangeLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"兑换记录";
    [self initSubData];
    [self initSubView];
    
    
}

-(void) initSubData{
    ExchangeLog *log1 = [ExchangeLog initDataWithName:@"慧币100" andTime:@"10-27 17:51:38" andExplain:@"慧币200"];
    ExchangeLog *log2 = [ExchangeLog initDataWithName:@"游戏豆500" andTime:@"10-27 17:46:38" andExplain:@"游戏豆200"];
    ExchangeLog *log3 = [ExchangeLog initDataWithName:@"游戏豆300" andTime:@"10-27 17:41:38" andExplain:@"游戏豆200"];
    ExchangeLog *log4 = [ExchangeLog initDataWithName:@"豆币1000" andTime:@"10-27 7:41:38" andExplain:@"游戏豆200"];
    ExchangeLog *log5 = [ExchangeLog initDataWithName:@"慧币100" andTime:@"10-27 7:38:38" andExplain:@"游戏豆200"];
    ExchangeLog *log6 = [ExchangeLog initDataWithName:@"斗币400" andTime:@"10-25 17:40:38" andExplain:@"游戏豆200"];
    
    logArray = [NSArray arrayWithObjects:log1,log2,log3,log4,log5,log6, nil];
    
}

-(void)initSubView{
    
    _logTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-20-44) style:UITableViewStylePlain];
    _logTableView.delegate = self;
    _logTableView.dataSource = self;
    
    
    _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 66)];
    
    UILabel *dhjlLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 5, 80, 22)];
    
    
    UIView *showNavView = [[UIView alloc] initWithFrame:CGRectMake(0,  CGRectGetMaxY(dhjlLabel.frame)+GetViewY(dhjlLabel), Main_Screen_Width, 40)];
    showNavView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.5];
    
    UILabel *exchangeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (GetViewHeight(showNavView)-30)/2, GetViewWidth(showNavView)/3, 30)];
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(exchangeLabel.frame), GetViewY(exchangeLabel), Main_Screen_Width/3, 30)];
    UILabel *explainLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(timeLabel.frame), GetViewY(timeLabel), Main_Screen_Width/3, 30)];
    
    
    exchangeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.textAlignment = NSTextAlignmentCenter;
    explainLabel.textAlignment = NSTextAlignmentCenter;
    
    dhjlLabel.font = [UIFont systemFontOfSize:13 weight:1];
    exchangeLabel.font = [UIFont systemFontOfSize:14];
    timeLabel.font = [UIFont systemFontOfSize:14];
    explainLabel.font = [UIFont systemFontOfSize:14];
    
    exchangeLabel.textColor = [UIColor orangeColor];
    timeLabel.textColor = [UIColor orangeColor];
    explainLabel.textColor = [UIColor orangeColor];
    
    exchangeLabel.text = @"兑换名称";
    timeLabel.text = @"兑换时间";
    explainLabel.text = @"获得状态";
    dhjlLabel.text = @"兑换记录";
    
    
    
    
    
    _logTableView.tableHeaderView = _tableHeaderView;
    _logTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [showNavView addSubview:exchangeLabel];
    [showNavView addSubview:timeLabel];
    [showNavView addSubview:explainLabel];
    [_tableHeaderView addSubview:dhjlLabel];
    [_tableHeaderView addSubview:showNavView];
    [self.view addSubview:_logTableView];
    

    
}


#pragma mark tableview代理
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ExchangeLogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"logCell"];
    if (cell==NULL) {
        cell = [[ExchangeLogTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"logCell"];
    }
    ExchangeLog *log = logArray[indexPath.row];
    cell.dhNameLabel.text =log.exName;
    cell.dhTimeLabel.text = log.exTime;
    cell.dhExplainLabel.text = log.exExplain;
    
    cellHeight = cell.cellHeight;
    return cell;

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return logArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return cellHeight;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

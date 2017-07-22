//
//  GameLogViewController.m
//  HuiQu
//
//  Created by Huxley on 16/10/27.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "GameLogViewController.h"
#import "Macros.h"
#import "TextTool.h"
#import "DrawBorder.h"
#import "MoneyLogTableViewCell.h"
@interface GameLogViewController ()
{
    CALayer *rightLayer;
    CALayer *leftLayer;
    CGFloat cellHeight;
}
@end

@implementation GameLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"游戏记录";
    [self initSubView];
}



-(void)initSubView{

    
    //头部视图
    _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 140)];
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 90)];
    _tabView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headView.frame), Main_Screen_Width, 50)];
    _headView.backgroundColor = [UIColor orangeColor];
    
    //头像
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, _headView.center.y-30, 60,60)];
    _headImageView.image = [UIImage imageNamed:@"default_head"];
    _headImageView.layer.cornerRadius = _headImageView.frame.size.height/2;
    _headImageView.layer.borderWidth = 2;
    _headImageView.layer.borderColor = [UIColor yellowColor].CGColor;
    _headImageView.layer.masksToBounds = YES;
    
    
    //昵称 姓名
    //慧币 余额
    CGSize textSize = [TextTool getTextSizeWithFont:@"昵称: " withFont:[UIFont systemFontOfSize:13]];
    _showNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame)+10, GetViewY(_headImageView), textSize.width, 30)];
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_showNameLabel.frame), GetViewY(_showNameLabel), 80, 30)];
    _howMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(GetViewX(_showNameLabel), CGRectGetMaxY(_showNameLabel.frame), textSize.width, 30)];
    _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_howMoneyLabel.frame),GetViewY(_howMoneyLabel), 50, 30)];
    _showNameLabel.text = @"昵称:";
    _nameLabel.text = @"Huxley";
    _howMoneyLabel.text = @"慧币:";
    _moneyLabel.text = @"50000";
    _showNameLabel.textColor = [UIColor whiteColor];
    _nameLabel.textColor = [UIColor whiteColor];
    _howMoneyLabel.textColor = [UIColor whiteColor];
    _moneyLabel.textColor = [UIColor whiteColor];
    _showNameLabel.textAlignment = NSTextAlignmentCenter;
    _howMoneyLabel.textAlignment = NSTextAlignmentCenter;
    _showNameLabel.font = [UIFont systemFontOfSize:13];
    _nameLabel.font = [UIFont systemFontOfSize:13];
    _howMoneyLabel.font = [UIFont systemFontOfSize:13];
    _moneyLabel.font = [UIFont systemFontOfSize:13];
    
    
    
    //左右切换按钮
    _leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, (GetViewHeight(_tabView)-35)/2, GetViewWidth(_tabView)/2, 35)];
    _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_leftButton.frame), (GetViewHeight(_tabView)-35)/2, GetViewWidth(_tabView)/2, 35)];
    [_leftButton setTitle:@"收入记录" forState:UIControlStateNormal];
    [_rightButton setTitle:@"支出记录" forState:UIControlStateNormal];
    
    [_leftButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [_rightButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    
    [_leftButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_leftButton setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [_rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_rightButton setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    
    
     rightLayer= [DrawBorder boderLayerWithView:_leftButton.frame andBorderColor:[UIColor whiteColor] andSiteType:DrawBorderSiteBottom andLength:_leftButton.frame.size.width*4/5];
     leftLayer= [DrawBorder boderLayerWithView:_leftButton.frame andBorderColor:[UIColor orangeColor] andSiteType:DrawBorderSiteBottom andLength:_rightButton.frame.size.width*4/5];
    
    [_leftButton.layer addSublayer:leftLayer];
    [_rightButton.layer addSublayer:rightLayer];
    
    
    
    //添加事件
    [_leftButton addTarget:self action:@selector(showGetMoney) forControlEvents:UIControlEventTouchUpInside];
    [_rightButton addTarget:self action:@selector(showPayMoney) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //tableview
    _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_tableHeaderView.frame), Main_Screen_Width, Main_Screen_Height-20-44-CGRectGetMaxY(_tableHeaderView.frame)) style:UITableViewStylePlain];
    _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_tableHeaderView.frame), Main_Screen_Width, Main_Screen_Height-20-44-CGRectGetMaxY(_tableHeaderView.frame)) style:UITableViewStylePlain];
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    _rightTableView.delegate = self;
    _rightTableView.dataSource = self;
    
    _leftTableView.hidden = NO;
    _rightTableView.hidden = YES;
    
    _rightTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _leftTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    
    [_headView addSubview:_showNameLabel];
    [_headView addSubview:_howMoneyLabel];
    [_headView addSubview:_moneyLabel];
    [_headView addSubview:_nameLabel];
    [_headView addSubview:_headImageView];
    [_tabView addSubview:_leftButton];
    [_tabView addSubview:_rightButton];
    [_tableHeaderView addSubview:_tabView];
    [_tableHeaderView addSubview:_headView];
    [self.view addSubview:_tableHeaderView];
    [self.view addSubview:_leftTableView];
    [self.view addSubview:_rightTableView];
    
}

#pragma mark 收入支出切换
-(void)showGetMoney{
    _rightTableView.hidden = YES;
    _leftTableView.hidden = NO;
    rightLayer.backgroundColor = [UIColor whiteColor].CGColor;
    leftLayer.backgroundColor = [UIColor orangeColor].CGColor;
    //更新数据
    
    //刷新数据
    [_leftTableView reloadData];
    
}

-(void)showPayMoney{
    _leftTableView.hidden = YES;
    _rightTableView.hidden = NO;
    rightLayer.backgroundColor = [UIColor orangeColor].CGColor;
    leftLayer.backgroundColor = [UIColor whiteColor].CGColor;
    
    //更新数据
    
    //刷新数据
    [_rightTableView reloadData];
    

}


#pragma mark left rightTableView 代理
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_leftTableView) {
        static NSString *identifier = @"leftTabCell";
        MoneyLogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell==NULL) {
            cell = [[MoneyLogTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
        cell.explainLabel.text = @"斗地主赢取300个游戏豆";
        cell.sumLabel.text = @"+300";
        cell.timeLabel.text = @"2016-10-28 16:37:59";
        
        cellHeight = cell.cellHeight;
        return cell;
        
    }else if (tableView==_rightTableView){
        static NSString *identifier = @"rightTabCell";
        MoneyLogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell==NULL) {
            cell = [[MoneyLogTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.explainLabel.text = @"斗地主输掉300个游戏豆";
        cell.sumLabel.text = @"-300";
        cell.timeLabel.text = @"2016-10-28 16:38:49";
        
        cellHeight = cell.cellHeight;
        return cell;
    }
    
    return nil;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView==_leftTableView) {
        
        return 1;
    }else if (tableView == _rightTableView){
        
        return 1;
    }
    
    return 0;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==_leftTableView) {
        
        return 6;
    }else if (tableView==_rightTableView){
    
        return 4;
    }
    return 0;
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

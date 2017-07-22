//
//  MyMoneyViewController.m
//  HuiQu
//
//  Created by Huxley on 16/10/27.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "MyMoneyViewController.h"
#import "Macros.h"
#import "TextTool.h"
#import "ExchangeTableViewCell.h"
#import "Money.h"
#import "ExchangeLogViewController.h"
@interface MyMoneyViewController ()
{
    CGFloat cellHeight;
    NSArray<Money *> *moneyArray;//货币兑换数据源
}
@end

@implementation MyMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"慧币兑换";
    // Do any additional setup after loading the view from its nib.
    [self initSubData];
    [self initSubView];
}

#pragma mark 初始化子视图数据
-(void)initSubData{
    
    Money *money1 = [Money initMoneyData:@"斗地主" andMoneyType:@"斗币" andHaveMoney:@1000];
    Money *money2 = [Money initMoneyData:@"大转盘" andMoneyType:@"豆币" andHaveMoney:@1000];
    
    moneyArray = [NSArray arrayWithObjects:money1,money2, nil];
    
}

#pragma mark 初始化子视图
-(void)initSubView{
    
    //兑换记录
    _rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"兑换记录" style:UIBarButtonItemStylePlain target:self action:@selector(goExchangeAction)];
    
    self.navigationItem.rightBarButtonItem =_rightBarButtonItem;
    
    
    //兑换表
    _moneyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-20-44) style:UITableViewStylePlain];
    _moneyTableView.delegate = self;
    _moneyTableView.dataSource = self;
    
    
    //头部视图
    _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 140)];
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 90)];
    _toolView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headView.frame), Main_Screen_Width, 50)];
    
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
    
    
    
    
    //兑换说明
    _explainToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, (GetViewHeight(_toolView)-35)/2, Main_Screen_Width, 35)];
    UIBarButtonItem *gameNameItem = [[UIBarButtonItem alloc] initWithTitle:@"游戏名" style:UIBarButtonItemStylePlain target:self action:nil];
    UIBarButtonItem *moneyTypeItem = [[UIBarButtonItem alloc] initWithTitle:@"使用币种" style:UIBarButtonItemStylePlain target:self action:nil];
    UIBarButtonItem *haveMoenyItem = [[UIBarButtonItem alloc] initWithTitle:@"已拥有" style:UIBarButtonItemStylePlain target:self action:nil];
    UIBarButtonItem *optionItem = [[UIBarButtonItem alloc] initWithTitle:@"操作" style:UIBarButtonItemStylePlain target:self action:nil];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [_explainToolBar setItems:@[gameNameItem,spaceItem,moneyTypeItem,spaceItem,haveMoenyItem,spaceItem,optionItem] animated:YES];
    _explainToolBar.clipsToBounds = YES;
    
  
    //底部视图为空白
    _moneyTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    

    _moneyTableView.tableHeaderView = _tableHeaderView;
    [_headView addSubview:_showNameLabel];
    [_headView addSubview:_nameLabel];
    [_headView addSubview:_howMoneyLabel];
    [_headView addSubview:_moneyLabel];
    [_headView addSubview:_headImageView];
    [_toolView addSubview:_explainToolBar];
    [_tableHeaderView addSubview:_headView];
    [_tableHeaderView addSubview:_toolView];
    [self.view addSubview:_moneyTableView];

}







#pragma mark 兑换记录请求
-(void)goExchangeAction{
    _exchangeLogViewController = [[ExchangeLogViewController alloc] init];
    [self.navigationController pushViewController:_exchangeLogViewController animated:YES];
}



#pragma mark tableview代理
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ExchangeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moneyCell"];
    if (cell==NULL) {
        cell = [[ExchangeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"moneyCell"];
    }
    
    Money *money = moneyArray[indexPath.row];
    cell.haveButtonItem.title = [money.haveMoney stringValue];
    cell.nameButtonItem.title = money.gameName;
    cell.optionButtonItem.title = @"兑换";
    cell.typeButtonItem.title = money.moneyType;
    
    cellHeight = cell.cellHeight;
    
    return cell;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return moneyArray.count;
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

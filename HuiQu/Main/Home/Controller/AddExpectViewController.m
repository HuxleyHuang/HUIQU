//
//  AddExpectViewController.m
//  HuiQu
//
//  Created by Huxley on 16/11/29.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "AddExpectViewController.h"

#import "Macros.h"

#import "HHDataActionController.h"
#import "DateFormat.h"

#import "MBProgressHUD+MJ.h"

#define addExpectURL @"http://hygo58.com/app/appAction.php"


@interface AddExpectViewController ()
{
    CGFloat currIndex;
}
@end

@implementation AddExpectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加期数";
    // Do any additional setup after loading the view from its nib.
    
    [self initSubView];
    
}

-(void)initSubView{
    _addTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, GetViewHeight(self.view)) style:UITableViewStyleGrouped];
    _addTableView.delegate = self;
    _addTableView.dataSource = self;
    
    _tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 60)];
    
    _addButton = [[UIButton alloc] initWithFrame:CGRectMake((GetViewWidth(_tableFooterView)-180)/2, 10,180, 40)];
    [_addButton setTitle:@"立即添加" forState:UIControlStateNormal];
    [_addButton setBackgroundColor:[UIColor orangeColor]];
    [_tableFooterView addSubview:_addButton];
    
    _addTableView.tableFooterView = _tableFooterView;
    _addTableView.tableHeaderView.frame = CGRectZero;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _addButton.backgroundColor = [UIColor grayColor];
    
    [_addButton addTarget:self action:@selector(addExpectAction) forControlEvents:UIControlEventTouchUpInside];
  
    
    
    
    [self.view addSubview:_addTableView];
    
    
}



#pragma mark 添加期数 数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     static NSString *addExpectIdentifier= @"addExpectCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:addExpectIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addExpectIdentifier];
    }
    
    CGFloat cellHeight =  GetViewHeight(cell.contentView);
    CGFloat cellWidth =  Main_Screen_Width;
    
    UIFont *timeFont = [UIFont systemFontOfSize:16];
    
    if (indexPath.section==0) {
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, cellWidth-20, cellHeight)];
        _numberLabel.text = @"2";
        [cell.contentView addSubview:_numberLabel];
        
    }else if (indexPath.section==1){
        _castBeginLabel  = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cellWidth/2, cellHeight)];
        _castStopLabel  = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_castBeginLabel.frame), 0, cellWidth/2, cellHeight)];
        _castBeginLabel.textAlignment = NSTextAlignmentCenter;
        _castStopLabel.textAlignment = NSTextAlignmentCenter;
        _castBeginLabel.userInteractionEnabled = YES;
        _castBeginLabel.multipleTouchEnabled = YES;
        _castStopLabel.userInteractionEnabled = YES;
        _castStopLabel.multipleTouchEnabled = YES;
        _castBeginLabel.font = timeFont;
        _castStopLabel.font = timeFont;
        UITapGestureRecognizer *beginTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(castBeginTimeAction)];
        UITapGestureRecognizer *stopTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(castStopTimeAction)];
        [_castBeginLabel addGestureRecognizer:beginTapGesture];
        [_castStopLabel addGestureRecognizer:stopTapGesture];
        
        _castBeginLabel.text = @"2016-12-05 14:23:00";
        _castStopLabel.text = @"2016-12-05 15:23:00";
        [cell.contentView addSubview:_castBeginLabel];
        [cell.contentView addSubview:_castStopLabel];
    
    }else if (indexPath.section==2){
        _takeBeginLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cellWidth/2, cellHeight)];
        _takeStopLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_takeBeginLabel.frame), 0, cellWidth/2, cellHeight)];
        _takeBeginLabel.textAlignment = NSTextAlignmentCenter;
        _takeStopLabel.textAlignment = NSTextAlignmentCenter;
        _takeBeginLabel.userInteractionEnabled = YES;
        _takeBeginLabel.multipleTouchEnabled = YES;
        _takeStopLabel.userInteractionEnabled = YES;
        _takeStopLabel.multipleTouchEnabled = YES;
        _takeStopLabel.font =timeFont;
        _takeBeginLabel.font = timeFont;
        UITapGestureRecognizer *beginTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(takeBeginTimeAction)];
        UITapGestureRecognizer *stopTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(takeStopTimeAction)];
        [_takeBeginLabel addGestureRecognizer:beginTapGesture];
        [_takeStopLabel addGestureRecognizer:stopTapGesture];
        
        _takeBeginLabel.text = @"2016-12-05 15:25:00";
        _takeStopLabel.text = @"2016-12-05 16:23:00";
        [cell.contentView addSubview:_takeBeginLabel];
        [cell.contentView addSubview:_takeStopLabel];
        
    }else if (indexPath.section==3){
        _liveBeginLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cellWidth/2, cellHeight)];
        _liveStopLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_liveBeginLabel.frame), 0, cellWidth/2, cellHeight)];
        _liveBeginLabel.textAlignment = NSTextAlignmentCenter;
        _liveStopLabel.textAlignment = NSTextAlignmentCenter;
        _liveBeginLabel.userInteractionEnabled = YES;
        _liveBeginLabel.multipleTouchEnabled = YES;
        _liveStopLabel.userInteractionEnabled = YES;
        _liveStopLabel.multipleTouchEnabled = YES;
        UITapGestureRecognizer *beginTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(liveBeginTimeAction)];
        UITapGestureRecognizer *stopTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(liveStopTimeAction)];
        [_liveBeginLabel addGestureRecognizer:beginTapGesture];
        [_liveStopLabel addGestureRecognizer:stopTapGesture];
        _liveBeginLabel.font = timeFont;
        _liveStopLabel.font = timeFont;
        
        _liveBeginLabel.text = @"2016-12-05 16:30:00";
        _liveStopLabel.text = @"2016-12-05 17:23:00";
        [cell.contentView addSubview:_liveBeginLabel];
        [cell.contentView addSubview:_liveStopLabel];
        
    }else if (indexPath.section==4){
        _openStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, cellWidth-20, cellHeight)];
        _openStatusLabel.text = @"未开始";
        [cell.contentView addSubview:_openStatusLabel];
    }
    

    return cell;
}



-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *title = @"";
    if (section==0) {
        title = @"期数号";
    }else if (section == 1){
        title = @"投注 开始时间--结束时间";
    }else if (section == 2){
        title = @"抽奖 开始时间--结束时间";
    }else if (section == 3){
        title = @"直播 开始时间--结束时间";
    }else if (section == 4){
        title = @"开奖状态";
    }
    
    return title;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{


    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    
    return 25;
}

#pragma mark 添加期数代理方法
//选中



//


#pragma mark 时间选择
-(void)castBeginTimeAction{
    //[self setupDateView:DateTypeOfStart];
    currIndex = 0;
    _pickerView = [UWDatePickerView instanceDatePickerView];
    _pickerView.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-20-44);
    _pickerView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.4];
    _pickerView.delegate = self;
    _pickerView.type = DateTypeOfStart;
    [self.view addSubview:_pickerView];

}

-(void)castStopTimeAction{
    currIndex =1;
    _pickerView = [UWDatePickerView instanceDatePickerView];
    _pickerView.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-20-44);
    _pickerView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.4];
    _pickerView.delegate = self;
    _pickerView.type = DateTypeOfStart;
    [self.view addSubview:_pickerView];
}


-(void)takeBeginTimeAction{
    currIndex =2;
    _pickerView = [UWDatePickerView instanceDatePickerView];
    _pickerView.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-20-44);
    _pickerView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.4];
    _pickerView.delegate = self;
    _pickerView.type = DateTypeOfStart;
    [self.view addSubview:_pickerView];
}

-(void)takeStopTimeAction{
    currIndex =3;
    _pickerView = [UWDatePickerView instanceDatePickerView];
    _pickerView.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-20-44);
    _pickerView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.4];
    _pickerView.delegate = self;
    _pickerView.type = DateTypeOfStart;
    [self.view addSubview:_pickerView];
}


-(void)liveBeginTimeAction{
    currIndex =4;
    _pickerView = [UWDatePickerView instanceDatePickerView];
    _pickerView.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-20-44);
    _pickerView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.4];
    _pickerView.delegate = self;
    _pickerView.type = DateTypeOfStart;
    [self.view addSubview:_pickerView];
}

-(void)liveStopTimeAction{
    currIndex =5;
    _pickerView = [UWDatePickerView instanceDatePickerView];
    _pickerView.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-20-44);
    _pickerView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.4];
    _pickerView.delegate = self;
    _pickerView.type = DateTypeOfStart;
    [self.view addSubview:_pickerView];
}


- (void)getSelectDate:(NSString *)date type:(DateType)type {
    
    NSLog(@"时间 : %@",date);
    switch (type) {
        case DateTypeOfStart:
            // TODO 日期确定选择
            if (currIndex==0) {
                _castBeginLabel.text = date;
            }else if (currIndex==1){
                _castStopLabel.text = date;
            }else if (currIndex==2){
                _takeBeginLabel.text = date;
            }else if (currIndex==3){
                _takeStopLabel.text = date;
            }else if (currIndex==4){
                _liveBeginLabel.text = date;
            }else if (currIndex==5){
                _liveStopLabel.text = date;
            }
            break;
        case DateTypeOfEnd:
            // TODO 日期取消选择
            break;
        default:
            break;
    }
}
    
-(void)addExpectAction{
    NSDate *castBeginDate = [DateFormat getDateFromString:_castBeginLabel.text];
    NSDate *castStopDate = [DateFormat getDateFromString:_castStopLabel.text];
    NSDate *takeBeginDate = [DateFormat getDateFromString:_takeBeginLabel.text];
    NSDate *takeStopDate = [DateFormat getDateFromString:_takeStopLabel.text];
    NSDate *liveBeginDate = [DateFormat getDateFromString:_liveBeginLabel.text];
    NSDate *liveStopDate = [DateFormat getDateFromString:_liveStopLabel.text];
    
   
    
    
    if([[DateFormat compareOneDay:castStopDate withAnotherDay:castBeginDate] isEqualToString:@"-1"]||[[DateFormat compareOneDay:castStopDate withAnotherDay:castBeginDate] isEqualToString:@"0"]){
        NSLog(@"投注结束时间不能早于投注开始时间");
        [MBProgressHUD showError:@"投注结束时间不能早于投注开始时间"];
        return;
    }else if ([[DateFormat compareOneDay:takeBeginDate withAnotherDay:castStopDate] isEqualToString:@"-1"]||[[DateFormat compareOneDay:takeBeginDate withAnotherDay:castStopDate] isEqualToString:@"0"]){
        NSLog(@"开奖开始时间不能早于投注结束时间");
        [MBProgressHUD showError:@"开奖开始时间不能早于投注结束时间"];
        return;
    }else if ([[DateFormat compareOneDay:takeStopDate withAnotherDay:takeBeginDate] isEqualToString:@"-1"]||[[DateFormat compareOneDay:takeStopDate withAnotherDay:takeBeginDate] isEqualToString:@"0"]){
         NSLog(@"开奖结束时间不能早于开奖开始时间");
        [MBProgressHUD showError:@"开奖结束时间不能早于开奖开始时间"];
        return;
    }else if ([[DateFormat compareOneDay:liveBeginDate withAnotherDay:takeStopDate] isEqualToString:@"-1"]||[[DateFormat compareOneDay:liveBeginDate withAnotherDay:takeStopDate] isEqualToString:@"0"]){
         NSLog(@"直播开始时间不能早于开奖结束时间");
        [MBProgressHUD showError:@"直播开始时间不能早于开奖结束时间"];
        return;
    }else if ([[DateFormat compareOneDay:liveStopDate withAnotherDay:liveBeginDate] isEqualToString:@"-1"]||[[DateFormat compareOneDay:liveStopDate withAnotherDay:liveBeginDate] isEqualToString:@"0"]) {
         NSLog(@"直播结束时间不能早于直播开始时间");
        [MBProgressHUD showError:@"直播结束时间不能早于直播开始时间"];
        return;
    }
    _addButton.backgroundColor = [UIColor orangeColor];
    //MBProgressHUD *hud = [MBProgressHUD showMessage:@"提交中"];
    
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"addExpect",@"method",_numberLabel.text,@"expect_number",_castBeginLabel.text,@"cast_begin_time",_castStopLabel.text,@"cast_stop_time",_takeBeginLabel.text,@"take_begin_time",_takeStopLabel.text,@"take_stop_time",_liveBeginLabel.text,@"live_begin_time",_liveStopLabel.text,@"live_stop_time",_openStatusLabel.text,@"openAward_status", nil];
    
    
    [HHDataActionController requestAFWithURL:addExpectURL params:dic httpMethod:@"GET" finishBlock:^(id result) {
        //[hud hide:YES];
        NSDictionary *dic = (NSDictionary *)result;
        if ([[dic objectForKey:@"isSuccess"] isEqualToString:@"1"]) {
            [MBProgressHUD showSuccess:[dic objectForKey:@"status"]];
            
        }else{
            [MBProgressHUD showError:[dic objectForKey:@"status"]];
        }
        NSLog(@"%@",[dic objectForKey:@"status"]);
        
        //主线程更新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:[dic objectForKey:@"status"] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alertController addAction:okAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
            
        });
        
        
    } errorBlock:^(NSError *error) {
        NSLog(@"请求失败");
    }];
 

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

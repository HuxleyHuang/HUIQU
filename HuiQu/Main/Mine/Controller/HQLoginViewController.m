//
//  HQLoginViewController.m
//  HuiQu
//
//  Created by Huxley on 16/11/2.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "HQLoginViewController.h"
#import "Macros.h"
#import "UIViewExt.h"
#import "MBProgressHUD+MJ.h"
#import "ForgetViewController.h"
#import "RegisterViewController.h"
#import "HQTabBarViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "JsonManager.h"
#import "AppDelegate.h"
#import "GlobalData.h"

#import "BoxManager.h"

#define imageHeight Main_Screen_Width*(259.0/640)

@interface HQLoginViewController ()

@end

@implementation HQLoginViewController


-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:YES];
    
    [_navBar removeFromSuperview];
    [_timer invalidate];
    _timer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _stateString = @"0";
    self.title = @"登录";
    
    _scorllV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    CGFloat scrollH = Main_Screen_Height;
    if (Main_Screen_Height <= 568) {
        scrollH = 600;
    }
    [self.view addSubview:_scorllV];
    _scorllV.contentSize = CGSizeMake(Main_Screen_Width, scrollH);
    _scorllV.delegate = self;
    
    [self creatSubViews];
}


-(void)creatSubViews{
    
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, imageHeight)];
    [imgV setImage:[UIImage imageNamed:@"001.jpg"]];
    [_scorllV addSubview:imgV];
    
    NSArray *arr = @[@"手机号码",@"密码"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [defaults objectForKey:@"ResultAuthData"];
    NSString *loginState= [NSString stringWithFormat:@"%@",dic[@"loginState"]];
    NSString *phone= [NSString stringWithFormat:@"%@",dic[@"phone"]];
    NSString *secure= [NSString stringWithFormat:@"%@",dic[@"secure"]];
    
    for (int i=0; i<arr.count; i++) {
        
        UITextField *textF = [[UITextField alloc]initWithFrame:CGRectMake(30, imageHeight+20+i*60, Main_Screen_Width-60, 50)];
        [_scorllV addSubview:textF];
        textF.placeholder = arr[i];
        textF.delegate = self;
        textF.tag = 100+i;
        textF.clearButtonMode = UITextFieldViewModeWhileEditing;
        textF.borderStyle = UITextBorderStyleNone;
        textF.layer.borderWidth = 1;
        textF.layer.borderColor = [[UIColor lightGrayColor]CGColor];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 50)];
        textF.leftView = view;
        textF.leftViewMode = UITextFieldViewModeAlways;
        
        
        if ([loginState isEqualToString:@"1"]) {
            if (i == 0) {
                textF.text = phone;
            }else if(i == 1){
                textF.text = secure;
            }
        }
        
        
        if(i == 1){
            textF.secureTextEntry = YES;
        }
    }
    UITextField *textF3 = [_scorllV viewWithTag:101];
    _btnLogIn = [[UIButton alloc]initWithFrame:CGRectMake(30, textF3.bottom+15, Main_Screen_Width-60, 44)];
    _btnLogIn.backgroundColor = [UIColor lightGrayColor];
    [_btnLogIn setTitle:@"登录" forState:UIControlStateNormal];
    _btnLogIn.layer.cornerRadius = 7;
    [_btnLogIn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [_scorllV addSubview:_btnLogIn];
#pragma mark 自动登录功能已关闭
//    UIButton *btn12 = [[UIButton alloc]initWithFrame:CGRectMake(32, _btnLogIn.bottom+22, 16, 16)];
//    btn12.layer.borderWidth = 1;
//    btn12.layer.borderColor = [[UIColor grayColor]CGColor];
//    btn12.layer.cornerRadius = 2;
//    btn12.tag = 750;
//    if([loginState isEqualToString:@"1"]){
//        btn12.selected = YES;
//        btn12.layer.borderWidth = 0;
//        _stateString = @"1";
//    }
//    [btn12 addTarget:self action:@selector(btnAction12:) forControlEvents:UIControlEventTouchUpInside];
//    [btn12 setBackgroundImage:[UIImage imageNamed:@"dc.png"] forState:UIControlStateSelected];
//    [_scorllV addSubview:btn12];
    
#pragma mark 自动登录功能已关闭
//    UILabel *label12 = [[UILabel alloc]initWithFrame:CGRectMake(btn12.right+7, _btnLogIn.bottom+15, 120, 30)];
//    label12.text = @"1周内自动登录";
//    label12.textColor = [UIColor grayColor];
//    [_scorllV addSubview:label12];
    
#pragma mark 找回密码功能关闭
//    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width-120, _btnLogIn.bottom+15, 90, 30)];
//    [btn2 setTitle:@"忘记密码?" forState:UIControlStateNormal];
//    [btn2 addTarget:self action:@selector(btnAction2) forControlEvents:UIControlEventTouchUpInside];
//    [btn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    [_scorllV addSubview:btn2];
    
#pragma mark 注册功能关闭
    //注册
//    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width/2-60, _btnLogIn.bottom+60, 120, 40)];
//    [btn3 setTitle:@"用户注册" forState:UIControlStateNormal];
//    [btn3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    btn3.titleLabel.font = [UIFont systemFontOfSize:16];
//    btn3.layer.borderWidth = 1;
//    btn3.layer.borderColor = [[UIColor redColor]CGColor];
//    btn3.layer.cornerRadius = 20;
//    [btn3 addTarget:self action:@selector(btnAction3) forControlEvents:UIControlEventTouchUpInside];
//    [_scorllV addSubview:btn3];
    
}

//获取验证码
//-(void)imgBtnAction{
//    
//    UIImageView *imgV = [_scorllV viewWithTag:230];
//    NSString *urlImg = [NSString stringWithFormat:@"%@api/validateCode",MainURL];
//    [imgV setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlImg]]]];
//}


-(void)btnAction{
    
    UITextField *textF1 = [_scorllV viewWithTag:100];
    UITextField *textF2 = [_scorllV viewWithTag:101];
    
    if (_btnLogIn.backgroundColor != [UIColor lightGrayColor]) {
        
        if (textF1.text.length != 11) {
            
            if (textF1.text) {
                
                textF1.text = @"";
                textF2.text = @"";
            }
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"手机号码格式有误,请重新填写";
            // 隐藏时候从父控件中移除
            hud.removeFromSuperViewOnHide = YES;
            // 1秒之后再消失
            [hud hide:YES afterDelay:1.5];
        }else{
                MBProgressHUD *login_hud = [MBProgressHUD showMessage:@"正在登录" toView:self.view];
             //参数 phone手机号码 password密码
                        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                        NSString *urlString = @"http://120.77.17.190/app/appAction.php";
                        manager.requestSerializer = [AFHTTPRequestSerializer serializer];//默认的方式
                        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            
                        NSLog(@"%@-%@",textF1.text,textF2.text);
                        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:textF1.text,@"phone",textF2.text,@"pwd",@"login",@"method", nil];
            
            
                        [manager GET:urlString parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
                            NSLog(@"登录请求%lld/%lld",downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);
                        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                            //数据加载完后回调.
                           
                            NSString *result = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
                            NSDictionary *dic  = [JsonManager dictionaryWithJsonString:result];
                            NSString *login_status =  [dic objectForKey:@"login_status"];
                           
                        
                            
                            NSLog(@"%@",login_status);
                            login_hud.mode = MBProgressHUDModeText;
                            if([login_status isEqualToString:@"0"]){
                                login_hud.labelText = @"手机或密码错误";
                                [login_hud hide:YES afterDelay:1.5];
                            }else if([login_status isEqualToString:@"1"]){
                                login_hud.labelText = @"登录成功";
                                [login_hud hide:YES afterDelay:1.5];
                                
                                 //保存用户信息
                                GlobalData *global =  [GlobalData instanceGlobal];
                                global.user_id = [dic objectForKey:@"user_id"];
                                global.user_name = [dic objectForKey:@"user_name"];
                                global.user_level = [dic objectForKey:@"user_level"];
                                global.user_head_url = [dic objectForKey:@"user_headUrl"];
                                global.user_phone = [dic objectForKey:@"user_phone"];
                                global.user_addr = [dic objectForKey:@"user_address"];
                                global.isManager = [[dic objectForKey:@"user_level"] isEqualToString:@"38"]==YES?YES:NO;
                                global.user_sex = [[dic objectForKey:@"user_sex"] isEqualToString:@"1"]==YES?HQLoginUserSexMan:HQLoginUserSexWoman;
                                
                                
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    //[BoxManager savePictureToBoxName:@"user_head" andURL:[dic objectForKey:@"head_url"]];
                                });
                                
                                NSLog(@"111");
                                
                                //跳转首页
                                AppDelegate *appDelegate = (AppDelegate *)AppDelegateInstance;
                                appDelegate.tabBarController = [[HQTabBarViewController alloc] init];
                                [appDelegate.window setRootViewController:appDelegate.tabBarController];
                                [appDelegate.window makeKeyAndVisible];
                                NSLog(@"222");
                            }else{
                                login_hud.labelText = @"服务器内部错误";
                                [login_hud hide:YES afterDelay:1.5];
                            }
                            
                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                            //数据加载失败回调.
                            NSLog(@"登录失败: %@",error);
                            login_hud.labelText = @"登录失败";
                            [login_hud hide:YES afterDelay:1.5];
                            
                        }];
        }
        NSLog(@"可以登录");
    }else{
        
        NSLog(@"登录NO");
    }
}


-(void)btnAction12:(UIButton *)btn12{
    
    btn12.selected = !btn12.selected;
    if (btn12.selected) {
        btn12.layer.borderWidth = 0;
        _stateString = @"1";
    }else{
        btn12.layer.borderWidth = 1;
        _stateString = @"0";
    }
}

//-(void)btnAction2{
//    
//    ForgetViewController *forgetVC = [[ForgetViewController alloc]init];
//    [self.navigationController pushViewController:forgetVC animated:YES];
//    NSLog(@"忘记密码");
//}


//注册请求关闭
//-(void)btnAction3{
//    
//    NSLog(@"用户注册");
//    RegisterViewController *registeVC = [[RegisterViewController alloc]init];
//    [self.navigationController pushViewController:registeVC animated:YES];
//}





- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    UITextField *textF1 = [_scorllV viewWithTag:100];
    UITextField *textF2 = [_scorllV viewWithTag:101];
    if (textF1.text.length >= 1 && textF2.text.length >= 1 ) {
        _btnLogIn.backgroundColor = [UIColor colorWithRed:0.002 green:0.774 blue:0.003 alpha:1.000];
    }else{
        _btnLogIn.backgroundColor = [UIColor lightGrayColor];
    }
    
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    UITextField *textF1 = [_scorllV viewWithTag:100];
    UITextField *textF2 = [_scorllV viewWithTag:101];
    if (textF1.text.length >= 1 | textF2.text.length >= 1) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(textFTime) userInfo:nil repeats:YES];
    }
    
    if (textField == textF2) {
        
        //键盘将要出现 发出通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
        
        //键盘将要隐藏
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillHideNotification object:nil];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    UITextField *textF1 = [_scorllV viewWithTag:100];
    UITextField *textF2 = [_scorllV viewWithTag:101];
    if (textF1.text.length >= 1 && textF2.text.length >= 1) {
        _btnLogIn.backgroundColor = [UIColor colorWithRed:0.002 green:0.774 blue:0.003 alpha:1.000];
        //取消定时器
        [_timer invalidate];
    }else{
        _btnLogIn.backgroundColor = [UIColor lightGrayColor];
    }
    
}

-(void)textFTime{
    
    NSLog(@"定时器");
    UITextField *textF1 = [_scorllV viewWithTag:100];
    UITextField *textF2 = [_scorllV viewWithTag:101];
    if (textF1.text.length >= 1 && textF2.text.length >= 1) {
       _btnLogIn.backgroundColor = [UIColor colorWithRed:0.002 green:0.774 blue:0.003 alpha:1.000];
        //取消定时器
        [_timer invalidate];
    }else{
        _btnLogIn.backgroundColor = [UIColor lightGrayColor];
    }
}

//在一个VIewController收起键盘的方法如下:
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


#pragma mark - 键盘通知调用方法
-(void)keyBoardShow:(NSNotification *)notif{
    
    //根据通知名获取通知
    if ([notif.name isEqualToString:@"UIKeyboardWillShowNotification"]) {
        
        _scorllV.transform = CGAffineTransformMakeTranslation(0, -150);
        
    }else if ([notif.name isEqualToString:@"UIKeyboardWillHideNotification"]){
        
        _scorllV.transform = CGAffineTransformMakeTranslation(0, 0);
    }
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
    if (self.isViewLoaded && !self.view.window) {
        
        self.view = nil;
    }
}



@end

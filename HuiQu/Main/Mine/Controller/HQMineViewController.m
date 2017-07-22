//
//  HQMineViewController.m
//  HuiQu
//
//  Created by Huxley on 16/10/9.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "HQMineViewController.h"
#import "Macros.h"
#import "TextTool.h"
#import "ImageManager.h"
#import "AppDelegate.h"
#import "HQLoginViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "HHDataActionController.h"
#import "MBProgressHUD+MJ.h"
#import "JsonManager.h"
#import "GlobalData.h"
#import "MBProgressHUD+MJ.h"
#import "XHVersion.h"
#import "BoxManager.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define photoUploadUrl @"http://120.77.17.190/app/appAction.php"


@interface HQMineViewController ()

@end

@implementation HQMineViewController

- (void)viewDidLoad {
    self.navigationItem.title = @"我的慧趣";
    [super viewDidLoad];
    [self initSubView];
}



-(void)initSubView{
    
    GlobalData *globalData = [GlobalData instanceGlobal];
    
    //菜单栏
    _mineTableView = [[UITableView alloc] initWithFrame:CGRectMake(Main_Screen_Bounds.origin.x, Main_Screen_Bounds.origin.y, Main_Screen_Width, Main_Screen_Height-44-20-49) style:UITableViewStylePlain];
    _mineTableView.delegate = self;
    _mineTableView.dataSource = self;
    [self.view addSubview:_mineTableView];
    
    
    //头部
    UIView *headerTableView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*0.2)];
    headerTableView.backgroundColor = [UIColor orangeColor];
    _mineTableView.tableHeaderView = headerTableView;
    //控制
    _personControl = [[UIControl alloc] initWithFrame:headerTableView.frame];
    [headerTableView addSubview:_personControl];
    
    
    
    
    //头像
    
    _headImageView = [[UIImageView alloc] init];
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:globalData.user_head_url]];
    
    [_headImageView setFrame:CGRectMake(0, 0, 60,60)];
    _headImageView.center = headerTableView.center;
    _headImageView.frame = CGRectMake(GetViewX(_headImageView), GetViewY(_headImageView)-15, GetViewWidth(_headImageView), GetViewHeight(_headImageView));
    _headImageView.layer.cornerRadius = _headImageView.frame.size.height/2;
    _headImageView.layer.borderWidth = 2;
    _headImageView.layer.borderColor = [UIColor yellowColor].CGColor;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.multipleTouchEnabled = YES;
    _headImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *photoChangedGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapHeaderImageView)];
    [_headImageView addGestureRecognizer:photoChangedGesture];
    
    
    //昵称
    UILabel *petNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(Main_Screen_Width/2-40-5, CGRectGetMaxY(_headImageView.frame)+5, 40, 24)];
    [petNameLabel setText:@"昵称:"];
    [TextTool getTextSizeWithFont:@"昵称:" withFont:[UIFont systemFontOfSize:11]];
    [petNameLabel setFont:[UIFont systemFontOfSize:11]];
    [petNameLabel setTextColor:[UIColor colorWithWhite:1 alpha:0.8]];
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(petNameLabel.frame), GetViewY(petNameLabel), (GetViewWidth(headerTableView)-CGRectGetMaxX(petNameLabel.frame))*0.5, GetViewHeight(petNameLabel))];
    
    [_nameLabel setText:[GlobalData instanceGlobal].user_name];
    [_nameLabel setTextColor:[UIColor colorWithWhite:1 alpha:0.8]];
    [_nameLabel setFont:[UIFont systemFontOfSize:11]];
    
    
    
    //底部
    UIView *footerTableView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*0.12)];
    _mineTableView.tableFooterView = footerTableView;
    _exitButton = [[UIButton alloc] initWithFrame:CGRectMake(15,GetViewHeight(footerTableView)/2-20 , Main_Screen_Width-30, 40)];
    _exitButton.backgroundColor = [UIColor grayColor];
    [_exitButton setShowsTouchWhenHighlighted:YES];
    [_exitButton setTitle:@"退出" forState:UIControlStateNormal];
    [_exitButton addTarget:self action:@selector(exitLogin:) forControlEvents:UIControlEventTouchUpInside];
    [footerTableView addSubview:_exitButton];
    
    
    //nav右边消息按钮
    
   UIImage *rightButtonImage =  [ImageManager reSizeImage:[UIImage imageNamed:@"my_message"] toSize:CGSizeMake(30, 22)];
    _rightBarButton = [[UIBarButtonItem alloc] initWithImage: rightButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(goMyMessage)];
   
    self.navigationItem.rightBarButtonItem = _rightBarButton;
    
    
    
    [headerTableView addSubview:_nameLabel];
    [headerTableView addSubview:petNameLabel];
    [headerTableView addSubview:_headImageView];
    
    

}


#pragma mark 退出登录
-(void)exitLogin:(UIButton *)button{
    AppDelegate *appDelegate = (AppDelegate *)AppDelegateInstance;
    appDelegate.loginViewController =  [[HQLoginViewController alloc] init];
    [appDelegate.window setRootViewController:appDelegate.loginViewController];
    [appDelegate.window makeKeyAndVisible];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark 去我的消息
-(void)goMyMessage{
    NSLog(@"请求消息界面");
}


#pragma mark tableview  代理
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineCell"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MineCell"];
    }
    
    if (indexPath.row==0) {
        cell.textLabel.text = @"我的资料";
        [cell.imageView setImage:[UIImage imageNamed:@"my_data"]];
    }else if (indexPath.row==1){
        cell.textLabel.text = @"我的慧币";
        [cell.imageView setImage:[UIImage imageNamed:@"my_money"]];
    }else if (indexPath.row==2){
        cell.textLabel.text = @"游戏记录";
        [cell.imageView setImage:[UIImage imageNamed:@"my_game"]];
    }else if (indexPath.row==3){
        cell.textLabel.text = @"我的消息";
        [cell.imageView setImage:[UIImage imageNamed:@"my_message"]];
    }else if(indexPath.row==4){
        cell.textLabel.text = @"版本更新";
        [cell.imageView setImage:[UIImage imageNamed:@"version_update"]];
    }else if (indexPath.row==5){
        cell.textLabel.text = @"关于我们";
        [cell.imageView setImage:[UIImage imageNamed:@"my_aboutme"]];
    }
    
    return cell;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}



//菜单选择
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row==0){
        _personDataViewController = [[PersonDataViewController alloc] init];
        [self.navigationController pushViewController:_personDataViewController animated:YES];
    }else if (indexPath.row==1){
        _myMoneyViewController = [[MyMoneyViewController alloc] init];
        [self.navigationController pushViewController:_myMoneyViewController animated:YES];
    }else if (indexPath.row==2){
        _gameLogViewController = [[GameLogViewController alloc] init];
        [self.navigationController pushViewController:_gameLogViewController animated:YES];
    }else if (indexPath.row==3){
        _messageViewController = [[MyMessageViewController alloc] init];
        [self.navigationController pushViewController:_messageViewController animated:YES];
    }else if(indexPath.row==4){
//        MBProgressHUD *hud = [MBProgressHUD showMessage:@"检查更新中"];
//        [hud hide:YES afterDelay:1];
        //请在你需要检测更新的位置添加下面代码
        
        //1.新版本检测(使用默认提示框)
        [XHVersion checkNewVersion];
        
        //2.如果你需要自定义提示框,请使用下面方法
        [XHVersion checkNewVersionAndCustomAlert:^(XHAppInfo *appInfo) {
            
            //appInfo为新版本在AppStore相关信息
            //请在此处自定义您的提示框
            NSLog(@"新版本信息:\n 版本号 = %@ \n 更新时间 = %@\n 更新日志 = %@ \n 在AppStore中链接 = %@\n AppId = %@ \n bundleId = %@" ,appInfo.version,appInfo.currentVersionReleaseDate,appInfo.releaseNotes,appInfo.trackViewUrl,appInfo.trackId,appInfo.bundleId);
            
        }];
        

    }else if (indexPath.row==5){
        _aboutMeViewController = [[AboutMeViewController alloc] init];
        [self.navigationController pushViewController:_aboutMeViewController animated:YES];
    }


    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    return 45;
}



-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{


    return 12;
}



#pragma mark 图片上传
- (void)didTapHeaderImageView
{
    NSLog(@"点击了头像");
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"照片" message:@"拍照或者从相册中选择照片" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * __nonnull action) { // 点击了拍照按钮"
        
        // 拍照
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            
            picker.allowsEditing = YES;
            picker.sourceType = sourceType;
            [self presentViewController:picker animated:YES completion:nil];
        }else
        {
            NSLog(@"模拟其中无法打开照相机,请在真机中使用");
        }
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * __nonnull action) { // 点击了相册按钮
        
        
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) { // 没有相册
            return;
        }
        
        
        UIImagePickerController *pickerVC = [[UIImagePickerController alloc] init];
        pickerVC.delegate = self;
        
        pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:pickerVC animated:YES completion:nil];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * __nonnull action) {
        
    }];
    
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:action3];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}



#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(nonnull UIImagePickerController *)picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<NSString *,id> *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([type isEqualToString:@"public.image"])
    {
        
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil)
        {
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        else
        {
            data = UIImagePNGRepresentation(image);
        }
        
        
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        NSString *imageName = [NSString stringWithFormat:@"/headerImage.png"];
        
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:imageName] contents:data attributes:nil];
        //        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
        
        //得到沙盒中图片的完整路径
        NSString *filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  imageName];
        image = [UIImage imageWithContentsOfFile:filePath];
        
        NSData * imageData = UIImageJPEGRepresentation(image,1);
        NSInteger length = [imageData length]/1000;
        NSLog(@"%ld",length);
        //上传到服务器
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"headUpload",@"method",[GlobalData instanceGlobal].user_id,@"user_id", nil];
        
        [manager POST:photoUploadUrl parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            [formData appendPartWithFileData:imageData name:@"fileName" fileName:filePath mimeType:@".png"];
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
            NSLog(@"头像上传进度%lld/%lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSData *data = [[NSData alloc] initWithData:responseObject];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"错误编码:%@",[dic objectForKey:@"error"]);
            
            if([[dic objectForKey:@"status"] isEqualToString:@"1"]){
               dispatch_queue_t queue = dispatch_queue_create("head_queue", DISPATCH_QUEUE_CONCURRENT);;
               dispatch_async(queue, ^{
                   [BoxManager savePictureToBoxName:@"user_head" andURL:[dic objectForKey:@"head_url"]];
               });
                [MBProgressHUD showSuccess:@"头像更新成功"];
                NSLog(@"头像上传成功%@",[dic objectForKey:@"explain"]);
            }else{
                NSLog(@"头像上传失败%@",[dic objectForKey:@"explain"]);
                [MBProgressHUD showSuccess:@"头像更新失败"];
                _headImageView.image =[BoxManager getPictureToBoxName:@"user_head"];
            }
        
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"头像上传失败%@",error);
            
            [MBProgressHUD showError:@"头像更新失败"];
            
        }];
        
        
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        [self.headImageView setImage:image];
    }
}

// 用户取消了操作
- (void)imagePickerControllerDidCancel:(nonnull UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}




- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
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

//
//  PersonDataViewController.m
//  HuiQu
//
//  Created by Huxley on 16/10/13.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "PersonDataViewController.h"
#import "ImageManager.h"
#import "Macros.h"
#import "PersonDataTableViewCell.h"
#import "TextTool.h"
#import "MBProgressHUD+MJ.h"
#import "ChooseLocationView.h"
#import "CitiesDataTool.h"
#import <AFNetworking/AFNetworking.h>
#import <MJRefresh/MJRefresh.h>
#import "GlobalData.h"
#import "HHDataActionController.h"
#import <MJExtension/MJExtension.h>
#import "UserInfoModel.h"
#import "BoxManager.h"

#import <SDWebImage/UIImageView+WebCache.h>


#define actionURL @"http://120.77.17.190/app/appAction.php"

@interface PersonDataViewController ()<UIGestureRecognizerDelegate>
{
    CGFloat cellHeigth;
    NSMutableArray *ageArray;

}



@end

@implementation PersonDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"个人资料";
    
    [self initSubData];
    [self initSubView];
    
    
    
   
    
   
    
}






-(void)initSubData{
   NSString *user_id =  [GlobalData instanceGlobal].user_id;
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"getUserData",@"method",user_id,@"user_id", nil];
    [HHDataActionController requestAFWithURL:actionURL params:dict httpMethod:@"GET" finishBlock:^(id result) {
     UserInfoModel *userInfoModel = [UserInfoModel mj_objectWithKeyValues:result];
        
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //[BoxManager savePictureToBoxName:@"user_head" andURL:userInfoModel.user_headUrl];
            _addressLabel.text = userInfoModel.user_address;
            _sexLabel.text = userInfoModel.user_sex==1?@"男":@"女";
            _ageLabel.text = userInfoModel.user_age;
            _personSignLabel.text = userInfoModel.user_qianming;
            _nameLabel.text = userInfoModel.user_name;
            [_headerImageView sd_setImageWithURL:[NSURL URLWithString:userInfoModel.user_headUrl]];
            
        });
        
        [MBProgressHUD showSuccess:@"刷新成功"];
        [_refreshHeader endRefreshing];
        
    } errorBlock:^(NSError *error) {
        [_refreshHeader endRefreshing];
        [MBProgressHUD showError:@"刷新失败"];
        
    }];
    
    
    
   //获取个人数据
    [[CitiesDataTool sharedManager] requestGetData];
    
    
    //年龄
    ageArray = [[NSMutableArray alloc] init];
    for(int i=1; i<=100; i++) {
        [ageArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    

}

-(void)initSubView{
    
    _refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(initSubData)];
    
    
    //修改左边按钮
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[ImageManager reSizeImage:[UIImage imageNamed:@"return"] toSize:CGSizeMake(22, 22)] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemAction)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    
    //tableview
    _personDataTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-20-44) style:UITableViewStylePlain];
    _personDataTableView.delegate = self;
    _personDataTableView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;     //是否自动调整
    _personDataTableView.mj_header = _refreshHeader;
    
    //修改
    _tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 70)];
    
    _updateBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, (GetViewHeight(_tableFooterView)-42)/2, Main_Screen_Width-30, 42)];
    [_updateBtn setTitle:@"修改" forState:UIControlStateNormal];
    _updateBtn.backgroundColor = [UIColor orangeColor];
    [_updateBtn addTarget:self action:@selector(updatePersonDataAction) forControlEvents:UIControlEventTouchUpInside];
    
    [_tableFooterView addSubview:_updateBtn];
    _personDataTableView.tableFooterView =_tableFooterView;
    
    [self.view addSubview:_personDataTableView];
    
    
    
//    self.chooseLocationView.address = @"广东省 广州市 越秀区";
//    self.chooseLocationView.areaCode = @"440104";
   
    [self.view addSubview:self.cover];
    
}


-(void)leftBarButtonItemAction{

    [self.navigationController popViewControllerAnimated:YES];

}


#pragma mark 更新个人资料
-(void)updatePersonDataAction{
    
   MBProgressHUD *hud =  [MBProgressHUD showMessage:@"修改中"];
    
    if (_addressLabel.text.length ==0) {
        _addressLabel.text = @" ";
    }
    
    NSString *user_name =  _nameLabel.text;
    NSString *user_age = _ageLabel.text;
    NSString *user_sex = _sexLabel.text;
    NSString *user_address = _addressLabel.text;
    NSString *user_personSign = _personSignLabel.text;
    NSString *method = @"updateUser";
    NSString *user_id = [GlobalData instanceGlobal].user_id;
    
    user_sex = [user_sex isEqualToString:@"男"]?@"0":@"1";
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:method,@"method",user_name,@"user_name",user_age,@"user_age",user_address,@"user_address",user_personSign,@"user_personSign",user_sex,@"user_sex",user_id,@"user_id", nil];
    
    [HHDataActionController requestAFWithURL:actionURL params:dic httpMethod:@"GET" finishBlock:^(id result) {
        NSDictionary *resultDic = (NSDictionary *)result;
        NSLog(@"%@",[resultDic objectForKey:@"status"]);
        
        if ([[resultDic objectForKey:@"isUpdate"] isEqualToString:@"1"]) {
            [MBProgressHUD showSuccess:@"修改成功"];
        }else{
            [MBProgressHUD showError:@"修改失败"];
        }
        
        [hud hide:YES];
        
    } errorBlock:^(NSError *error) {
        
        [MBProgressHUD showError:@"修改失败"];
        
    }];
    


}



#pragma mark 个人资料tableview代理
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personDataCell"];
    if (cell==NULL) {
        cell = [[PersonDataTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"personDataCell"];
        
    }
    _arrowsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(Main_Screen_Width-28, 20, 24, 24)];
    [_arrowsImageView setImage:[UIImage imageNamed:@"arrows_square_right"]];
    CGFloat arrowsWidth = 28;
    NSString  *titleName =@"无";
    
        if (indexPath.row == 0) {
            _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(Main_Screen_Width-cell.cellHeight-arrowsWidth/2, 3, cell.cellHeight-6, cell.cellHeight-6)];
            _headerImageView.layer.cornerRadius = _headerImageView.frame.size.height/2;
            _headerImageView.layer.masksToBounds = YES;
            //[_headerImageView setImage:[UIImage imageNamed:@"default_head"]];
            [cell.contentView addSubview:_headerImageView];
           titleName = @"头像";
        }else if (indexPath.row == 1) {
            _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(Main_Screen_Width/2, 22, Main_Screen_Width/2-arrowsWidth, 22)];
            _nameLabel.textAlignment = NSTextAlignmentRight;
            _nameLabel.textColor = [UIColor orangeColor];
            _nameLabel.font = [UIFont systemFontOfSize:15];
            //_nameLabel.text = @"孤独浪子";
            titleName = @"昵称";
            [cell.contentView addSubview:_nameLabel];
            [cell.contentView addSubview:_arrowsImageView];
        }else if (indexPath.row == 2) {
            _ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(Main_Screen_Width/2, 22, Main_Screen_Width/2-arrowsWidth, 22)];
            _ageLabel.textAlignment = NSTextAlignmentRight;
            _ageLabel.font = [UIFont systemFontOfSize:15];
            //_ageLabel.text = @"18";
            titleName = @"年龄";
            [cell.contentView addSubview:_ageLabel];
            
        }else if (indexPath.row == 3) {
            _sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(Main_Screen_Width/2, 22, Main_Screen_Width/2-arrowsWidth, 22)];
            _sexLabel.textAlignment = NSTextAlignmentRight;
            _sexLabel.font = [UIFont systemFontOfSize:15];
            //_sexLabel.text = @"女";
            
            titleName = @"性别";
            [cell.contentView addSubview:_sexLabel];
        }else if (indexPath.row == 4) {
            _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(Main_Screen_Width/2, 22, Main_Screen_Width/2-arrowsWidth, 22)];
            _addressLabel.textAlignment = NSTextAlignmentRight;
            _addressLabel.font = [UIFont systemFontOfSize:15];
            //_addressLabel.text = @"广东 深圳 罗湖区";
           
            titleName = @"地区";
            [cell.contentView addSubview:_addressLabel];
        }else if (indexPath.row == 5) {
            UIFont *myFont = [UIFont systemFontOfSize:15];
            CGFloat textMaxWidth = Main_Screen_Width-arrowsWidth-GetViewWidth(cell.titleLabel)-10;
            CGSize textSize = [TextTool getTextSizeWithFont:@"手持大哥大，腰胯BB机，身穿大裤叉，嘴里叼玉溪。" withFont:myFont withWidth:textMaxWidth];
            _personSignLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cell.titleLabel.frame), (66-textSize.height)/2, textMaxWidth, textSize.height)];
            _personSignLabel.font = myFont;
            _personSignLabel.numberOfLines = 0;
            _personSignLabel.lineBreakMode = NSLineBreakByClipping;
            //_personSignLabel.text = @"手持大哥大，腰胯BB机，身穿大裤叉，嘴里叼玉溪。";
            titleName = @"个性签名";
            [cell.contentView addSubview:_personSignLabel];
        }
        [cell.contentView addSubview:_arrowsImageView];
    
    cellHeigth = cell.cellHeight;
    cell.titleLabel.text = titleName;
    return cell;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{


    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    
    return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    

    return 0.5;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    

    return cellHeigth;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if(indexPath.row==0) {
        [self didTapHeaderImageView];
    }else if(indexPath.row ==1){
        [self nameChangeAction];
    }else if(indexPath.row == 2){
        [self chooseAgeAction];
    }else if(indexPath.row ==3){
        [self selectUserSex];
    }else if(indexPath.row == 4){
         [self chooseLocation];
    }else if(indexPath.row==5){
        [self signChangeAction];
    }
    
    
    
    
    
    
}


#pragma  mark 修改文本框通知
-(void)alertTextFieldDidChange:(NSNotification *)notification{
    
    UITextField *textField = (UITextField *)notification.object;
    textField.text = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if(textField.text.length>0){
        _okAction.enabled = YES;
    }else{
        _okAction.enabled = NO;
    }
    
    
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
        [MBProgressHUD showSuccess:@"头像上传中"];
        [manager POST:actionURL parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            [formData appendPartWithFileData:imageData name:@"fileName" fileName:filePath mimeType:@".png"];
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
            NSLog(@"头像上传进度%lld/%lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSData *data = [[NSData alloc] initWithData:responseObject];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
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
                _headerImageView.image =[BoxManager getPictureToBoxName:@"user_head"];
            }
            
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"头像上传失败%@",error);
            
            [MBProgressHUD showError:@"头像更新失败"];
            
        }];
        
        
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        [self.headerImageView setImage:image];
    }
}

// 用户取消了操作
- (void)imagePickerControllerDidCancel:(nonnull UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}




#pragma mark 地址选择
- (void)chooseLocation{
    
    [UIView animateWithDuration:0.25 animations:^{
        self.view.transform =CGAffineTransformMakeScale(1, 1);
    }];
    self.cover.hidden = !self.cover.hidden;
    self.chooseLocationView.hidden = self.cover.hidden;
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    CGPoint point = [gestureRecognizer locationInView:gestureRecognizer.view];
    if (CGRectContainsPoint(_chooseLocationView.frame, point)){
        return NO;
    }
    return YES;
}


- (void)tapCover:(UITapGestureRecognizer *)tap{
    
    if (_chooseLocationView.chooseFinish) {
        _chooseLocationView.chooseFinish();
    }
}

- (ChooseLocationView *)chooseLocationView{
    
    if (!_chooseLocationView) {
        _chooseLocationView = [[ChooseLocationView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 350-20-44, [UIScreen mainScreen].bounds.size.width, 350)];
        
    }
    return _chooseLocationView;
}

- (UIView *)cover{
    
    if (!_cover) {
        _cover = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-20-44)];
        _cover.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        [_cover addSubview:self.chooseLocationView];
        __weak typeof (self) weakSelf = self;
        _chooseLocationView.chooseFinish = ^{
            [UIView animateWithDuration:0.25 animations:^{
                weakSelf.addressLabel.text = weakSelf.chooseLocationView.address;
                weakSelf.view.transform = CGAffineTransformIdentity;
                weakSelf.cover.hidden = YES;
            }];
        };
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCover:)];
        [_cover addGestureRecognizer:tap];
        tap.delegate = self;
        _cover.hidden = YES;
    }
    return _cover;
}



#pragma mark 昵称修改
-(void)nameChangeAction{
    NSString *nameValue = _nameLabel.text;
    
    __block PersonDataViewController *blockSelf = self;
    _alertController = [UIAlertController alertControllerWithTitle:@"昵称" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [_alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = [NSString stringWithFormat:@"请输入昵称"];
        textField.text = nameValue;
        [[NSNotificationCenter defaultCenter] addObserver:blockSelf selector:@selector(alertTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
    }];
    
    _okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField =  _alertController.textFields.firstObject;
        _nameLabel.text = textField.text;
        [[NSNotificationCenter defaultCenter] removeObserver:blockSelf name:UITextFieldTextDidChangeNotification object:textField];
    }];
    
    _noAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField =  _alertController.textFields.firstObject;
        [[NSNotificationCenter defaultCenter] removeObserver:blockSelf name:UITextFieldTextDidChangeNotification object:textField];
    }];
    
    [_alertController addAction:_okAction];
    [_alertController addAction:_noAction];
    
    
    [self presentViewController:_alertController animated:YES completion:nil];


}


#pragma mark 选择年龄
-(void)chooseAgeAction{
    
    _agePickControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-20-44)];
    _agePickControl.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    _agePickControl.hidden = NO;
    
    //
    _noPickerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, GetViewHeight(_agePickControl)-40, Main_Screen_Width/2, 40)];
    _okPickerButton= [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_noPickerButton.frame),GetViewY(_noPickerButton), Main_Screen_Width/2, GetViewHeight(_noPickerButton))];
    [_noPickerButton setTitle:@"取消" forState:UIControlStateNormal];
    [_okPickerButton setTitle:@"确定" forState:UIControlStateNormal];
    _noPickerButton.backgroundColor = [UIColor orangeColor];
    _okPickerButton.backgroundColor = [UIColor orangeColor];
    [_noPickerButton addTarget:self action:@selector(ageNoSelectAction) forControlEvents:UIControlEventTouchUpInside];
    [_okPickerButton addTarget:self action:@selector(ageYesSelectAction) forControlEvents:UIControlEventTouchUpInside];
    [_okPickerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_okPickerButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [_noPickerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_noPickerButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    
    
    //
    _agePickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, GetViewHeight(_agePickControl)-200-GetViewHeight(_noPickerButton), Main_Screen_Width, 200)];
    _agePickerView.delegate = self;
    _agePickerView.dataSource = self;
    _agePickerView.showsSelectionIndicator = YES;
    [_agePickerView selectRow:[_ageLabel.text integerValue]-1 inComponent:0 animated:YES];
    _agePickerView.backgroundColor = [UIColor whiteColor];
    _agePickerView.alpha = 0.9;
    
    
    [self.view addSubview:_agePickControl];
    [_agePickControl addSubview:_agePickerView];
    [_agePickControl addSubview:_okPickerButton];
    [_agePickControl addSubview:_noPickerButton];

}

//年龄选择取消
-(void)ageNoSelectAction{
    _agePickControl.hidden = YES;



}


//年龄选择确定
-(void)ageYesSelectAction{
    _agePickControl.hidden = YES;
    
    _ageLabel.text = [NSString stringWithFormat:@"%ld",[_agePickerView selectedRowInComponent:0]+1];

}



#pragma mark 签名修改
-(void)signChangeAction{
    NSString *signValue = _personSignLabel.text;
    
    _alertController = [UIAlertController alertControllerWithTitle:@"签名" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [_alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = [NSString stringWithFormat:@"请输入签名"];
        textField.text = signValue;
    }];
    
    _okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField =  _alertController.textFields.firstObject;
        _personSignLabel.text = textField.text;
    }];
    
    _noAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [_alertController addAction:_okAction];
    [_alertController addAction:_noAction];
    
    
    [self presentViewController:_alertController animated:YES completion:nil];


}


#pragma mark 性别选择
-(void)selectUserSex{
    _sexAlertController = [UIAlertController alertControllerWithTitle:@"性别" message:@"请选择" preferredStyle:UIAlertControllerStyleActionSheet];
    
    _sexCancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    _manAction = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _sexLabel.text = @"男";
    }];
    
    _womanAction = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         _sexLabel.text = @"女";
    }];
    
    
    [_sexAlertController addAction:_manAction];
    [_sexAlertController addAction:_womanAction];
    [_sexAlertController addAction:_sexCancelAction];

    [self presentViewController:_sexAlertController animated:YES completion:nil];
}



#pragma mark 选择年龄数据源
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    
    
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    return ageArray.count;
}



-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    NSString *title = [ageArray objectAtIndex:row];

    return title;
}



-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{


    return 100;
}


-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{

    return 50;
}







-(void)didReceiveMemoryWarning {
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

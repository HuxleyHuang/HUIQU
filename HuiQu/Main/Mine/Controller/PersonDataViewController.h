//
//  PersonDataViewController.h
//  HuiQu
//
//  Created by Huxley on 16/10/13.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChooseLocationView;

@class MJRefreshHeader;

@interface PersonDataViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>


typedef NS_ENUM(NSInteger,HQUserInfoSex){
    HQUserInfoSexMan,
    HQUserInfoSexWoman

};

/** tableview */
@property (strong, nonatomic) UITableView *personDataTableView;
@property (strong, nonatomic) UIView *tableFooterView;
@property (strong, nonatomic) UIButton *updateBtn;

/** section == 0 */
@property (strong, nonatomic) UIImageView *headerImageView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UIImageView *QRCodeImageView;


/** section == 1 */
@property (strong, nonatomic) UILabel *ageLabel;
@property (strong, nonatomic) UILabel *sexLabel;
@property (strong, nonatomic) UILabel *addressLabel;
@property (strong, nonatomic) UILabel *personSignLabel;


/** 个人资料数据源  **/
@property (strong, nonatomic) NSDictionary *personDic;


/** 小箭头 */
@property (strong, nonatomic) UIImageView *arrowsImageView;


/** 修改资料 弹框 */
@property (strong, nonatomic) UIAlertController *alertController;
@property (strong, nonatomic) UIAlertAction *okAction;
@property (strong, nonatomic) UIAlertAction *noAction;


/** 地址选择 */
@property (nonatomic,strong) ChooseLocationView *chooseLocationView;
@property (nonatomic,strong) UIView  *cover;


/** 当前地址*/
@property (nonatomic,strong) UILabel *currAddress;


/** 性别选择 */
@property(nonatomic, strong) UIAlertController *sexAlertController;
@property(nonatomic, strong) UIAlertAction *womanAction;
@property(nonatomic, strong) UIAlertAction *manAction;
@property(nonatomic, strong) UIAlertAction *sexCancelAction;


/** 年龄选择 */
@property(strong, nonatomic) UIPickerView *agePickerView;
@property(strong, nonatomic) UIButton *okPickerButton;
@property(strong, nonatomic) UIButton *noPickerButton;
@property(strong, nonatomic) UIControl *agePickControl;



/** 下拉刷新 */
@property(strong, nonatomic) MJRefreshHeader *refreshHeader;



/** 下载头像 */



@end

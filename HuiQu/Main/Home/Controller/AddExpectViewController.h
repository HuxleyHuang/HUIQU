//
//  AddExpectViewController.h
//  HuiQu
//
//  Created by Huxley on 16/11/29.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UWDatePickerView.h"

@interface AddExpectViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UWDatePickerViewDelegate>

@property(strong, nonatomic) UITableView *addTableView;

@property(strong, nonatomic) UIView *tableFooterView;


@property(assign, nonatomic) CGFloat cellHeight;

@property(strong, nonatomic) UIButton *addButton;




//cell content
/** 期数号 */
@property(strong, nonatomic) UILabel *numberLabel;

@property(strong, nonatomic) UILabel *castBeginLabel;

@property(strong, nonatomic) UILabel *castStopLabel;

@property(strong, nonatomic) UILabel *takeBeginLabel;

@property(strong, nonatomic) UILabel *takeStopLabel;

@property(strong, nonatomic) UILabel *liveBeginLabel;

@property(strong, nonatomic) UILabel *liveStopLabel;

@property(strong, nonatomic) UILabel *openStatusLabel;



/** 时间选择 */
@property(strong, nonatomic) UWDatePickerView *pickerView;

/**遮罩*/
@property(strong, nonatomic) UIControl *coverControl;




@end

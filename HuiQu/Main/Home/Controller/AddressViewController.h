//
//  AddressViewController.h
//  HuiQu
//
//  Created by Huxley on 16/10/12.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChooseLocationView;

@interface AddressViewController : UIViewController<NSURLSessionDelegate,UIGestureRecognizerDelegate>

@property (strong, nonatomic) UISearchBar *searchBar;

@property (nonatomic,strong) ChooseLocationView *chooseLocationView;
@property (nonatomic,strong) UIView  *cover;

@property (strong, nonatomic)  UILabel *addresslabel;

@property(strong, nonatomic) UIButton *addressBtn;

@property(strong, nonatomic) UILabel *currAddress;
@property(strong, nonatomic) UILabel *currAddressLabel;

@end

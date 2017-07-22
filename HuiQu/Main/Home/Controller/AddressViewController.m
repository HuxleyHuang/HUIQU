//
//  AddressViewController.m
//  HuiQu
//
//  Created by Huxley on 16/10/12.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "AddressViewController.h"
#import "Macros.h"
#import "CALayer+layer.h"
#import "ChooseLocationView.h"
#import "CitiesDataTool.h"
#import "TextTool.h"
#import "DrawBorder.h"

@interface AddressViewController()

@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubData];
    [self initSubView];
    
}

-(void)initSubData{
    [[CitiesDataTool sharedManager] requestGetData];
}


-(void)initSubView{
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 30)];
    _searchBar.barStyle = UIBarStyleDefault;
    _searchBar.placeholder = @"请输入要搜索的城市";
    //_searchBar.showsCancelButton = YES;
    //_searchBar.showsSearchResultsButton = YES;
    
    UIView *currView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_searchBar.frame)+15, Main_Screen_Width, 50)];
    CALayer *topLayer =  [DrawBorder boderLayerWithView:currView.frame andBorderColor:[UIColor grayColor] andSiteType:DrawBorderSiteTop];
    CALayer *buttonLayer = [DrawBorder boderLayerWithView:currView.frame andBorderColor:[UIColor grayColor] andSiteType:DrawBorderSiteBottom];
    [currView.layer addSublayer:buttonLayer];
    [currView.layer addSublayer:topLayer];
    
    
    
    
    UIFont *sizeFont = [UIFont systemFontOfSize:16];
    CGSize size = [TextTool getTextSizeWithFont:@"当前城市:" withFont:sizeFont];
    _currAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,5, size.width, 40)];
    _currAddress = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_currAddressLabel.frame), 5, Main_Screen_Width-GetViewWidth(_currAddressLabel), 40)];
    _currAddress.font = sizeFont;
    _currAddressLabel.font = sizeFont;
    
    _currAddressLabel.text = @"当前城市:";
    _currAddress.text = @"请选择";
    
    CGSize btnSize = [TextTool getTextSizeWithFont:@"重新选择" withFont:sizeFont];
    
    _addressBtn = [[UIButton alloc] initWithFrame:CGRectMake(Main_Screen_Width-btnSize.width-5, 5, btnSize.width, 40)];
    _addressBtn.titleLabel.font = sizeFont;
    [_addressBtn setTitle:@"选择地区" forState:UIControlStateNormal];
    [_addressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_addressBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [_addressBtn addTarget:self action:@selector(chooseLocation:) forControlEvents:UIControlEventTouchUpInside];
    [_addressBtn setBackgroundColor:[UIColor orangeColor]];
    
    
    self.chooseLocationView.address = @"广东省 广州市 越秀区";
    self.chooseLocationView.areaCode = @"440104";
    
    
    [self.view addSubview:_searchBar];
    
    [currView addSubview:_addressBtn];
    [currView addSubview:_currAddressLabel];
    [currView addSubview:_currAddress];
    [self.view addSubview:currView];
    [self.view addSubview:self.cover];
}

- (void)chooseLocation:(id)sender {
    
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
        _chooseLocationView = [[ChooseLocationView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 350, [UIScreen mainScreen].bounds.size.width, 350)];
        
    }
    return _chooseLocationView;
}

- (UIView *)cover{
    
    if (!_cover) {
        _cover = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _cover.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        [_cover addSubview:self.chooseLocationView];
        __weak typeof (self) weakSelf = self;
        _chooseLocationView.chooseFinish = ^{
            [UIView animateWithDuration:0.25 animations:^{
                weakSelf.currAddress.text = weakSelf.chooseLocationView.address;
                weakSelf.view.transform = CGAffineTransformIdentity;
                weakSelf.cover.hidden = YES;
            }];
        };
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCover:)];
        [_cover addGestureRecognizer:tap];
        tap.delegate = self;
        _cover.hidden = YES;
    }
    return _cover;
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

//
//  HQHomeViewController.h
//  HuiQu
//
//  Created by Huxley on 16/10/9.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddressViewController;
@class WebAdvertViewController;
@class WebMusicViewController;
@class WebTVViewController;
@class WebNBAViewController;
@class WebMovieViewController;
@class WebGameViewController;
@class RandomAwardViewController;
@class GameViewController;
@class AddExpectViewController;
@class HQLiveViewController;
@interface HQHomeViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UIView *navView;

@property (strong, nonatomic) UIView *imageScorll;

@property (strong, nonatomic) UIBarButtonItem *homeBarItem;

@property (strong, nonatomic) UIBarButtonItem *liveBarItem;

@property (strong, nonatomic) UIBarButtonItem *turntable;

@property (strong, nonatomic) UIImageView *gameImageView;

@property (strong, nonatomic) UIImageView *dzpImageView;

@property (strong, nonatomic) UIImageView *liveImageView;

@property (strong, nonatomic) UIView *gameTopView;

@property (strong, nonatomic) UIView *scrollGrayView;

@property (strong, nonatomic) UIView *gameGrayView;

@property (strong, nonatomic) UIView *ddzExplainView;

@property (strong, nonatomic) UIScrollView *globalScrollView;

@property UICollectionViewController *collectionViewController;

@property UICollectionView *collectionView;

@property (strong, nonatomic) UITableView *movieTableView;

@property (nonatomic, strong) NSIndexPath *currentIndexPath;

@property (nonatomic, strong) UIView *musicTopView;

@property (nonatomic, strong) UIView *musicGrayView;

@property (nonatomic, strong) UIToolbar *navToolBar;


@property(nonatomic, strong) AddressViewController *addressViewController;

@property(nonatomic, strong) WebAdvertViewController *advertViewController;

@property(strong, nonatomic) WebMusicViewController *musicViewController;

@property(strong, nonatomic) WebMovieViewController *movieViewController;

@property(strong, nonatomic) WebNBAViewController *nbaViewController;

@property(strong, nonatomic) WebTVViewController *tvViewController;

@property(strong, nonatomic) WebGameViewController *gameViewController;

@property(strong, nonatomic) RandomAwardViewController *radomAwardViewController;

@property(strong, nonatomic) WebGameViewController *ddzGameViewController;

@property(strong, nonatomic) AddExpectViewController *addExpectViewController;


@property(strong, nonatomic) HQLiveViewController *liveViewController;

-(void)addressSelect;

@end

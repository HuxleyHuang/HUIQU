//  HQLiveViewController.h
//  HuiQu
//
//  Created by Huxley on 16/12/2.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AliyunPlayerSDK/AliyunPlayerSDK.h>

@class MJRefreshHeader;
@class LiveItemModel;

@interface HQLiveViewController : UIViewController


@property(strong, nonatomic) UIScrollView *scrollView;

/** 用户权限级别 */
typedef NS_ENUM(NSInteger,HQUserAuthRank){
    HQUserRankIsManager=0,
    HQUserRankIsCommon,
    HQUserRankIsUnKnown
};


//刷新
@property(strong, nonatomic) MJRefreshHeader *refreshHeader;


/** 控件 */
/** 播放器 */
@property(strong, nonatomic) AliVcMediaPlayer *player;

/** 进度 */
@property(strong, nonatomic) UISlider *player_slider;



/** 直播列表数据源 */
@property(nonatomic, strong) NSMutableArray<LiveItemModel *> *lives;

/** 直播列表 */
@property(nonatomic,strong) UITableView *tableView;


@property(strong, nonatomic) UIButton *beginLiveButton;


@property(copy, nonatomic) NSString *pushUrl;

@property(copy, nonatomic) NSString *playUrl;

@property(strong, nonatomic) UIButton *beginPlayButton;



//直播预览图
@property(strong, nonatomic) UIImageView *videoPreviewImageView;


//用户级别
@property(assign, nonatomic) HQUserAuthRank userAuthRank;


//数据
@property(nonatomic,retain) NSMutableDictionary *videolists;
@property(nonatomic,retain) NSArray *datasource;


/** 弹框 */
@property(nonatomic, strong) UIAlertController *alertController;
@property(nonatomic, strong) UIAlertAction *alertAction;



-(NSArray *)getFilenamelistOfType:(NSString *)type fromDirPath:(NSString *)dirPath;
-(BOOL)isFileExistAtPath:(NSString*)fileFullPath;

@end

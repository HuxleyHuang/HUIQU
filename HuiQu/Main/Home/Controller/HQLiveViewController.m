//
//  HQLiveViewController.m
//  HuiQu
//
//  Created by Huxley on 16/12/2.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "HQLiveViewController.h"

#import "AlivcLiveViewController.h"
#import "AliVcMoiveViewController.h"

#import <AliyunPlayerSDK/AliVcMediaPlayer.h>
#import "VideoManager.h"
#import "ColorManager.h"
#import "MBProgressHUD+MJ.h"
#import "HHDataActionController.h"
#import "GlobalData.h"


#import <MJRefresh/MJRefresh.h>
#import "LiveListCell.h"
#import "CreatorItemModel.h"
#import "LiveItemModel.h"
#import <MJExtension/MJExtension.h>
#import <AFNetworking/AFNetworking.h>
#import "LivePlayViewController.h"
#import "Macros.h"

#define actionURL  @"http://hygo58.com/live/liveClient.php"

#define liveIdentifier @"liveListCell"

@interface HQLiveViewController ()<AliVcAccessKeyProtocol,UITableViewDataSource,UITableViewDelegate>


@end

@implementation HQLiveViewController
@synthesize videolists,datasource;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"直播间";
    // Do any additional setup after loading the view from its nib.
//    _pushUrl =@"rtmp://video-center.alivecdn.com/HUIQU/1481694864?vhost=live.hygo58.com&auth_key=1482299248-0-0-171596cdb2ed23803f7ca77944b46b7b";
//    _playUrl = @"http://live.hygo58.com/HUIQU/1481694864.flv?auth_key=1482299248-0-0-a8773fd62dc75593a754e2c32a08465f";
//    _playUrl = @"http://hygo58.com/live/yy.mp4";
    
    _userAuthRank = HQUserRankIsCommon;
    
    [AliVcMediaPlayer setAccessKeyDelegate:self];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 加载数据
    [self layoutUI];
    [self loadData];
    
    
    
    
    
    
    
    

    
    
}






#pragma mark 初始化子视图
-(void)layoutUI{
    
    
    
    //不同身份进入不同视图
    //管理员用户
    if(_userAuthRank==HQUserRankIsManager){
        [self managerLayoutUI];
    //普通用户
    }else if(_userAuthRank==HQUserRankIsCommon){
        [self commonLayoutUI];
    //未知用户
    }else{
        
    }
    
    
    
    

    
}


#pragma mark 管理员视图
-(void)managerLayoutUI{
    _refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-20-44)];
    _scrollView.contentSize = CGSizeMake(Main_Screen_Width, Main_Screen_Height-20-44);
    _scrollView.mj_header = _refreshHeader;
    
    _beginLiveButton = [[UIButton alloc] initWithFrame:CGRectMake(GetViewWidth(_scrollView)/2-120/2, 40, 120, 32)];
    _beginLiveButton.backgroundColor = [UIColor orangeColor];
    [_beginLiveButton setTitle:@"开始直播" forState:UIControlStateNormal];
    [_beginLiveButton addTarget:self action:@selector(liveAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.scrollView addSubview:_beginLiveButton];
    [self.view addSubview:self.scrollView];
}


#pragma mark 普通用户视图
-(void)commonLayoutUI{
    _refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-20-44) style:UITableViewStylePlain];
    _tableView.mj_header = _refreshHeader;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    

}



- (NSArray *)getFilenamelistOfType:(NSString *)type fromDirPath:(NSString *)dirPath
{
    NSMutableArray *filenamelist = [NSMutableArray arrayWithCapacity:10];
    NSArray *tmplist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dirPath error:nil];
    
    for (NSString *filename in tmplist) {
        NSString *fullpath = [dirPath stringByAppendingPathComponent:filename];
        if ([self isFileExistAtPath:fullpath]) {
            if ([[filename pathExtension] isEqualToString:type]) {
                [filenamelist  addObject:filename];
            }
        }
    }
    
    return filenamelist;
}

- (BOOL)isFileExistAtPath:(NSString*)fileFullPath {
    BOOL isExist = NO;
    isExist = [[NSFileManager defaultManager] fileExistsAtPath:fileFullPath];
    return isExist;
}


- (void)loadLocalVideo
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [pathArray objectAtIndex:0];
    
    NSMutableArray* video_extension = [[NSMutableArray alloc] init];
    [video_extension addObject:@"mp4"];
    [video_extension addObject:@"mkv"];
    [video_extension addObject:@"rmvb"];
    [video_extension addObject:@"rm"];
    [video_extension addObject:@"avs"];
    [video_extension addObject:@"mpg"];
    [video_extension addObject:@"3g2"];
    [video_extension addObject:@"asf"];
    [video_extension addObject:@"mov"];
    [video_extension addObject:@"avi"];
    [video_extension addObject:@"wmv"];
    [video_extension addObject:@"flv"];
    [video_extension addObject:@"m4v"];
    [video_extension addObject:@"swf"];
    [video_extension addObject:@"webm"];
    [video_extension addObject:@"3gp"];
    
    for(NSString* ext in video_extension) {
        
        NSArray *filename = [self getFilenamelistOfType:ext
                                            fromDirPath:docDir];
        
        for (NSString* name in filename) {
            
            NSMutableString* fullname = [NSMutableString stringWithString:docDir];
            [fullname appendString:@"/"];
            [fullname appendString:name];
            
            [videolists setObject:fullname forKey:name];
        }
    }
    
    datasource = [videolists allKeys];
}

- (void)loadRemoteVideo
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [pathArray objectAtIndex:0];
    NSString *videolistPath = [docDir stringByAppendingFormat:@"/videolist.txt"];
    FILE *file = fopen([videolistPath UTF8String], "rb");
    if(file == NULL)
    return;
    
    char VideoPath[200] = {0};
    fgets(VideoPath, 200, file);
    
    do{
        VideoPath[strlen(VideoPath)] = '\0';
        NSString *srcFile = [NSString stringWithUTF8String:VideoPath];
        
        NSRange range1 = [srcFile rangeOfString:@"["];
        NSRange range2 = [srcFile rangeOfString:@"]"];
        if(range1.location == NSNotFound || range2.location == NSNotFound)
        continue;
        NSRange rangeName;
        rangeName.location = range1.location+1;
        rangeName.length = range2.location-range1.location-1;
        NSString* filename = [srcFile substringWithRange:rangeName];
        
        NSRange range;
        range = [srcFile rangeOfString:@"http:"];
        if(range.location == NSNotFound){ //m3u8
            range = [srcFile rangeOfString:@"rtmp:"];
            if(range.location == NSNotFound){ //rtmp
                continue;
            }
        }
        
        NSString* m3u8file = [srcFile substringFromIndex:range.location];
        NSRange rangeEnd = [srcFile rangeOfString:@"\n"];
        if(rangeEnd.location != NSNotFound) {
            rangeEnd.location = 0;
            rangeEnd.length = m3u8file.length-1;
            m3u8file = [m3u8file substringWithRange:rangeEnd];
        }
        rangeEnd = [srcFile rangeOfString:@"\r"];
        if(rangeEnd.location != NSNotFound) {
            rangeEnd.location = 0;
            rangeEnd.length = m3u8file.length-1;
            m3u8file = [m3u8file substringWithRange:rangeEnd];
        }
        
        [videolists setObject:m3u8file forKey:filename];
        
        
    }while (fgets(VideoPath, 200, file));
    
    fclose(file);
}


//添加地址到视频播放列表中
//按照如下格式进行添加
-(void) addVideoToList
{
    [videolists setObject:@"http://live.hygo58.com/HUIQU/1480909526.flv?auth_key=1480912822-0-0-19ff809b1b556d7d47fdc1c358c72c52" forKey:@"keykey"];
}





-(AliVcAccesskey *)getAccessKeyIDSecret{
    NSString* accessKeyID = @"LTAISQhQgjvEKy54";
    NSString* accessKeySecret = @"fKIfZokf74d17mZGmJFyh4CL0bNezD";
    
    AliVcAccesskey* accessKey = [[AliVcAccesskey alloc] init];
    accessKey.accessKeyId = accessKeyID;
    accessKey.accessKeySecret = accessKeySecret;
    
    return accessKey;
}




//播放开启
-(void)playAction{
    TBMoiveViewController *moiveController = [[TBMoiveViewController alloc] init];
    NSURL *url = [NSURL URLWithString:_playUrl];
    [moiveController setBarHeight:30];
    [moiveController SetMoiveSource:url];
    
    [self presentViewController:moiveController animated:YES completion:nil];
}

//直播开启
-(void)liveAction{
    
    AlivcLiveViewController *live = [[AlivcLiveViewController alloc] initWithNibName:@"AlivcLiveViewController" bundle:nil url:self.pushUrl];
    live.isScreenHorizontal = NO;
    [self presentViewController:live animated:YES completion:nil];
    
    
////    1.初始化config配置类
//    AlivcLConfiguration *configuration = [[AlivcLConfiguration alloc] init];
////    2. 设置推流地址
//    configuration.url =_pushUrl;
////    3. 设置最大码率
//    configuration.videoMaxBitRate = 1500 * 1000;
////    4. 设置当前视频码率
//    configuration.videoBitRate = 600 * 1000;
////    5. 设置最小码率
//    configuration.videoMinBitRate = 400 * 1000;
////    6. 设置音频码率
//    configuration.audioBitRate = 64 * 1000;
////    7. 设置直播分辨率
//    configuration.videoSize = CGSizeMake(360, 640);
////    8. 设置横屏or竖屏
//    configuration.screenOrientation = AlivcLiveScreenVertical;
////    9. 设置帧率
//    configuration.fps = 20;
////    10. 设置摄像头采集质量
//    configuration.preset = AVCaptureSessionPresetiFrame1280x720;
////    11. 设置前置摄像头或后置摄像头
//    configuration.position = AVCaptureDevicePositionFront;
////    12.设置水印图片
//    configuration.waterMaskImage = [UIImage imageNamed:@"watermask"];
////    13.设置水印位置
//    configuration.waterMaskLocation = 1;
////    14.设置水印相对x边框距离
//    configuration.waterMaskMarginX = 10;
////    15.设置水印相对y边框距离
//    configuration.waterMaskMarginY = 10;
////    16.设置重连超时时长
//    configuration.reconnectTimeout = 5;
//    
//    
//    
////    二.创建直播session
////    1.初始化liveSession类
//    _liveSession = [[AlivcLiveSession alloc] initWithConfiguration:configuration];
////    2.设置session代理
//    _liveSession.delegate = self;
////    3.开启直播预览
//    [_liveSession alivcLiveVideoStartPreview];
////    4.开启直播
//    [_liveSession alivcLiveVideoConnectServer];
////    5.获取直播预览视图
//    [_liveSession previewView];
////    可将获取的直播视图添加到当前控制器上，实现直播预览功能。
////    6.停止预览
//    //[_liveSession alivcLiveVideoStopPreview];
////    注意：停止预览后将liveSession置为nil
////    7.关闭直播
//    //[_liveSession alivcLiveVideoDisconnectServer];
////    8.设置闪光灯模式
//    _liveSession.torchMode = AVCaptureTorchModeOn;//关闭AVCaptureTorchModeOff
////    9.开启美颜
//    [_liveSession setEnableSkin:YES];
////    10.缩放
//    [_liveSession alivcLiveVideoZoomCamera:1.0f];
////    11.聚焦
//    [_liveSession alivcLiveVideoFocusAtAdjustedPoint:CGPointMake(Main_Screen_Width/2, Main_Screen_Height/2) autoFocus:YES];
////    12.调试信息
//    AlivcLDebugInfo *i = [_liveSession dumpDebugInfo];
//    
//    NSLog(@"%lld",i.pushSize);
//   
//    

}





#pragma mark 直播列表
- (void)loadData
{
    
    NSString *user_id = [GlobalData instanceGlobal].user_id;
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"getURL",@"method",user_id,@"live_user_id",@"1",@"live_type", nil];
    
    [HHDataActionController requestAFWithURL:actionURL params:dic httpMethod:@"GET" finishBlock:^(id result) {
        [_refreshHeader endRefreshing];
        [MBProgressHUD  showSuccess:@"请求成功"];
        NSDictionary *requestDic = (NSDictionary *)result;
        NSLog(@"%@---%@",[requestDic objectForKey:@"live_play_url"],[requestDic objectForKey:@"live_push_url"]);
        _playUrl = [requestDic objectForKey:@"live_play_url"];
        _pushUrl = [requestDic objectForKey:@"live_push_url"];
        
        
    } errorBlock:^(NSError *error) {
        [_refreshHeader endRefreshing];
        NSLog(@"%@",error);
        [MBProgressHUD  showError:@"获取数据失败"];
        [self showAlertTitle:@"提示" andMessage:@"获取数据失败"];
        
    }];
    
    
    
    //管理员数据
    if (_userAuthRank==HQUserRankIsManager) {
       //
        
    //普通用户数据
    }else if(_userAuthRank==HQUserRankIsCommon){
        
        
        // 映客数据url
        NSString *urlStr = @"http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1";
        
        // 请求数据
        AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
        mgr.responseSerializer = [AFJSONResponseSerializer serializer];
        mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
        [mgr GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
            [_refreshHeader endRefreshing];
            
            _lives = [LiveItemModel mj_objectArrayWithKeyValuesArray:responseObject[@"lives"]];
            
            LiveItemModel *liveModel =  [_lives objectAtIndex:0];
            liveModel.stream_addr = _playUrl;
            liveModel.creator.nick = @"官方直播";
            liveModel.city = @"广东深圳";
            liveModel.creator.portrait = @"http://hygo58.com/live/Live_pre.png";
            
            [_lives replaceObjectAtIndex:0 withObject:liveModel];
            
            [self.tableView reloadData];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [_refreshHeader endRefreshing];
            NSLog(@"%@",error);
            
        }];
    }
    
    
    
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _lives.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    [tableView registerNib:[UINib nibWithNibName:@"LiveListCell" bundle:nil] forCellReuseIdentifier:liveIdentifier];
    
    LiveListCell *cell = [tableView dequeueReusableCellWithIdentifier:liveIdentifier];
    
    
    cell.live = _lives[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LivePlayViewController *liveVc = [[LivePlayViewController alloc] init];
    liveVc.live = _lives[indexPath.row];
    
    [self presentViewController:liveVc animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 430;
}






#pragma mark 弹框提示
-(void)showAlertTitle:(NSString *)title andMessage:(NSString *)message{

    _alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    _alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    
    [_alertController addAction:_alertAction];
    
    [self presentViewController:_alertController animated:YES completion:nil];
    
    
}






#pragma mark 横竖屏切换
- (void)viewWillLayoutSubviews{
    
    [self _shouldRotateToOrientation:(UIDeviceOrientation)[UIApplication sharedApplication].statusBarOrientation];
    
}

-(void)_shouldRotateToOrientation:(UIDeviceOrientation)orientation {
    
    if(orientation == UIDeviceOrientationLandscapeLeft || orientation==UIDeviceOrientationLandscapeRight){
        _tableView.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-32);
    }else if(orientation==UIDeviceOrientationPortrait || orientation== UIDeviceOrientationPortraitUpsideDown){
        _tableView.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-20-44);
    }
    
    
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

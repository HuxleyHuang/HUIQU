//
//  HQHomeViewController.m
//  HuiQu
//
//  Created by Huxley on 16/10/9.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "HQHomeViewController.h"

#import "ImageManager.h"
#import "Macros.h"
#import "ImageScroll.h"
#import "UIImage+Image.h"

#import "MovieModel.h"
#import "MusicModel.h"
#import "GlobalData.h"


#import "GameView.h"
#import "HomeTableViewCell.h"
#import "HomeCollectionViewCell.h"

#import "AddressViewController.h"
#import "WebAdvertViewController.h"
#import "WebMusicViewController.h"
#import "WebTVViewController.h"
#import "WebNBAViewController.h"
#import "WebGameViewController.h"
#import "WebMovieViewController.h"
#import "RandomAwardViewController.h"
#import "GameViewController.h"
#import "H5GameViewController.h"
#import "AddExpectViewController.h"
#import "HQLiveViewController.h"


#import "SKViewController.h"

@interface HQHomeViewController ()
{
    //数据源
    NSArray *scrollImgs;
    NSArray *scrollImgUrls;
    NSArray *movieArray;
    NSArray *musicArray;
    CGFloat movieTableCellHeight;
}


@end

@implementation HQHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    
    [self initSubData];
    [self initSubView];
    
    
    
    
}


                                                                                                                                                       
-(void)addressSelect{
    _addressViewController = [[AddressViewController alloc] init];
    [self.navigationController pushViewController:_addressViewController animated:YES];
}



-(void)initSubView{
    //头部
    UIImage *img =  [UIImage imageNamed:@"logo"];
    UIImage *logoImg = [ImageManager reSizeImage: img toSize:CGSizeMake(75, 38)];
    UIBarButtonItem  *leftLogoBarButton  = [[UIBarButtonItem alloc] initWithImage:logoImg style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem =leftLogoBarButton;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"深圳" style:UIBarButtonItemStylePlain target:self action:@selector(addressSelect)];
    
    //全局滚动图
    _globalScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Fact_Screen_Height)];
    _globalScrollView.backgroundColor = [UIColor whiteColor];
    _globalScrollView.contentSize = CGSizeMake(Main_Screen_Width, Fact_Screen_Height);
    _globalScrollView.showsVerticalScrollIndicator = NO;
    _globalScrollView.showsHorizontalScrollIndicator = NO;
    //导航按钮列表
    _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 40)];
    _navToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, (GetViewHeight(_navView)-40)/2, Main_Screen_Width, 40)];
    UIBarButtonItem *gameItem = [[UIBarButtonItem alloc] initWithTitle:@"游戏" style:UIBarButtonItemStylePlain target:self action:@selector(goGameAction)];
    UIBarButtonItem *videoItem = [[UIBarButtonItem alloc] initWithTitle:@"视频" style:UIBarButtonItemStylePlain target:self action:@selector(goVideoAction)];
    UIBarButtonItem *musicItem = [[UIBarButtonItem alloc] initWithTitle:@"音乐" style:UIBarButtonItemStylePlain target:self action:@selector(goMusicAction)];
    UIBarButtonItem *liveItem = [[UIBarButtonItem alloc] initWithTitle:@"电影/电视" style:UIBarButtonItemStylePlain target:self action:@selector(goLiveAction)];
    UIBarButtonItem *nbaItem = [[UIBarButtonItem alloc] initWithTitle:@"NBA" style:UIBarButtonItemStylePlain target:self action:@selector(goNBAAction)];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    _navToolBar.clipsToBounds = YES;
    
    NSDictionary *textAttrDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor orangeColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:17 weight:1],NSFontAttributeName, nil];
    
    //添加通知修改文本属性
    [gameItem setTitleTextAttributes: textAttrDic forState:UIControlStateNormal];
    [videoItem setTitleTextAttributes: textAttrDic forState:UIControlStateNormal];
    [musicItem setTitleTextAttributes: textAttrDic forState:UIControlStateNormal];
    [liveItem setTitleTextAttributes: textAttrDic forState:UIControlStateNormal];
    [nbaItem setTitleTextAttributes: textAttrDic forState:UIControlStateNormal];
    
    
    
    [_navToolBar setItems:@[spaceItem,gameItem,spaceItem,videoItem,spaceItem,musicItem,spaceItem,liveItem,spaceItem,nbaItem,spaceItem] animated:YES];
    
    
    
    //轮播图
   _imageScorll = [ImageScroll ShowNetWorkImageScrollWithFream:CGRectMake(0, CGRectGetMaxY(_navView.frame), Main_Screen_Width, 165) andImageArray:scrollImgs andBtnClick:^(NSInteger tagValue) {
        NSString *urlStr =  scrollImgUrls[tagValue];
        _advertViewController = [[WebAdvertViewController alloc] init];
        _advertViewController.urlStr = urlStr;
        [self.navigationController pushViewController:_advertViewController animated:YES];

    }];
    
    //描述视图(斗地主)
    _ddzExplainView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_imageScorll.frame), Main_Screen_Width, 33)];
    UILabel *ddzExplainLabel = [[UILabel alloc] initWithFrame:CGRectMake((Main_Screen_Width-120)/2, (GetViewHeight(_ddzExplainView)-25)/2, 120, 25)];
    ddzExplainLabel.text = @"欢乐斗地主";
    ddzExplainLabel.textAlignment = NSTextAlignmentCenter;
    ddzExplainLabel.textColor = [UIColor orangeColor];
    ddzExplainLabel.font = [UIFont systemFontOfSize:18 weight:3];
    
    
    //斗地主图片
    _gameImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_ddzExplainView.frame), Main_Screen_Width, 220)];
    _gameImageView.image = [UIImage imageNamed:@"game"];
    _gameImageView.userInteractionEnabled = YES;
    _gameImageView.multipleTouchEnabled = YES;
    UITapGestureRecognizer *ddzGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goDDZAction)];
    [_gameImageView addGestureRecognizer:ddzGestureRecognizer];
    
    //描述视图(大转盘)
    UIView *dzpExplainView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_gameImageView.frame), Main_Screen_Width, 33)];
    UILabel *dzpExplainLabel = [[UILabel alloc] initWithFrame:CGRectMake((Main_Screen_Width-120)/2, (GetViewHeight(dzpExplainView)-25)/2, 120, 25)];
    dzpExplainLabel.text = @"幸运大转盘";
    dzpExplainLabel.textAlignment = NSTextAlignmentCenter;
    dzpExplainLabel.textColor = [UIColor orangeColor];
    dzpExplainLabel.font = [UIFont systemFontOfSize:18 weight:3];
    
    
    //大转盘图片
    _dzpImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(dzpExplainView.frame), Main_Screen_Width, 220)];
    _dzpImageView.image = [UIImage imageNamed:@"dzp"];
    _dzpImageView.userInteractionEnabled = YES;
    _dzpImageView.multipleTouchEnabled = YES;
    UITapGestureRecognizer *dzpGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goDZPAction:)];
    [_dzpImageView addGestureRecognizer:dzpGestureRecognizer];
    
    
    //这里添加所需要的游戏
    
   
    GameView *gameView = [[GameView alloc] initWithGameView:@"飞机大战" andImage: [UIImage imageNamed:@"plain"] andCurrView:self andGeuster:@selector(goDaFeiJiAction)];
    gameView.frame = CGRectMake(0, CGRectGetMaxY(_dzpImageView.frame), Main_Screen_Width, 255);
    
    GameView *game2View = [[GameView alloc] initWithGameView:@"城市消消乐" andImage:[UIImage imageNamed:@"569e026dacc26"] andCurrView:self andGeuster:@selector(goNewGame2Action)];
    game2View.frame = CGRectMake(0, CGRectGetMaxY(gameView.frame), Main_Screen_Width, 255);
    
    [self.globalScrollView addSubview:gameView];
    [self.globalScrollView addSubview:game2View];
    
    //描述视图(平台直播)
    UIView *liveExplainView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(game2View.frame), Main_Screen_Width, 33)];
    UILabel *liveExplainLabel = [[UILabel alloc] initWithFrame:CGRectMake((Main_Screen_Width-120)/2, (GetViewHeight(liveExplainView)-25)/2, 120, 25)];
    liveExplainLabel.text = @"平台直播";
    liveExplainLabel.textAlignment = NSTextAlignmentCenter;
    liveExplainLabel.textColor = [UIColor orangeColor];
    liveExplainLabel.font = [UIFont systemFontOfSize:18 weight:3];
    
    
    
    //在线视频图片
    _liveImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(liveExplainView.frame), Main_Screen_Width, 220)];
    _liveImageView.image = [UIImage imageNamed:@"live"];
    _liveImageView.userInteractionEnabled = YES;
    _liveImageView.multipleTouchEnabled = YES;
    UITapGestureRecognizer *liveTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goLiveAction)];
    [_liveImageView addGestureRecognizer:liveTapGesture];
    
    
    
    //改变滚动视图大小
    _globalScrollView.contentSize = CGSizeMake(Main_Screen_Width, CGRectGetMaxY(_liveImageView.frame));
    
    
    
    [_navView addSubview:_navToolBar];
    [_ddzExplainView addSubview:ddzExplainLabel];
    [dzpExplainView addSubview:dzpExplainLabel];
    [liveExplainView addSubview:liveExplainLabel];
    [_globalScrollView addSubview:liveExplainView];
    [_globalScrollView addSubview:_ddzExplainView];
    [_globalScrollView addSubview:dzpExplainView];
    [_globalScrollView addSubview:_navView];
    [_globalScrollView addSubview:_imageScorll];
    [_globalScrollView addSubview:_gameImageView];
    [_globalScrollView addSubview:_dzpImageView];
    [_globalScrollView addSubview:_liveImageView];
    
    [self.view addSubview:_globalScrollView];
    
}

-(void)initSubData{
    scrollImgs = [[NSArray alloc] initWithObjects:@"http://img4.cache.netease.com/3g/2016/4/24/201604240948016012c.png",@"http://img1.3lian.com/2015/a1/114/d/55.jpg",@"http://img.eeyy.com/uploadfile/2016/1027/20161027090734534.jpg",nil];
    scrollImgUrls = [[NSArray alloc] initWithObjects:@"http://www.adquan.com/post-5-35028.html",@"http://news.163.com/16/1030/15/C4KTEKSI000189FH.html",@"http://www.eeyy.com/chanye/20161027/89115.html",nil];
    
    MovieModel *movieModel = [[MovieModel alloc] init];
    movieArray = [[NSArray alloc] initWithObjects:movieModel,movieModel,movieModel,movieModel,movieModel,nil];
    MusicModel *musicModel1 = [MusicModel addMusicTitle:@"那些唱进心里的歌词" addMusicPath:@"music_cover1" addMusicReadNum:@"5411.1万"];
    MusicModel *musicModel2 = [MusicModel addMusicTitle:@"90后最爱的单曲循环" addMusicPath:@"music_cover2" addMusicReadNum:@"5411.1万"];
    MusicModel *musicModel3 = [MusicModel addMusicTitle:@"一人一首单曲循环" addMusicPath:@"music_cover3" addMusicReadNum:@"5411.1万"];
    MusicModel *musicModel4 = [MusicModel addMusicTitle:@"国人最爱情歌选" addMusicPath:@"music_cover4" addMusicReadNum:@"5411.1万"];
   
    musicArray = [NSArray arrayWithObjects:musicModel1,musicModel2,musicModel3,musicModel4, nil];
    
}


#pragma mark 进入大转盘
-(void)goDZPAction:(UITapGestureRecognizer *)gestureRecognizer{
    
    
    GlobalData *global = [GlobalData instanceGlobal];
    global.isManager= YES;
    
    //管理员控制
    if (global.isManager==NO) {
        _addExpectViewController = [[AddExpectViewController alloc] init];
        [self.navigationController pushViewController:_addExpectViewController animated:YES];
    }else{
        _radomAwardViewController = [[RandomAwardViewController alloc] init];
        [self.navigationController pushViewController:_radomAwardViewController animated:YES];
    }
    
    
    
}

#pragma mark 进入斗地主游戏
-(void)goDDZAction{
    _ddzGameViewController = [[WebGameViewController alloc] init];
    
    //_ddzGameViewController.urlStr = @"http://120.77.17.190/app/doudizhu/index.html";
    _ddzGameViewController.urlStr = @"http://hygo58.com/app/phpddz/flash.php";
    
    [self.navigationController pushViewController:_ddzGameViewController animated:YES];
    
}

#pragma mark 导航请求
-(void)goGameAction{
    _gameViewController = [[WebGameViewController alloc] init];
    _gameViewController.urlStr = @"http://120.77.17.190/game/index.html";
    [self.navigationController pushViewController:_gameViewController animated:YES];
    
}


-(void)goVideoAction{
    _movieViewController = [[WebMovieViewController alloc] init];
    _movieViewController.urlStr = @"http://m.bilibili.com/subchannel.html#tid=34";
    [self.navigationController pushViewController:_movieViewController animated:YES];
    
}

-(void)goMusicAction{
    if (_musicViewController.isPlaying==NO) {
        _musicViewController = [[WebMusicViewController alloc] init];
        _musicViewController.urlStr = @"http://music.baidu.com/home?fr=mo";
        //http://play.baidu.com/
        //http://music.baidu.com/song/266322598
    }
    [self.navigationController pushViewController:_musicViewController animated:YES];
}

-(void)goLiveAction{
     _liveViewController = [[HQLiveViewController alloc] init];
//    _tvViewController= [[WebTVViewController alloc] init];
//    _tvViewController.urlStr = @"http://m.huya.com/";
    [self.navigationController pushViewController:_liveViewController animated:YES];
    
}

-(void)goNBAAction{
    _nbaViewController= [[WebNBAViewController alloc] init];
    _nbaViewController.urlStr = @"http://www.bilibili.com/mobile/search.html?keyword=NBA%E7%9B%B4%E6%92%AD";
    [self.navigationController pushViewController:_nbaViewController animated:YES];
    
}


-(void)goNewGameAction{
    H5GameViewController *h5Game = [[H5GameViewController alloc] init];
    h5Game.urlStr = @"http://engine.zuoyouxi.com/demo/game/hexagon/index.php";
    [self.navigationController pushViewController:h5Game animated:YES];

}

-(void)goNewGame2Action{
    H5GameViewController *h5Game = [[H5GameViewController alloc] init];
    h5Game.urlStr = @"http://engine.zuoyouxi.com/game/Subara/index.php";
    [self.navigationController pushViewController:h5Game animated:YES];
    
}

-(void)goDaFeiJiAction{
    UIStoryboard *board = [UIStoryboard storyboardWithName: @"PlaneMain" bundle: nil];
    
    SKViewController *skViewController = [board instantiateViewControllerWithIdentifier: @"planeMainID"];
    
    [self.navigationController pushViewController:skViewController animated:YES];
}



#pragma mark - 创建流水布局
- (UICollectionViewFlowLayout *)setupCollectionViewFlowLayout
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = (Main_Screen_Width - 18)/2;
    layout.itemSize = CGSizeMake(width, width-30);
    layout.sectionInset = UIEdgeInsetsMake(6, 6, 6, 6);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 设置最小行间距
    layout.minimumLineSpacing = 6;
    // 设置最小列间距
    layout.minimumInteritemSpacing = 1.5;
    
    return layout;
}

#pragma mark - 创建UICollectionView
- (void)setupCollectionView:(UICollectionViewFlowLayout *)layout
{
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collection.backgroundColor = [UIColor whiteColor];
    collection.center = self.view.center;
    collection.bounds = self.view.bounds;
    collection.showsVerticalScrollIndicator = NO;
    [self.view addSubview:collection];
    
    collection.delegate = self;
    collection.dataSource = self;
    [collection registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:@"musicCell"];
    _collectionView = collection;
}






#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return musicArray.count;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeCollectionViewCell *cell = (HomeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"musicCell" forIndexPath:indexPath];
    
    MusicModel *musicModel = musicArray[indexPath.row];
    
    [cell.musicShadeView setImage:[UIImage imageNamed:musicModel.musicPath]];
    [cell.musicImageView setImage:[UIImage imageNamed:musicModel.musicPath]];
   
     cell.musicTitleLabel.text = musicModel.musicTitle;
    [cell initMusicModel:musicModel];
    NSLog(@"%@",musicModel.musicTitle);
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0) {
        
        NSLog(@"%zi",indexPath.row);
        
    }else if (indexPath.row == 1){
        
        NSLog(@"%zi",indexPath.row);
        
    }else{
        
        NSLog(@"%zi",indexPath.row);
    }
}

#pragma mark - layout的代理事件
- (CGFloat)puBuLiuLayoutHeightForItemAtIndex:(NSIndexPath *)index {
    
    
    
    return Main_Screen_Width/4;
}


#pragma mark tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return movieArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"movieCell"];
    
    if (cell==NULL) {
        cell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"movieCell"];
    }
    
    //数据输出
    movieTableCellHeight = cell.movieTableCellHeight;
    
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return movieTableCellHeight;
}



#pragma mark 横竖屏切换
- (void)viewWillLayoutSubviews{
    
    
    [self _shouldRotateToOrientation:(UIDeviceOrientation)[UIApplication sharedApplication].statusBarOrientation];
    
}

-(void)_shouldRotateToOrientation:(UIDeviceOrientation)orientation {
    
    
    NSArray  *views =   [self.view subviews];
    for(UIView *v in views){
        [v removeFromSuperview];
    }
    
    [self viewDidLoad];
    
    
}

-(UIStatusBarStyle)preferredStatusBarStyle{

    return UIStatusBarStyleDefault;
}

-(BOOL)prefersStatusBarHidden{
    
    return NO;
}


-(UIStatusBarAnimation)preferredStatusBarUpdateAnimation{

    
    return UIStatusBarAnimationNone;
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

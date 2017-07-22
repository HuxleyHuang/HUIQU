//
//  HQNewsViewController.m
//  HuiQu
//
//  Created by Huxley on 16/10/9.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "HQNewsViewController.h"
#import "Macros.h"
#import "News.h"
#import "NewsTableViewCell.h"
@interface HQNewsViewController ()
{
    NSArray *newsTags;
    NSArray *newsArray;
    CGFloat cellHeight;
}
@end

@implementation HQNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    // Do any additional setup after loading the view from its nib.
    [self initScrollView];
    [self initSubView];
    [self initSubData];
}


#pragma mark 初始化子视图
-(void)initScrollView{
    self.navigationItem.title = @"新闻中心";
    //网络加载
    //本地加载只要放图片名数组就行了
    
    NSArray *UrlStringArray = @[@"http://image99.360doc.com/DownloadImg/2016/08/3111/79075797_6.jpg",
                                @"http://img5.duitang.com/uploads/item/201409/08/20140908173359_HnPun.png",
                                @"http://img.bbs.duba.net/forum/201203/05/2136256nfkqqq736ncfsuj.jpg",
                                @"http://pic24.nipic.com/20121015/10021557_111114421194_2.jpg"];
    NSArray *titleArray = [@"午夜寂寞 谁来陪我,唱一首动人的情歌.你问我说 快不快乐,唱情歌越唱越寂寞.谁明白我 想要什么,一瞬间释放的洒脱.灯光闪烁 不必啰嗦,我就是传说中的那个摇摆哥.我是摇摆哥 音乐会让我快乐,我是摇摆哥 我已忘掉了寂寞.我是摇摆哥 音乐会让我洒脱,我们一起唱这摇摆的歌" componentsSeparatedByString:@"."];
    
    
    //显示顺序和数组顺序一致
    //设置图片url数组,和滚动视图位置
    
    _picScrollView = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Width * 504 / 1080.0) WithImageUrls:UrlStringArray];
    
    //显示顺序和数组顺序一致
    //设置标题显示文本数组
    
    
    
    _picScrollView.titleData = titleArray;
    
    //占位图片,你可以在下载图片失败处修改占位图片
    
    _picScrollView.placeImage = [UIImage imageNamed:@"place.png"];
    
    //图片被点击事件,当前第几张图片被点击了,和数组顺序一致
    
    [_picScrollView setImageViewDidTapAtIndex:^(NSInteger index) {
        printf("第%zd张图片\n",index);
    }];
    
    //default is 2.0f,如果小于0.5不自动播放
    _picScrollView.AutoScrollDelay = 2.0f;
    //    picView.textColor = [UIColor redColor];
    _picScrollView.textColor = [UIColor whiteColor];
    
    [self.view addSubview:_picScrollView];
    
    //下载失败重复下载次数,默认不重复,
    [[DCWebImageManager shareManager] setDownloadImageRepeatCount:1];
    
    //图片下载失败会调用该block(如果设置了重复下载次数,则会在重复下载完后,假如还没下载成功,就会调用该block)
    //error错误信息
    //url下载失败的imageurl
    [[DCWebImageManager shareManager] setDownLoadImageError:^(NSError *error, NSString *url) {
        NSLog(@"%@",error);
    }];
    
    
    
}


-(void)initSubView{
    _detailViewController = [[NewsDetailViewController alloc] init];
    //分类
    _sortView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_picScrollView.frame), Main_Screen_Width, (Main_Screen_Height-44-49-20-GetViewHeight(_picScrollView))*0.25)];
    //_sortView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_sortView];
    
    //帖子列表
    _newsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_sortView.frame), Main_Screen_Width, Main_Screen_Height-GetViewHeight(_sortView)-44-20-49) style:UITableViewStylePlain];
    _newsTableView.delegate = self;
    _newsTableView.dataSource = self;
    [self.view addSubview:_newsTableView];
    
    
    
    
    
}


-(void)layoutSortButton:(NSArray *)sortTitleArray{
    //int allRow = sortTitleArray.count%4==0?(int)sortTitleArray.count/4:(int)sortTitleArray.count/4+1;
    UIButton *sortBtn = [[UIButton alloc] init];
    for (int  i=1; i<=sortTitleArray.count; i++) {
        int row  = i%4==0?(int)i/4-1:(int)i/4;
        int col = i%4==0?3:(int)i%4-1;
        sortBtn = [[UIButton alloc] initWithFrame:CGRectMake(GetViewWidth(_sortView)*(0.12/5)+GetViewWidth(_sortView)*(0.12/5)*col+col*GetViewWidth(_sortView)*0.22, 15+10*row+row*30, GetViewWidth(_sortView)*0.22, 30)];
        [sortBtn setTitle:sortTitleArray[i-1] forState:UIControlStateNormal];
        sortBtn.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.8];
        sortBtn.tag = 99+i;
        sortBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [sortBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sortBtn addTarget:self action:@selector(categoryAction:) forControlEvents:UIControlEventTouchUpInside];
        [_sortView addSubview:sortBtn];
    }
    _sortView.frame = CGRectMake(0, GetViewY(_sortView), Main_Screen_Width, CGRectGetMaxY(sortBtn.frame)+15);
    _newsTableView.frame = CGRectMake(0, CGRectGetMaxY(_sortView.frame), Main_Screen_Width, Main_Screen_Height-GetViewHeight(_sortView)-44-20-49-GetViewHeight(_picScrollView));
    
}



-(void)categoryAction:(UIButton *)sender{
    //NSInteger btnTag =  sender.tag-100;
    NSLog(@"%@",sender.currentTitle);
    
}




#pragma mark 初始化子视图数据
-(void)initSubData{
    newsTags = [NSArray arrayWithObjects:@"社会",@"财经",@"军事",@"历史文化",@"科技",@"汽车",@"体育",@"娱乐",nil];
    News *news = [News initNewsData:@"恭喜你成为第333号高级购物达人！" andImageName:@"news_default" andExplain:@"开启会员模式" andContent:@"文章内容"];
    newsArray = [NSArray arrayWithObjects:news,news,news,news,news,nil];
    
    [self layoutSortButton:newsTags];
    
    
}






#pragma mark tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    
    
    return 1;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    return newsArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newsCell"];
    if (cell==NULL) {
        cell = [[NewsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"newsCell"];
        
        
        
    }
    
    News *news = newsArray[indexPath.row];
    
    cell.newsImageView.image = [UIImage imageNamed:news.imageName];
    cell.newsTitleLabel.text = news.title;
    cell.newsTextLabel.text = news.explain;
    cellHeight = cell.cellHeight;
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    return cellHeight;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"点击新闻%ld",(long)indexPath.row);
    _detailViewController.news = newsArray[indexPath.row];
    [self.navigationController pushViewController:_detailViewController animated:YES];
    
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

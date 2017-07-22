//
//  HQBBSViewController.m
//  HuiQu
//
//  Created by Huxley on 16/10/9.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "HQBBSViewController.h"
#import "Article.h"
#import "Macros.h"
#import "MBProgressHUD+MJ.h"
#import "ArticleTableViewCell.h"
#import "ColorManager.h"

@interface HQBBSViewController ()
{
    NSArray *sortTag;
    NSArray *articleArray;
    CGFloat cellHeight;
    
    
}

@end

@implementation HQBBSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initScrollView];
    [self initSubView];
    [self initSubData];
    
    
    
    
}

#pragma mark 初始化子视图
-(void)initScrollView{
    self.navigationItem.title = @"论坛";
    //网络加载
    //本地加载只要放图片名数组就行了
    
    NSArray *UrlStringArray = @[@"http://img.ivsky.com/img/bizhi/co/201609/26/brabus_tesla_model_s-005.jpg",
                                @"http://img.ivsky.com/img/bizhi/co/201609/25/xinmuou_qiyuji-003.jpg",
                                @"http://img.ivsky.com/img/tupian/co/201609/02/the_historic_town_of_dangkou-002.jpg",
                                @"http://img.ivsky.com/img/tupian/co/201608/29/guyuan-004.jpg"];
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
    
    //添加输入框
    [self inputTextField];
    //监听
    [self notificationCenterAction];
    //不搜索状态
    [self hiddenSearchAnimation];
    
    //分类导航
    _sortView = [[UIView alloc] init];
    [_sortView setFrame:CGRectMake(0, 0, Main_Screen_Width, 50)];
    _sortView.layer.borderWidth = 0.5;
    _sortView.layer.borderColor = [UIColor grayColor].CGColor;
    _appearImageView = [[UIImageView alloc] initWithFrame:CGRectMake(GetViewWidth(_sortView)-45, 8, 28, 28)];
    _appearImageView.image = [UIImage imageNamed:@"appear"];
    //用户交互 添加点击事件
    _appearImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *newArticle = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(appearNewAritcleAction:)];
    [_appearImageView addGestureRecognizer:newArticle];
    
    UIView *splitView = [[UIView alloc] initWithFrame:CGRectMake(GetViewWidth(_sortView)-58, 15, 2, 18)];
    splitView.layer.borderWidth =1;
    splitView.layer.borderColor = [UIColor grayColor].CGColor;
    
    CGFloat btnsWidth = GetViewWidth(_sortView)-GetViewWidth(_appearImageView)-55;
    CGFloat btnSpace = (btnsWidth-50*3)/5;
    sortTag = [NSArray arrayWithObjects:@"全部", @"新帖",@"宝典",@"问答", nil];
    for (int i = 0; i<sortTag.count; i++) {
        NSString *titleStr =  sortTag[i];
        UIButton *sortBtn = [[UIButton alloc] initWithFrame:CGRectMake(btnSpace+i*(btnSpace+50), 10, 50, 30)];
        [sortBtn setTitle:titleStr forState:UIControlStateNormal];
        [sortBtn addTarget:self action:@selector(categoryAction:) forControlEvents:UIControlEventTouchUpInside];
        sortBtn.tag = 200+i;
        sortBtn.layer.cornerRadius = 6;
        sortBtn.layer.masksToBounds = YES;
        [sortBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        sortBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        if(i==0){
            sortBtn.backgroundColor = [UIColor orangeColor];
        }
        
        [_sortView addSubview:sortBtn];
        
    }
    
    
    

   
    
    //帖子列表
    _articleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_nameTextField.frame)+5, Main_Screen_Width, Main_Screen_Height-20-44-GetViewHeight(_picScrollView)-5-GetViewHeight(_nameTextField)-5-49) style:UITableViewStylePlain];
    _articleTableView.delegate = self;
    _articleTableView.dataSource = self;
    _articleTableView.tableHeaderView = _sortView;
    
    
    
    //遮罩 阻止搜索时其它操作 退出搜索
    _shadeControl = [[UIControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_nameTextField.frame)+5, Main_Screen_Width, Main_Screen_Height-20-44-GetViewHeight(_picScrollView)-5-GetViewHeight(_nameTextField)-5-49)];
    _shadeControl.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
    _shadeControl.hidden = YES;
    [_shadeControl addTarget:self action:@selector(hiddenSearchAnimation) forControlEvents:UIControlEventTouchUpInside];
    
    [_sortView addSubview:splitView];
    [_sortView addSubview:_appearImageView];
    [self.view addSubview:_articleTableView];
    [self.view addSubview:_shadeControl];
    
    
    _articleDetailViewController = [[ArticleDetailViewController alloc] init];


}


#pragma mark 初始化子视图数据
-(void)initSubData{
    NSInteger callerNum = 143365;
    NSInteger revertNum = 1241;
    Article *article = [Article initArticleImageName:@"article_default" andAppearName:@"HuxleyHuang" andAppearTime:@"2016-9-15" andTitle:@"那些年我们吃过的烧烤" andRevertNum: revertNum andCallerNum:callerNum andContent:@"Hello World。" andExplain:@"Hello World"];
    articleArray = [NSArray arrayWithObjects:article,article,article,article,article,nil];
    
    
}



#pragma mark 分类请求
-(void)categoryAction:(UIButton *)sender{
   NSInteger btnTag =  sender.tag-200;
    
    for (int i = 0; i<sortTag.count; i++) {
        if (i==btnTag) {
            sender.layer.cornerRadius = 6;
            sender.layer.masksToBounds = YES;
            sender.backgroundColor = [UIColor orangeColor];
        }else{
            
            UIButton *sortBtn =  [_sortView viewWithTag:i+200];
            sortBtn.backgroundColor = [UIColor whiteColor];
        }
    }
    
    NSLog(@"分类请求:%@",sender.currentTitle);

}



#pragma mark 发表帖子请求
-(void)appearNewAritcleAction:(UIGestureRecognizer *)sender{
    
    
    NSLog(@"发帖请求");


}



//************************监听事件************************
#pragma mark - 监听键盘的事件
-(void) notificationCenterAction
{
    //监听键盘的事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:self.view.window];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:self.view.window];
}

#pragma mark - 屏幕的伸缩
//键盘升起时动画
- (void)keyboardWillShow:(NSNotification*)notif
{
    //动态提起整个屏幕
    [UIView animateWithDuration:4 animations:^{
        
        [self searchAnimation];
        
    } completion:nil];
}


//键盘关闭时动画
- (void)keyboardWillHide:(NSNotification*)notif
{
    
    [UIView animateWithDuration:4 animations:^{
        
        [self hiddenSearchAnimation];
        
    } completion:nil];
}


//************************输入框事件************************
-(void) inputTextField
{
    //****************************搜索框*****************************
    _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_picScrollView.frame)+5, Main_Screen_Width-20, 30)];
    _nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    
    _nameTextField.placeholder = @"搜索你想看的帖";
    //设置输入框内容的字体样式和大小
    _nameTextField.font = [UIFont fontWithName:@"Arial" size:14.0f];
    _nameTextField.textColor  = [UIColor blackColor];
    
    //_nameTextField.textAlignment = UITextAlignmentCenter;
    _nameTextField.delegate = self;
    
   
    
    //*******************************************************
    
    //****************************搜索按钮*****************************
//    _searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_nameTextField.frame)+5, GetViewY(_nameTextField), GetViewWidth(self.view)*0.3-15, 30)];
//    
//    UIImage *redImage = [ColorManager imageWithColor:[UIColor orangeColor]];
//    [_searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
//    [_searchBtn setBackgroundColor:[UIColor clearColor]];
//    [_searchBtn setBackgroundImage:redImage forState:UIControlStateNormal];
//    
//    [_searchBtn addTarget:self action:@selector(serachAction) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self.view addSubview:_searchBtn];
    [self.view addSubview:_nameTextField];
    
}


//************************动态事件************************
//显示搜索状态
-(void) searchAnimation
{
    _shadeControl.hidden = NO;
    self.inputView = [[UIView alloc] init];
    self.inputView.frame= CGRectMake(0, 0 ,inputW , inputW);
    
    self.imgSearch = [[UIImageView alloc] init];
    self.imgSearch.image = [UIImage imageNamed:@"search"];
    CGRect rx = CGRectMake( 12,(inputW - imgSearchW)/2 , imgSearchW, imgSearchW);
    self.imgSearch.frame = rx;
    
    
    [self.inputView addSubview:self.imgSearch];
    // 把leftVw设置给文本框
    _nameTextField.leftView = self.inputView;
    _nameTextField.leftViewMode = UITextFieldViewModeAlways;
    
    
}
//显示隐藏状态
-(void) hiddenSearchAnimation
{
    _shadeControl.hidden = YES;
    [_nameTextField resignFirstResponder];
    self.inputView = [[UIView alloc] init];
    CGFloat textFieldW = 24;
    self.inputView.frame= CGRectMake(0, 0 ,textFieldW , inputW);
    
    
    self.imgSearch = [[UIImageView alloc] init];
    self.imgSearch.image = [UIImage imageNamed:@"search"];
    CGRect rx = CGRectMake( textFieldW -12 , (inputW - imgSearchW)/2 , imgSearchW, imgSearchW);
    self.imgSearch.frame = rx;
    
    
    [self.inputView addSubview:self.imgSearch];
    // 把leftVw设置给文本框
    _nameTextField.leftView = self.inputView;
    _nameTextField.leftViewMode = UITextFieldViewModeAlways;
    
}



#pragma  mark 搜索框代理delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    if (_nameTextField.text.length==0) {
        [MBProgressHUD showError:@"搜索对象不能为空"];
        return NO;
    }
    
    [_nameTextField resignFirstResponder];
    [self.view endEditing:YES];
    _shadeControl.hidden=YES;
    
    return YES;
}



//遮罩触击
-(void)shadeTouchBegin{
    [self.view endEditing:YES];
    [_shadeControl setHidden:YES];
    
}








#pragma mark tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{



    
    return 1;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    
    return 5;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     ArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"articleCell"];
    if (cell==NULL) {
        cell = [[ArticleTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"articleCell"];
        
    }
    
    Article *article =  articleArray[indexPath.row];
    cell.articleImageView.image = [UIImage imageNamed:article.imageName];
    cell.articleTitleLabel.text = article.title;
    cell.appearTimeLabel.text = article.appearTime;
    cell.appearNameLabel.text = article.appearName;
    cell.revertLabel.text = [[[NSNumber alloc] initWithInteger:article.revertNum] stringValue];
    cell.callerLabel.text = [[[NSNumber alloc] initWithInteger:article.callerNum] stringValue];
    
    cellHeight = cell.cellHeight;
    
    


    return cell;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    Article *article = articleArray[indexPath.row];
    _articleDetailViewController.article = article;
    
    [self.navigationController pushViewController:_articleDetailViewController animated:YES];


}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    return cellHeight;
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

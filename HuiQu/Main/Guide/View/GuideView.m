//
//  GuideView.m
//  HuiQu
//
//  Created by Huxley on 16/11/3.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "GuideView.h"
#import "Macros.h"
#import "AppDelegate.h"
#import "HQTabBarViewController.h"
#import "HQLoginViewController.h"
#import "HQNavViewController.h"
@interface GuideView ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>
@end

@implementation GuideView{
    UIScrollView *_baseScrollView;
    UIPageControl *_pageControl;
    
    UIButton *goInButton;
    UIButton *skipButton;
    BOOL isLastPage;
    
}

- (instancetype)initWithFrame:(CGRect)frame Images:(NSArray *)images
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initViews];
        _images = images;
        [self setImages:images];
    }
    return self;
}
- (void)goInButtonClick{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIView animateWithDuration:1 animations:^{
            if (_scrollDirection == 0) {
                CGRect viewFrame = _baseScrollView.frame;
                viewFrame.origin.x = - Main_Screen_Width;
                _baseScrollView.frame = viewFrame;
            }else{
                CGRect viewFrame = _baseScrollView.frame;
                viewFrame.origin.y = - Main_Screen_Height;
                _baseScrollView.frame = viewFrame;
            }
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            
//            #pragma mark 首页跳转
//            AppDelegate *appDelegate = (AppDelegate *)AppDelegateInstance;
//            UIWindow *window = appDelegate.window;
//            appDelegate.tabBarController = [[HQTabBarViewController alloc] init];
//            [window setRootViewController:appDelegate.tabBarController];
//            [window makeKeyAndVisible];
            
            
              #pragma mark 登录跳转
             AppDelegate *appDelegate = (AppDelegate *)AppDelegateInstance;
             UIWindow *window = appDelegate.window;
             appDelegate.loginViewController = [[HQLoginViewController alloc] init];
             appDelegate.navigationController = [[HQNavViewController alloc] initWithRootViewController:appDelegate.loginViewController];
             [window setRootViewController:appDelegate.navigationController];
             [window makeKeyAndVisible];
            
        }];
        
        
        
        
    });
}
- (void)initViews{
    _baseScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    _baseScrollView.bounces = NO;
    _baseScrollView.delegate = self;
    _baseScrollView.pagingEnabled = YES;
    _baseScrollView.showsHorizontalScrollIndicator = NO;
    _baseScrollView.showsVerticalScrollIndicator = NO;
    
    [self addSubview:_baseScrollView];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, Main_Screen_Height - 50, Main_Screen_Width, 30)];
    [_pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
    //    _pageControl.tintColor = BUTTON_COLOR;
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    //    _pageControl.currentPageIndicatorTintColor = [UIImage imageNamed:@""].CGImage
    [self addSubview:_pageControl];
    
    
    
    goInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [goInButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    goInButton.frame  = CGRectMake(40, Main_Screen_Height - 60, Main_Screen_Width - 80, 40);
    [goInButton setTitle:@"立即进入" forState:UIControlStateNormal];
    goInButton.layer.cornerRadius = GetViewHeight(goInButton) *.5;
    goInButton.clipsToBounds = YES;
    goInButton.backgroundColor = [UIColor whiteColor];
    [goInButton addTarget:self action:@selector(goInButtonClick) forControlEvents:UIControlEventTouchUpInside];
    goInButton.hidden = YES;
    goInButton.alpha = 0;
    [self addSubview:goInButton];
}

- (void)setImages:(NSArray *)images{
    _images = images;
    if (!_baseScrollView) {
        [self initViews];
    }
    if (_scrollDirection == 0) {
        _baseScrollView.contentSize = CGSizeMake(Main_Screen_Width * images.count, 0);
    }else{
        _baseScrollView.contentSize = CGSizeMake(0 , Main_Screen_Height * images.count);
    }
    _pageControl.numberOfPages = images.count;
    //_pageControl.hidden = _scrollDirection == 0?NO:YES;
    for (int i = 0; i<images.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(_scrollDirection == 0?Main_Screen_Width*i:0, _scrollDirection == 0?0:Main_Screen_Height*i, Main_Screen_Width, Main_Screen_Height)];
        imageView.image = [UIImage imageNamed:images[i]];
        imageView.userInteractionEnabled = YES;
        UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        nextBtn.frame = CGRectMake(0, Main_Screen_Height - 95, Main_Screen_Width, 60);
        //        nextBtn.backgroundColor = RGBA_COLOR(255, 255, 255, 0.5);
        [nextBtn addTarget:self action:@selector(nextPage:) forControlEvents:UIControlEventTouchUpInside];
        nextBtn.tag = 100 + i;
        [imageView addSubview:nextBtn];
        [_baseScrollView addSubview:imageView];
        
        UISwipeGestureRecognizer *pan = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
        pan.delegate = self;
        [pan setDirection:UISwipeGestureRecognizerDirectionUp];
        //        [pan setDirection:UISwipeGestureRecognizerDirectionDown];
        [imageView addGestureRecognizer:pan];
        
        UISwipeGestureRecognizer *pan1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
        pan1.delegate = self;
        [pan1 setDirection:UISwipeGestureRecognizerDirectionLeft];
        [imageView addGestureRecognizer:pan1];
    }
    
    
    
    skipButton = [UIButton buttonWithType:UIButtonTypeCustom ];
    if (_scrollDirection == 1) {
        skipButton.frame  = CGRectMake(Main_Screen_Width - 50, Main_Screen_Height - 75, 40, 40);
    }else{
        skipButton.frame  = CGRectMake(Main_Screen_Width - 50, 30, 40, 40);
    }
    skipButton.layer.cornerRadius = 20;
    skipButton.clipsToBounds = YES;
    skipButton.backgroundColor = [UIColor grayColor];
    skipButton.alpha = 0.4;
    [skipButton setTitle:@"跳过" forState:UIControlStateNormal];
    skipButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [skipButton addTarget:self action:@selector(goInButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:skipButton];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (isLastPage) {
        return YES;
    }
    return NO;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
- (void)panGesture:(UISwipeGestureRecognizer *)gesture{
    NSLog(@"滑动方向%lu",(unsigned long)gesture.direction);
    if(gesture.direction==UISwipeGestureRecognizerDirectionDown) {
        
        NSLog(@"swipe down");
        //执行程序
    }
    if(gesture.direction==UISwipeGestureRecognizerDirectionUp) {
        if (isLastPage) {
            if (_scrollDirection == 0) {
                
            }else{
                [self goInButtonClick];
            }
        }
        NSLog(@"swipe up");
        //执行程序
    }
    
    if(gesture.direction==UISwipeGestureRecognizerDirectionLeft) {
        
        NSLog(@"swipe left");
        if (isLastPage) {
            if (_scrollDirection == 0) {
                [self goInButtonClick];
            }
        }
        //执行程序
    }
    
    if(gesture.direction==UISwipeGestureRecognizerDirectionRight) {
        
        NSLog(@"swipe right");
        //执行程序
    }
}

- (void)nextPage:(UIButton *)sender{
    _pageControl.currentPage = sender.tag - 100 + 1;
    if (sender.tag - _images.count + 1 == 100) {//最后一页，隐藏引导页
        NSLog(@"最后一页");
        [self goInButtonClick];
    }else{//切换到一页
        NSLog(@"第%ld页",(long)sender.tag - 100);
        if (sender.tag - 100 + 1 == _images.count) {
            isLastPage = YES;
        }else{
            isLastPage = NO;
        }
        
        [UIView animateWithDuration:0.2 animations:^{
            _baseScrollView.contentOffset = CGPointMake(_scrollDirection == 0?(sender.tag - 100 + 1)*Main_Screen_Width:0, _scrollDirection == 0?0:(sender.tag - 100 + 1)*Main_Screen_Height);
            
        }];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint point = scrollView.contentOffset;
    NSInteger currentPage = (_scrollDirection == 0?point.x:point.y)/(_scrollDirection == 0?Main_Screen_Width:Main_Screen_Height);
    _pageControl.currentPage = currentPage;
    if (currentPage == _images.count - 1) {
        isLastPage = YES;
        
        [self showGoinButton:YES];
    }else{
        [self showGoinButton:NO];
        isLastPage = NO;
    }
}
- (void)showGoinButton:(BOOL)show{
    goInButton.hidden = !show;
    _pageControl.hidden = show;
    [UIView animateWithDuration:0.1 animations:^{
        goInButton.alpha = show?1:0;
    }];
}
- (void)pageChanged:(UIPageControl *)pageControl{
    _baseScrollView.contentOffset = CGPointMake(pageControl.currentPage*Main_Screen_Width, 0);
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end


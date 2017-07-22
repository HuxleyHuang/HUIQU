//
//  LivePlayViewController.m
//  HuiQu
//
//  Created by Huxley on 16/12/16.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "LivePlayViewController.h"
#import "LiveItemModel.h"
#import "CreatorItemModel.h"
#import <UIImageView+WebCache.h>
#import "Macros.h"

@interface LivePlayViewController ()

@end

@implementation LivePlayViewController


- (IBAction)back:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置直播占位图片
    NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://img.meelive.cn/%@",_live.creator.portrait]];
    [self.imageView sd_setImageWithURL:imageUrl placeholderImage:nil];
    
    // 拉流地址
    NSURL *url = [NSURL URLWithString:_live.stream_addr];
    
    // 创建IJKFFMoviePlayerController：专门用来直播，传入拉流地址就好了
    IJKFFMoviePlayerController *playerVc = [[IJKFFMoviePlayerController alloc] initWithContentURL:url withOptions:nil];
    
    // 准备播放
    [playerVc prepareToPlay];
    
    // 强引用，反正被销毁
    _player = playerVc;
    
    playerVc.view.frame = [UIScreen mainScreen].bounds;
    
    [self.view insertSubview:playerVc.view atIndex:1];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark 横竖屏切换
- (void)viewWillLayoutSubviews{
    
    [self _shouldRotateToOrientation:(UIDeviceOrientation)[UIApplication sharedApplication].statusBarOrientation];
    
}

-(void)_shouldRotateToOrientation:(UIDeviceOrientation)orientation {
    
    if(orientation == UIDeviceOrientationLandscapeLeft || orientation==UIDeviceOrientationLandscapeRight){
        UIView *view = [self.view.subviews objectAtIndex:1];
        view.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height);
    }else if(orientation==UIDeviceOrientationPortrait || orientation== UIDeviceOrientationPortraitUpsideDown){
        UIView *view = [self.view.subviews objectAtIndex:1];
        view.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height);
    }
    
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 界面消失，一定要记得停止播放
    [_player pause];
    [_player stop];
    [_player shutdown];
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

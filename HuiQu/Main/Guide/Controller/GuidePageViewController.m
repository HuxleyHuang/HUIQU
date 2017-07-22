//
//  GuidePageViewController.m
//  HuiQu
//
//  Created by Huxley on 16/11/3.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "GuidePageViewController.h"
#import "Macros.h"
#import "HQLoginViewController.h"
#import "GuideView.h"
@interface GuidePageViewController ()

@end

@implementation GuidePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _guideView = [[GuideView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    _guideView.scrollDirection = 0;
    NSArray *images = Main_Screen_Height == 480?@[@"guide1_640x960.jpg",
                                                  @"guide2_640x960.jpg",
                                                  @"guide3_640x960.jpg"]:
                                                @[@"guide1_640x1136.jpg",
                                                @"guide2_640x1136.jpg",
                                                @"guide3_640x1136.jpg"];
    _guideView.images = images;
    [self.view addSubview:_guideView];
    
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

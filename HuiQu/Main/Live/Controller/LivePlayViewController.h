//
//  LivePlayViewController.h
//  HuiQu
//
//  Created by Huxley on 16/12/16.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <IJKMediaFramework/IJKMediaFramework.h>

@class LiveItemModel;
@interface LivePlayViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@property (nonatomic, strong) LiveItemModel *live;


@property (nonatomic, strong) IJKFFMoviePlayerController *player;



@end

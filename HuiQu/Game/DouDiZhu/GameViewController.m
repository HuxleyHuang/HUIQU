//
//  GameViewController.m
//  HuiQu
//
//  Created by Huxley on 16/11/3.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"
@interface GameViewController ()

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Load the SKScene from 'GameScene.sks'
    GameScene *scene = (GameScene *)[SKScene nodeWithFileNamed:@"GameScene"];
    
    // Set the scale mode to scale to fit the window
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    
    SKView *skView = (SKView *)self.view;
    
    // Present the scene
    [skView presentScene:scene];
    
    
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    
}

- (BOOL)shouldAutorotate {
    
    return YES;
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


- (BOOL)prefersStatusBarHidden {
    
    return YES;
}
@end

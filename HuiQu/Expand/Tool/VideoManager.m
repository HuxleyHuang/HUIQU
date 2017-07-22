//
//  VideoManager.m
//  HuiQu
//
//  Created by Huxley on 16/12/13.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "VideoManager.h"

@implementation VideoManager



+(UIImage *)getPreviewImageWithVideo:(NSURL *)videoURL{

    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *currentImg = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    
    return currentImg;
}






@end

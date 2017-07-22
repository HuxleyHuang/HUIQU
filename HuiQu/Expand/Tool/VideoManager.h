//
//  VideoManager.h
//  HuiQu
//
//  Created by Huxley on 16/12/13.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface VideoManager : NSObject


/** 获取网络视频预览图 */
+(UIImage*)getPreviewImageWithVideo:(NSURL *)videoURL;




@end

//
//  MusicModel.m
//  HuiQu
//
//  Created by Huxley on 16/10/10.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "MusicModel.h"

@implementation MusicModel


-(instancetype)init{
    self = [super init];
    if (self) {
//        _musicPath = @"music_cover1";
//        _musicTitle = @"Hello";
//        _musicReadNum = @"32万";
    }
    return self;
}

+(MusicModel *)addMusicTitle:(NSString *)musicTitle addMusicPath:(NSString *)musicPath addMusicReadNum:(NSString *)musicReadNum{
    MusicModel  *musicModel = [[MusicModel alloc] init];
    musicModel.musicTitle = musicTitle;
    musicModel.musicPath = musicPath;
    musicModel.musicReadNum = musicReadNum;
    return musicModel;
}




@end

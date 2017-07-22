//
//  MusicModel.h
//  HuiQu
//
//  Created by Huxley on 16/10/10.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicModel : NSObject

@property(copy,nonatomic) NSString *musicPath;
@property(copy,nonatomic) NSString *musicTitle;
@property(copy,nonatomic) NSString *musicReadNum;


-(instancetype)init;

+(instancetype)addMusicTitle:(NSString *)musicTitle addMusicPath:(NSString *)musicPath addMusicReadNum:(NSString *)musicReadNum;

@end

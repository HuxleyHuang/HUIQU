//
//  HomeCollectionViewCell.m
//  HuiQu
//
//  Created by Huxley on 16/10/10.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "HomeCollectionViewCell.h"
#import "Macros.h"
#import "TextTool.h"
#import "MusicModel.h"
@implementation HomeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initView];
    }
    return self;


}



-(void)initView{
    _musicImageView  = [[UIImageView alloc] initWithFrame:self.bounds];
    _musicImageView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_musicImageView];
    
    UIFont *textFont = [UIFont systemFontOfSize:10 weight:1];
    CGSize textSize = [TextTool getTextSizeWithFont:@"那些唱进心里的歌词" withFont:textFont];
    
    //标题视图
    _shadeView = [[UIView alloc] initWithFrame:CGRectMake(GetViewWidth(self)-20-textSize.width-1, 5, textSize.width+20, GetViewHeight(self)*0.15)];
    _shadeView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.4];
    [_musicImageView addSubview:_shadeView];
    //耳机
    _earphoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, GetViewHeight(_shadeView))];
    [_earphoneImageView setImage:[UIImage imageNamed:@"earphone"]];
    [_shadeView addSubview:_earphoneImageView];
    
    //名称
    _musicTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_earphoneImageView.frame), 0, GetViewWidth(_shadeView)-GetViewWidth(_earphoneImageView), GetViewHeight(_shadeView))];
    [_musicTitleLabel setFont:[UIFont systemFontOfSize:10 weight:1]];
    [_musicTitleLabel setTextColor:[UIColor whiteColor]];
    [_musicTitleLabel setText:@"那些唱进心里的歌词"];
    [_shadeView addSubview:_musicTitleLabel];
    
    //阅读量
   CGSize readNumSize =  [TextTool getTextSizeWithFont:@"5411.1万" withFont:[UIFont systemFontOfSize:12]];
    _musicReadNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(GetViewWidth(_musicImageView)-readNumSize.width-5,CGRectGetMaxY(_musicImageView.frame)-GetViewHeight(_musicImageView)*0.15, readNumSize.width, GetViewHeight(_musicImageView)*0.15)];

    [_musicReadNumLabel setText:@"5411.1万"];
    [_musicReadNumLabel setFont:[UIFont systemFontOfSize:10 weight:1]];
    [_musicReadNumLabel setTextColor:[UIColor whiteColor]];
    [_musicImageView addSubview:_musicReadNumLabel];
    
    

}

-(void)initMusicModel:(MusicModel *)musicModel{
    CGSize textSize = [TextTool getTextSizeWithFont:musicModel.musicTitle withFont:[UIFont systemFontOfSize:10 weight:1]];
    _shadeView.frame = CGRectMake(GetViewWidth(self)-20-textSize.width-1, 5, textSize.width+20, GetViewHeight(self)*0.15);
    _musicTitleLabel.frame = CGRectMake(CGRectGetMaxX(_earphoneImageView.frame), 0, GetViewWidth(_shadeView)-GetViewWidth(_earphoneImageView), GetViewHeight(_shadeView));
    
}


@end

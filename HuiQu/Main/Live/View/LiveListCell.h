//
//  LiveListCell.h
//  HuiQu
//
//  Created by Huxley on 16/12/15.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <UIKit/UIKit.h>


@class LiveItemModel;
@interface LiveListCell : UITableViewCell


@property (nonatomic, strong) LiveItemModel *live;


/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;

/**主播名*/
@property (weak, nonatomic) IBOutlet UILabel *liveNameLabel;

/**地区 */
@property (weak, nonatomic) IBOutlet UILabel *liveAddressLabel;

/** 观众人数 */
@property (weak, nonatomic) IBOutlet UILabel *peopleNumberLabel;

/** 预览图 */
@property (weak, nonatomic) IBOutlet UIImageView *previewImageView;

/** Live */
@property (weak, nonatomic) IBOutlet UILabel *liveLabel;


@end

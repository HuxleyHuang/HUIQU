//
//  MovieModel.h
//  HuiQu
//
//  Created by Huxley on 16/10/10.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieModel : NSObject

@property (copy, nonatomic) NSString *coverPath;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSArray<NSString *> *type;
@property (copy, nonatomic) NSArray<NSString *> *stars;
@property (copy, nonatomic) NSString *time;


-(instancetype)init;


@end

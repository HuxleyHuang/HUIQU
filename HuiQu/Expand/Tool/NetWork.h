//
//  NetWork.h
//  HuiQu
//
//  Created by Huxley on 16/11/2.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NetWork : NSObject

@property(strong, nonatomic) NSString *networkStatus;

+(NetWork *)shareInstance;

-(void)changeNetworkStatus:(NSString *)status;

@end

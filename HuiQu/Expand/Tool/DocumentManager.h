//
//  DocumentManager.h
//  InternetReptile
//
//  Created by Huxley on 16/6/16.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DocumentManager : NSObject



+(BOOL)createPlistFile:(NSString *)fileName;

+(NSMutableDictionary *)readPlistFile:(NSString *)fileName;

+(BOOL)writePlistFile:(NSString *)fileName andDict:(NSMutableDictionary *)dict;


@end

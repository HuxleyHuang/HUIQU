//
//  DocumentManager.m
//  InternetReptile
//
//  Created by Huxley on 16/6/16.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "DocumentManager.h"

@implementation DocumentManager


//创建plist文件
+(BOOL)createPlistFile:(NSString *)fileName{
    
    //沙盒路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentPath = paths.firstObject;
    
    // plist 路径
    NSString *plistPath  = [documentPath stringByAppendingPathComponent:fileName];
    
    
    NSFileManager *fileManager = [[NSFileManager  alloc]init];
    
    //判断是否存在plist文件
    if (![fileManager fileExistsAtPath:plistPath]) {
        //判断是否能创建plist文件
        if ([fileManager createFileAtPath:plistPath contents:nil attributes:nil]) {
            
            NSMutableDictionary *createDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
            [createDict setObject:@"sb" forKey:@"sb"];
            [createDict writeToFile:plistPath atomically:YES];
            NSLog(@"创建plist文件成功 路径=%@",plistPath);
            return YES;
        }else{
            NSLog(@"创建plist文件失败");
            return NO;
        }
        
        
    }else{
        
        NSLog(@"存在名为“%@”plist文件",fileName);
        
        return NO;
    }
    
    

}



//读取plist文件内容
+(NSMutableDictionary *)readPlistFile:(NSString *)fileName{
    
    NSMutableDictionary *fileDict = nil;
    
    //沙盒路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentPath = paths.firstObject;
    
    // plist 路径
    NSString *plistPath  = [documentPath stringByAppendingPathComponent:fileName];
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    if ([fileManager fileExistsAtPath:plistPath]) {
        
         fileDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        
        
        NSLog(@"读取成功");
        
    }else{
    
        NSLog(@"读取失败");
    }
  

    return fileDict;
}


//写入数据
+(BOOL)writePlistFile:(NSString *)fileName andDict:(NSMutableDictionary *)dict{

    //沙盒路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentPath = paths.firstObject;
    
    // plist 路径
    NSString *plistPath  = [documentPath stringByAppendingPathComponent:fileName];
    
    
    NSFileManager *fileManager = [[NSFileManager  alloc]init];
    
    //判断是否存在plist文件
    if ([fileManager fileExistsAtPath:plistPath]) {
        
        [dict writeToFile:plistPath atomically:YES];
        NSLog(@"写入plist数据成功");
        return YES;
        
    }else{
        
        NSLog(@"不存在名为“%@”plist文件，写入数据失败",fileName);
        
        return NO;
    }
    
    
}


@end

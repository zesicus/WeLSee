//
//  ReadFile.m
//  We'll see
//
//  Created by Sunny on 12/31/15.
//  Copyright © 2015 Nine. All rights reserved.
//

#import "ReadFile.h"

@interface ReadFile () {
    NSFileManager *fileManager;
}

@end

@implementation ReadFile

//获取Documents目录下的文件以数组返回
- (NSMutableDictionary *)contentsOfDocuments {
    fileManager = [NSFileManager defaultManager];
    NSMutableDictionary *contents = [NSMutableDictionary dictionary];
    
    NSArray *documentsDictionary = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [documentsDictionary lastObject];
    path = [path stringByAppendingString:@"/"];
    
    //得到文件名
    NSError *err;
    NSMutableArray *nameArray = (NSMutableArray *)[fileManager contentsOfDirectoryAtPath:path error:&err];
    [contents setObject:nameArray forKey:@"fileNames"];
    
    //得到完整路径
    NSMutableArray *pathArray = [NSMutableArray array];
    for (int i = 0; i < nameArray.count; i++) {
        pathArray[i] = [path stringByAppendingString:nameArray[i]];
    }
    [contents setObject:pathArray forKey:@"filePaths"];
    
    return contents;
}

@end

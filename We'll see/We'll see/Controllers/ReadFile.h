//
//  ReadFile.h
//  We'll see
//
//  Created by Sunny on 12/31/15.
//  Copyright © 2015 Nine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadFile : NSObject

//得到文件完整路径和文件名的封装
- (NSMutableDictionary *)contentsOfDocuments;

@end

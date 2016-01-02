//
//  TVCell.m
//  We'll see
//
//  Created by Sunny on 1/1/16.
//  Copyright © 2016 Nine. All rights reserved.
//

#import "TVCell.h"

@implementation TVCell

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier];
    if (self) {
        //初始化cell
        UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 124, 129)];
        //背景白色
        [mainView setBackgroundColor:[UIColor whiteColor]];
        //图片和标题属性
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 20, 65, 65)];
        [mainView addSubview:_imageView];
        self.describeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 125, 20)];
        self.describeLabel.textAlignment = NSTextAlignmentCenter;
        [mainView addSubview:_describeLabel];
        
        [self.contentView addSubview:mainView];
    }
    return self;
}

@end

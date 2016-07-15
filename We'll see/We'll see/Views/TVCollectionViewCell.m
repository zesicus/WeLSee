//
//  TVCollectionViewCell.m
//  We'll see
//
//  Created by Sunny on 7/15/16.
//  Copyright © 2016 Nine. All rights reserved.
//

#import "TVCollectionViewCell.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation TVCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //图片和标题属性
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, frame.size.width - 40, frame.size.width - 40)];
        [self addSubview:_imageView];
        self.describeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.width - 30, frame.size.width, 30)];
        self.describeLabel.textAlignment = NSTextAlignmentCenter;
        _describeLabel.font = [UIFont systemFontOfSize:18];
        _describeLabel.textColor = [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1.0];
        [self addSubview:_describeLabel];
        
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor colorWithRed:238/255.f green:238/255.f blue:238/255.f alpha:1.0].CGColor;
    }
    return self;
}

@end

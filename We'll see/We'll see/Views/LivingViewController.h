//
//  LivingViewController.h
//  We'll see
//
//  Created by Sunny on 12/30/15.
//  Copyright © 2015 Nine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DMPagerViewController.h>
#import "AQGridView.h"

@interface LivingViewController : UIViewController <DMPagerViewControllerProtocol, AQGridViewDelegate, AQGridViewDataSource>

@property (nonatomic, strong) DMPagerNavigationBarItem *pageObj;
@property (nonatomic, strong) AQGridView *gridView;

@end

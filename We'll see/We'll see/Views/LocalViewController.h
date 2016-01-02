//
//  LocalViewController.h
//  We'll see
//
//  Created by Sunny on 12/30/15.
//  Copyright © 2015 Nine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DMPagerViewController.h>

@interface LocalViewController : UITableViewController <DMPagerViewControllerProtocol>

@property (nonatomic, strong) DMPagerNavigationBarItem *pageObj;

@end

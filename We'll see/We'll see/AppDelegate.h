//
//  AppDelegate.h
//  We'll see
//
//  Created by Sunny on 12/29/15.
//  Copyright © 2015 Nine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DMPagerViewController.h>
#import "LivingViewController.h"
#import "LocalViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) DMPagerViewController *pageVC;
@property (strong, nonatomic) LivingViewController *livingVC;
@property (strong, nonatomic) LocalViewController *localVC;

@end


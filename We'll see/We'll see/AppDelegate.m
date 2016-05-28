//
//  AppDelegate.m
//  We'll see
//
//  Created by Sunny on 12/29/15.
//  Copyright © 2015 Nine. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1"]]];
    
    NSDictionary *textAttributes = @{ NSFontAttributeName : [UIFont systemFontOfSize:12.0f],
                                      NSForegroundColorAttributeName : [UIColor blackColor]};
    //LivingViewController导航栏配置
    _livingVC = [[LivingViewController alloc] init];
    _livingVC.pageObj = [DMPagerNavigationBarItem newItemWithText: [[NSAttributedString alloc] initWithString:@"直播" attributes:textAttributes] andIcon: [UIImage imageNamed:@"net"]];
    _livingVC.pageObj.renderingMode = DMPagerNavigationBarItemModeTextAndImage;
    
    //LocalViewController导航栏配置
    _localVC = [[LocalViewController alloc] init];
    _localVC.pageObj = [DMPagerNavigationBarItem newItemWithText:[[NSAttributedString alloc] initWithString:@"本地" attributes:textAttributes] andIcon:[UIImage imageNamed:@"local"]];
    _localVC.pageObj.renderingMode = DMPagerNavigationBarItemModeTextAndImage;
    
    _pageVC = [[DMPagerViewController alloc] initWithViewControllers:@[_livingVC, _localVC]];
    
    //bar图标活动或未激活设置
    UIColor *activeColor = [UIColor colorWithRed:0.000 green:0.235 blue:0.322 alpha:1.000];
    UIColor *inactiveColor = [UIColor colorWithRed:.84 green:.84 blue:.84 alpha:1.0];
    _pageVC.navigationBar.inactiveItemColor = inactiveColor;
    _pageVC.navigationBar.activeItemColor = activeColor;
    
    self.window.rootViewController = _pageVC;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    if (_allowRotation) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

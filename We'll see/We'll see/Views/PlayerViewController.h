//
//  PlayerViewController.h
//  We'll see
//
//  Created by Sunny on 12/31/15.
//  Copyright © 2015 Nine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"

@interface PlayerViewController : UIViewController <VLCMediaPlayerDelegate>

@property (nonatomic, strong) NSString *playName;
@property (nonatomic, strong) NSString *playPath;
@property (nonatomic, strong) NSURL *playURL;

@property (nonatomic, strong) Player *player;

@end

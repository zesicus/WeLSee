//
//  Player.h
//  We'll see
//
//  Created by Sunny on 12/31/15.
//  Copyright © 2015 Nine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MobileVLCKit/MobileVLCKit.h>
#import <UIKit/UIKit.h>

@interface Player : NSObject

@property (nonatomic, strong) VLCMediaPlayer *player;

- (id)initWithView:(UIView *)playView andMediaPath:(NSString *)path;
- (id)initWithView:(UIView *)playView andMediaURL:(NSURL *)url;

- (void)playMedia;
- (void)stopPlaying;

@end

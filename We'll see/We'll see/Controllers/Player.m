//
//  Player.m
//  We'll see
//
//  Created by Sunny on 12/31/15.
//  Copyright © 2015 Nine. All rights reserved.
//

#import "Player.h"

@implementation Player

- (id)initWithView:(UIView *)playView andMediaPath:(NSString *)path {
    self = [super init];
    if (self) {
        NSArray *options = @[@"--extraintf="];
        _player = [[VLCMediaPlayer alloc] initWithOptions:options];
        _player.drawable = playView;
        VLCMedia *media = [VLCMedia mediaWithPath:path];
        [_player setMedia:media];
    }
    return self;
}

- (id)initWithView:(UIView *)playView andMediaURL:(NSURL *)url {
    self = [super init];
    if (self) {
        NSArray *options = @[@"--extraintf="];
        _player = [[VLCMediaPlayer alloc] initWithOptions:options];
        _player.drawable = playView;
        VLCMedia *media = [VLCMedia mediaWithURL:url];
        [_player setMedia:media];
    }
    return self;
}

- (void)playMedia {
    [_player play];
}

- (void)stopPlaying {
    [_player stop];
}

@end

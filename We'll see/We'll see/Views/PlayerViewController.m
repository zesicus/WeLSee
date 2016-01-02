//
//  PlayerViewController.m
//  We'll see
//
//  Created by Sunny on 12/31/15.
//  Copyright © 2015 Nine. All rights reserved.
//

#import "PlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface PlayerViewController () {
    CGFloat screenWidth;
    CGFloat screenHeight;
    
    CGFloat playerProgress; // 播放进度
    
    // 手势初始X和Y坐标
    CGFloat beginTouchX;
    CGFloat beginTouchY;
    // 手势相对于初始X和Y坐标的偏移量
    CGFloat offsetX;
    CGFloat offsetY;
    
    //是否本地，是本地就把进度条和时间标签隐藏
    BOOL isLocal;
}

@property (nonatomic, strong) UIProgressView *progressBar; //进度条
@property (nonatomic, strong) UILabel *remainingTimeLabel; //剩余时间条
@property (nonatomic, strong) UIButton *playBtn;

@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    //导航栏
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@" ＜＜＜ " style:UIBarButtonItemStylePlain target:self action:@selector(backToTop)];
    self.navigationItem.leftBarButtonItem = leftButton;
    self.navigationItem.title = _playName;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationController.navigationBar.hidden = YES;
    
    //播放键
    _playBtn = [[UIButton alloc] init];
    [_playBtn setImage:[UIImage imageNamed:@"MVLCMovieViewHUDPause_iPhone"] forState:UIControlStateNormal];
    [self.view addSubview:_playBtn];
    [_playBtn setHidden:YES];
    [_playBtn addTarget:self action:@selector(playControl) forControlEvents:UIControlEventTouchUpInside];
    [_playBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_playBtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:25]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_playBtn attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-25]];
    
    //剩余时间label
    _remainingTimeLabel = [[UILabel alloc] init];
    [_remainingTimeLabel setText:@"--:--:--"];
    [_remainingTimeLabel setTextColor:[UIColor whiteColor]];
    [self.view addSubview:_remainingTimeLabel];
    [_remainingTimeLabel setHidden:YES];
    [_remainingTimeLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_remainingTimeLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_remainingTimeLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-27]];
    
    //进度条
    _progressBar = [[UIProgressView alloc] init];
    [_progressBar setProgress:0];
    [self.view addSubview:_progressBar];
    [_progressBar setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_progressBar setHidden:YES];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_progressBar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_playBtn attribute:NSLayoutAttributeRight multiplier:1.0 constant:15]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_progressBar attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_remainingTimeLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-15]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_progressBar attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-35]];
    
    //指示器
    UIActivityIndicatorView *indicatior = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.view addSubview:indicatior];
    [indicatior setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:indicatior attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:indicatior attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    [indicatior startAnimating];
    
    //点击手势
    UITapGestureRecognizer *tapScrn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showControlPanel)];
    tapScrn.numberOfTapsRequired = 1;
    tapScrn.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tapScrn];
    
    //视频播放
    if (_playPath) {
        _player = [[Player alloc] initWithView:self.view andMediaPath:_playPath];
        [_player playMedia];
        isLocal = YES;
    }
    if (_playURL) {
        _player = [[Player alloc] initWithView:self.view andMediaURL:_playURL];
        [_player playMedia];
        isLocal = NO;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //获得屏幕尺寸
    screenWidth = [[UIScreen mainScreen] bounds].size.width;
    screenHeight = [[UIScreen mainScreen] bounds].size.height;
    if (screenHeight > screenWidth) { // 让宽度比高度大，即横屏的宽高
        CGFloat tmp = screenWidth;
        screenWidth = screenHeight;
        screenHeight = tmp;
    }
    
    [_player.player addObserver:self forKeyPath:@"remainingTime" options:0 context:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [_player.player removeObserver:self forKeyPath:@"remainingTime"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 固定方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeLeft;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeLeft;
}

- (BOOL)shouldAutorotate {
    return NO;
}

#pragma mark - VLCMediaPlayerDelegate
//播放剩余时间显示

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    _progressBar.progress = [_player.player position];
    _remainingTimeLabel.text = [[_player.player remainingTime] stringValue];
    
//    NSLog(@"%d", [[_player.player time] intValue]);
}

#pragma mark - touch

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    UITouch *oneTouch = [touches anyObject];
    
    //手指触摸屏幕开始的坐标
    beginTouchX = [oneTouch locationInView:oneTouch.view].x;
    beginTouchY = [oneTouch locationInView:oneTouch.view].y;

}

//滑动快进/快退
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    UITouch *oneTouch = [touches anyObject];
    
    // 手势相对于初始坐标的偏移量
    offsetX = [oneTouch locationInView:oneTouch.view].x - beginTouchX;
    
    if (offsetX != 0) {
        // 中屏幕中间左右滑动改变进度
        if ([_player.player isPlaying] && isLocal) { // 如果视频可以播放才可以调整播放进度
            // 要改变的进度值
            CGFloat deltaProgress = offsetX / screenWidth;
            int progressInSec = (int)(deltaProgress * 300);
            if (progressInSec > 0 && ([[_player.player remainingTime] intValue] + progressInSec * 1000) < 0) {
                [_player.player jumpForward:progressInSec];
            }
            if (progressInSec < 0 && ([[_player.player time] intValue] + progressInSec * 1000) > 0) {
                [_player.player jumpBackward:-progressInSec];
            }
        }
    }
}

#pragma mark -

- (BOOL)prefersStatusBarHidden {
    return true;
}

//显示/关闭 控制面板
- (void)showControlPanel {
    
    [self.view bringSubviewToFront:_playBtn];
    [self.view bringSubviewToFront:_remainingTimeLabel];
    [self.view bringSubviewToFront:_progressBar];
    
    if (_playBtn.isHidden) {
        _playBtn.hidden = NO;
        self.navigationController.navigationBar.hidden = NO;
        if (isLocal) {
            _remainingTimeLabel.hidden = NO;
            _progressBar.hidden = NO;
        }
    } else {
        _playBtn.hidden = YES;
        _remainingTimeLabel.hidden = YES;
        _progressBar.hidden = YES;
        self.navigationController.navigationBar.hidden = YES;
    }
}

- (void)playControl {
    if ([_player.player isPlaying]) {
        [_player.player pause];
        [_playBtn setImage:[UIImage imageNamed:@"MVLCMovieViewHUDPlay_iPhone"] forState:UIControlStateNormal];
    } else {
        [_player.player play];
        [_playBtn setImage:[UIImage imageNamed:@"MVLCMovieViewHUDPause_iPhone"] forState:UIControlStateNormal];
    }
}

- (void)backToTop {
    [_player stopPlaying];
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end

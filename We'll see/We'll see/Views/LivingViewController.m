//
//  LivingViewController.m
//  We'll see
//
//  Created by Sunny on 12/30/15.
//  Copyright © 2015 Nine. All rights reserved.
//

#import "LivingViewController.h"
#import "TVCell.h"
#import "TVSource.h"
#import "PlayerViewController.h"

@interface LivingViewController ()

@end

@implementation LivingViewController

- (DMPagerNavigationBarItem *)pagerItem {
    return _pageObj;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setFrame:CGRectMake(0, 0, 375, 400)];
//    self.view.backgroundColor = [UIColor grayColor];
    
    //AQGridView
    self.gridView = [[AQGridView alloc] initWithFrame:CGRectMake(0, 0, 375, 400)]; //初始化用iPhone6的点阵
    self.gridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.gridView.autoresizesSubviews = YES;
    self.gridView.dataSource = self;
    self.gridView.delegate = self;
    [_gridView setSeparatorStyle:AQGridViewCellSeparatorStyleSingleLine];
    [_gridView setSeparatorColor:[UIColor grayColor]];
    [self.view addSubview:_gridView];
    [_gridView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - AQGridViewDataSource
- (NSUInteger)numberOfItemsInGridView:(AQGridView *)gridView {
    return [TVSource getTVName].count;
}

- (AQGridViewCell *)gridView:(AQGridView *)gridView cellForItemAtIndex:(NSUInteger)index {
    static NSString *identifier = @"PlainCell";
    TVCell *cell = (TVCell *)[gridView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[TVCell alloc] initWithFrame:CGRectMake(0, 0, 125, 130) reuseIdentifier:identifier];
    }
    //上标题图片
    [cell.imageView setImage:[UIImage imageNamed:[TVSource getTVName][index]]];
    [cell.describeLabel setText:[TVSource getTVName][index]];
    return cell;
}

#pragma mark - AQGridViewDelegate implements
- (void)gridView:(AQGridView *)gridView didSelectItemAtIndex:(NSUInteger)index {
    PlayerViewController *pvc = [[PlayerViewController alloc] init];
    NSURL *url = [NSURL URLWithString:[TVSource getTVPath][index]];
    pvc.playURL = url;
    pvc.playName = [TVSource getTVName][index];
    UINavigationController *nvgVC = [[UINavigationController alloc] initWithRootViewController:pvc];
    [_gridView deselectItemAtIndex:index animated:YES];
    [self presentViewController:nvgVC animated:NO completion:nil];
}

- (CGSize)portraitGridCellSizeForGridView:(AQGridView *)gridView {
    return CGSizeMake(125, 130);
}

@end

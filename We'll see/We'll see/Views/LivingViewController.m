//
//  LivingViewController.m
//  We'll see
//
//  Created by Sunny on 12/30/15.
//  Copyright © 2015 Nine. All rights reserved.
//

#import "LivingViewController.h"
#import "TVSource.h"
#import "TVCollectionViewCell.h"
#import "PlayerViewController.h"

#define kScreenFrame [UIScreen mainScreen].bounds
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenScale [UIScreen mainScreen].scale

@interface LivingViewController () <UICollectionViewDelegate, UICollectionViewDataSource> {
    UICollectionView *_collectionView;
}

@end

@implementation LivingViewController

- (DMPagerNavigationBarItem *)pagerItem {
    return _pageObj;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setFrame:CGRectMake(0, 0, 375, 400)];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
    layout.itemSize = CGSizeMake(kScreenWidth/3, kScreenWidth/3);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[TVCollectionViewCell class] forCellWithReuseIdentifier:@"TVCell"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableCellHeader"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [TVSource getTVName].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"TVCell";
    TVCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[TVCollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/3, kScreenWidth/3)];
    }
    [cell sizeToFit];
    [cell.imageView setImage:[UIImage imageNamed:[TVSource getTVName][indexPath.row]]];
    [cell.describeLabel setText:[TVSource getTVName][indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PlayerViewController *pvc = [[PlayerViewController alloc] init];
    NSURL *url = [NSURL URLWithString:[TVSource getTVPath][indexPath.row]];
    pvc.playURL = url;
    pvc.playName = [TVSource getTVName][indexPath.row];
    UINavigationController *nvgVC = [[UINavigationController alloc] initWithRootViewController:pvc];
    [self presentViewController:nvgVC animated:YES completion:nil];
}

@end

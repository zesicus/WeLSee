//
//  LocalViewController.m
//  We'll see
//
//  Created by Sunny on 12/30/15.
//  Copyright © 2015 Nine. All rights reserved.
//

#import "LocalViewController.h"
#import "ReadFile.h"
#import "PlayerViewController.h"

@interface LocalViewController () {
    NSArray *fileNameList;
    NSArray *filePathList;
}

@end

@implementation LocalViewController

- (DMPagerNavigationBarItem *)pagerItem {
    return _pageObj;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg1"]];
    [self.tableView setBackgroundView:bg];
    [self.tableView setOpaque:NO];
    
    //取得Documents文件列表
    ReadFile *readFile = [[ReadFile alloc] init];
    NSDictionary *fileDic = [readFile contentsOfDocuments];
    fileNameList = [fileDic objectForKey:@"fileNames"];
    filePathList = [fileDic objectForKey:@"filePaths"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return fileNameList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    
    cell.textLabel.text = fileNameList[indexPath.row];
    cell.textLabel.textColor = [UIColor colorWithRed:0.000 green:0.235 blue:0.322 alpha:1.000];
    
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *path = [NSString stringWithFormat:@"%@", filePathList[indexPath.row]];
    NSString *name = [NSString stringWithFormat:@"%@", fileNameList[indexPath.row]];
    PlayerViewController *pvc = [PlayerViewController new];
    pvc.playPath = path;
    pvc.playName = name;
    UINavigationController *nvgVC = [[UINavigationController alloc] initWithRootViewController:pvc];
    [self presentViewController:nvgVC animated:NO completion:nil];
}

@end

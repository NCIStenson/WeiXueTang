//
//  ZEDownloadVC.m
//  WeiXueTang
//
//  Created by Stenson on 16/4/5.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import "ZEDownloadVC.h"

#import "ZEDownloadSearchVC.h"
#import "ZELocalFileVC.h"
@interface ZEDownloadVC ()
{
    CALayer * lineLayer;
}
@end

@implementation ZEDownloadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    
    self.title = @"下载/本地";
    [self disableLeftBtn];
    [self initView];
    
    ZEDownloadSearchVC * downloadSearchVC = [[ZEDownloadSearchVC alloc]init];
    [self addChildViewController:downloadSearchVC];
    
    ZELocalFileVC * localFileVC = [[ZELocalFileVC alloc]init];
    [self addChildViewController:localFileVC];
    
    [self.view addSubview:downloadSearchVC.view];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.tintColor = MAIN_NAV_COLOR;
    self.tabBarController.tabBar.hidden = NO;
}

-(void)initView
{
    for (int i = 0; i < 2; i ++) {
        UIButton * downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        downloadBtn.frame =  CGRectMake(0 + SCREEN_WIDTH / 2 * i, NAV_HEIGHT, SCREEN_WIDTH / 2, 38);
        [downloadBtn setTitle:@"课件下载" forState:UIControlStateNormal];
        [downloadBtn setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
        downloadBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [self.view addSubview:downloadBtn];
        downloadBtn.tag = i;
        [downloadBtn addTarget:self action:@selector(changeChildView:) forControlEvents:UIControlEventTouchUpInside];
        if(i == 1){
            [downloadBtn setTitle:@"本地文件" forState:UIControlStateNormal];
        }
    }
    
    CALayer * backgroundLayer = [CALayer layer];
    backgroundLayer.frame = CGRectMake(0, NAV_HEIGHT + 39.0f, SCREEN_WIDTH, 1.0f);
    backgroundLayer.backgroundColor = [MAIN_LINE_COLOR CGColor];
    [self.view.layer addSublayer:backgroundLayer];

    
    lineLayer = [CALayer layer];
    lineLayer.frame = CGRectMake(0, NAV_HEIGHT + 38.0f, SCREEN_WIDTH / 2, 2.0f);
    lineLayer.backgroundColor = [MAIN_COLOR CGColor];
    [self.view.layer addSublayer:lineLayer];
}

-(void)changeChildView:(UIButton *)button
{
    lineLayer.frame = CGRectMake(button.frame.origin.x, NAV_HEIGHT + 38.0f, SCREEN_WIDTH / 2, 2.0f);
    if (button.tag == 0) {
        [self transitionFromViewController:self.childViewControllers[1] toViewController:self.childViewControllers[0] duration:0.29 options:UIViewAnimationOptionCurveLinear animations:^{
        } completion:^(BOOL finished) {
            NSLog(@"transitionFromViewController");
        }];
    }else{
        [self transitionFromViewController:self.childViewControllers[0] toViewController:self.childViewControllers[1] duration:0.29 options:UIViewAnimationOptionCurveLinear animations:^{
        } completion:^(BOOL finished) {
            NSLog(@"transitionFromViewController");
        }];
    }
}

#pragma mark - ZEDownloadViewDelegate
-(void)beginSearch:(NSString *)inputStr
{
    NSLog(@">>>>>   %@",inputStr);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  ZELocalFileVC.m
//  WeiXueTang
//
//  Created by Stenson on 16/4/7.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import "ZELocalFileVC.h"
#import "ZELocalVideoImageVC.h"
@interface ZELocalFileVC ()
{
    ZELocalFileView * localFileView;
}
@end

@implementation ZELocalFileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.userInteractionEnabled = YES;
    
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [localFileView reloadView];
}

-(void)initView
{
    localFileView = [[ZELocalFileView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT + 40.0, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT - 49.0f - 40.0)];
    localFileView.delegate = self;
    [self.view addSubview:localFileView];
}

-(void)goVideoOrImageView:(LOCALFILE_TYPE)fileType
{
    self.tabBarController.tabBar.hidden = YES;
    ZELocalVideoImageVC * videoImageVC = [[ZELocalVideoImageVC alloc]init];
    videoImageVC.fileType = fileType;
    [self.navigationController pushViewController:videoImageVC animated:YES];
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

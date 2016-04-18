//
//  ZELocalFileVC.m
//  WeiXueTang
//
//  Created by Stenson on 16/4/7.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import "ZELocalFileVC.h"

@interface ZELocalFileVC ()

@end

@implementation ZELocalFileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.userInteractionEnabled = NO;
    
    [self initView];
}
-(void)initView
{
    ZELocalFileView * localFileView = [[ZELocalFileView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT + 40.0, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT - 49.0f - 40.0)];
//    localFileView.delegate = self;
    [self.view addSubview:localFileView];
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

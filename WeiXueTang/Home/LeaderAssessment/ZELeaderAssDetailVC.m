//
//  ZELeaderAssDetailVC.m
//  WeiXueTang
//
//  Created by Stenson on 16/5/19.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import "ZELeaderAssDetailVC.h"
#import "ZELeaderAssDetailView.h"
#import "ZEUserServer.h"

@interface ZELeaderAssDetailVC ()<ZELeaderAssDetailViewDelegate>
{
    ZELeaderAssDetailView * leaderDetailV;
}
@end

@implementation ZELeaderAssDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"班组长评估";
    [self initView];
}

-(void)initView
{
    leaderDetailV = [[ZELeaderAssDetailView alloc]initWithFrame:CGRectMake(0.0f, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT) withLeaderAssessmentM:_deatailLeaderAssM];
    leaderDetailV.delegate = self;
    [self.view addSubview:leaderDetailV];
}

#pragma mark - ZELeaderAssDetailViewDelegate

-(void)passAssessment:(ZELeaderAssessmentModel *)mod
{
    [MBProgressHUD showHUDAddedTo:leaderDetailV animated:YES];
    [ZEUserServer leaderAssessmentWithSeqkey:mod.seqkey
                                  withStatus:@"1"
                                     success:^(id data) {
                                         [MBProgressHUD hideHUDForView:leaderDetailV animated:YES];
                                         if ([[data objectForKey:@"flag"] boolValue]) {
                                             [self.navigationController popViewControllerAnimated:YES];
                                         }
                                     } fail:^(NSError *errorCode) {
                                         [MBProgressHUD hideHUDForView:leaderDetailV animated:YES];
                                     }];
}

-(void)refuseAssessment:(ZELeaderAssessmentModel *)mod
{
    [MBProgressHUD showHUDAddedTo:leaderDetailV animated:YES];
    [ZEUserServer leaderAssessmentWithSeqkey:mod.seqkey
                                  withStatus:@"0"
                                     success:^(id data) {
                                         [MBProgressHUD hideHUDForView:leaderDetailV animated:YES];
                                         if ([[data objectForKey:@"flag"] boolValue]) {
                                             [self.navigationController popViewControllerAnimated:YES];
                                         }
                                     } fail:^(NSError *errorCode) {
                                         [MBProgressHUD hideHUDForView:leaderDetailV animated:YES];
                                     }];
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

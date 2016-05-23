//
//  ZELeaderAssessmentVC.m
//  WeiXueTang
//
//  Created by Stenson on 16/5/19.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import "ZELeaderAssessmentVC.h"

#import "ZELeaderAssmessmentView.h"

#import "ZEUserServer.h"

#import "ZELeaderAssDetailVC.h"

@interface ZELeaderAssessmentVC ()<ZELeaderAssmessmentViewDelegate>
{
    ZELeaderAssmessmentView * leaderAssView;
}

@property (nonnull,nonatomic,strong) NSArray * memberArr;

@end

@implementation ZELeaderAssessmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"班组长评估";
    
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self sendRequest];
}
-(void)sendRequest
{
    [MBProgressHUD showHUDAddedTo:leaderAssView animated:YES];
    [ZEUserServer getLeaderAssessmentMessageSuccess:^(id data) {
        [MBProgressHUD hideHUDForView:leaderAssView animated:YES];
        if ([ZEUtil isNotNull:[data objectForKey:@"data"]]) {
            [leaderAssView reloadData:[data objectForKey:@"data"]];
        }
    } fail:^(NSError *errorCode) {
        [MBProgressHUD hideHUDForView:leaderAssView animated:YES];
    }];
}
-(void)initView
{
    leaderAssView = [[ZELeaderAssmessmentView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT)];
    leaderAssView.delegate = self;
    [self.view addSubview:leaderAssView];
}

#pragma mark - ZELeaderAssmessmentViewDelegate

-(void)didSelectLeaderAssess:(ZELeaderAssessmentModel *)leaderAssessM
{
    ZELeaderAssDetailVC * leaderAssDetailVC = [[ZELeaderAssDetailVC alloc]init];
    leaderAssDetailVC.deatailLeaderAssM = leaderAssessM;
    [self.navigationController pushViewController:leaderAssDetailVC animated:YES];
}

-(void)showAllTeamMember{
    if (self.memberArr.count > 0) {
        [leaderAssView showAllTeamMember:self.memberArr];
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:leaderAssView animated:YES];
    [ZEUserServer getTeamAssessmentMemberSuccess:^(id data) {
        [MBProgressHUD hideHUDForView:leaderAssView animated:YES];
        if ([ZEUtil isNotNull:[data objectForKey:@"data"]] && [[data objectForKey:@"flag"] boolValue]) {
            self.memberArr = [data objectForKey:@"data"];
            [leaderAssView showAllTeamMember:[data objectForKey:@"data"]];
        }
    } fail:^(NSError *errorCode) {
        [MBProgressHUD hideHUDForView:leaderAssView animated:YES];
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

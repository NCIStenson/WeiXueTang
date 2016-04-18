//
//  ZEPersonalSkillVC.m
//  WeiXueTang
//
//  Created by Stenson on 16/3/29.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import "ZEPersonalSkillVC.h"
#import "ZEUserServer.h"
#import "ZESkillViewController.h"

@interface ZEPersonalSkillVC ()
{
    ZEPersonalSkillView * _perSkillView;
}
@end

@implementation ZEPersonalSkillVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人技能库";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initView];
    [self sendRequest];
}
-(void)initView
{
    _perSkillView = [[ZEPersonalSkillView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _perSkillView.delegate = self;
    [self.view addSubview:_perSkillView];
    [self.view sendSubviewToBack:_perSkillView];
}
-(void)sendRequest
{
    [self progressBegin:nil];
    [ZEUserServer getPersonalCourseSuccess:^(id data) {
        [_perSkillView contentViewReloadData:[data objectForKey:@"data"]];
        [self progressEnd:nil];
    } fail:^(NSError *errorCode) {
        [self progressEnd:nil];
    }];
}

#pragma mark - ZEPersonalSkillViewDelegate

-(void)skillSelf:(ZEPersonalSkillView *)skillView withID:(NSString *)skillID
{
    [self progressBegin:nil];
    [ZEUserServer skillSelfSkillID:skillID success:^(id data) {
        [self progressEnd:nil];
    } fail:^(NSError *errorCode) {
        [self progressEnd:nil];
    }];
}

-(void)enterSkillFileVC:(NSString *)filePath
{
    ZESkillViewController * skillVC = [[ZESkillViewController alloc]init];
    skillVC.filePath = filePath;
    skillVC.enterType = ENTER_FILELIST_TYPE_SELFSKILL;
    [self.navigationController pushViewController:skillVC animated:YES];
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

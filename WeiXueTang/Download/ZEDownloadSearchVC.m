//
//  ZEDownloadSearchVC.m
//  WeiXueTang
//
//  Created by Stenson on 16/4/7.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import "ZEDownloadSearchVC.h"
#import "ZEUserServer.h"
#import "MBProgressHUD.h"
#import "ZEChildTeamFileVC.h"
#import "ZELocalFileVC.h"
@interface ZEDownloadSearchVC ()
{
    ZEDownloadSearchView * downloadSearchView;
}
@end

@implementation ZEDownloadSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.userInteractionEnabled = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initView];
    
    [self sendRequest];
}
-(void)sendRequest
{
    [MBProgressHUD showHUDAddedTo:downloadSearchView animated:YES];
    [ZEUserServer getAllCourseSuccess:^(id data) {
        [MBProgressHUD hideHUDForView:downloadSearchView animated:YES];
        if ([ZEUtil isNotNull:[data objectForKey:@"data"]]) {
            [downloadSearchView contentViewReloadData:[data objectForKey:@"data"]];
        }
    } fail:^(NSError *errorCode) {
        [MBProgressHUD hideHUDForView:downloadSearchView animated:YES];
    }];
}

-(void)initView
{
    downloadSearchView = [[ZEDownloadSearchView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT + 40.0, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT - 49.0f - 40.0)];
    downloadSearchView.delegate = self;
    [self.view addSubview:downloadSearchView];
}

#pragma mark - ZEDownloadSearchViewDelegate
-(void)beginSearch:(NSString *)inputStr
{
    if(![ZEUtil isStrNotEmpty:inputStr]){
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"请输入关键搜索字符" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    self.tabBarController.tabBar.hidden = YES;
    ZEChildTeamFileVC * childTeamFile = [[ZEChildTeamFileVC alloc]init];
    childTeamFile.searchStr = inputStr;
    childTeamFile.enterType = DOWNLOADFILE_TYPE_SEARCH;
    [self.navigationController pushViewController:childTeamFile animated:YES];
}

-(void)goChildTeamWithPath:(NSString *)filePath withFileName:(NSString *)fileName
{
    self.tabBarController.tabBar.hidden = YES;
    ZEChildTeamFileVC * childFileVC = [[ZEChildTeamFileVC alloc]init];
    childFileVC.childFilePath = filePath;
    childFileVC.fatherFileName = fileName;
    childFileVC.enterType = DOWNLOADFILE_TYPE_DEFAULT;
    [self.navigationController pushViewController:childFileVC animated:YES];
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

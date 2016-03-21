//
//  ZEToolKitViewController.m
//  WeiXueTang
//
//  Created by Stenson on 16/3/7.
//  Copyright © 2016年  Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import "ZEToolKitViewController.h"
#import "ZEUserServer.h"

#import "ZESkillViewController.h"

@interface ZEToolKitViewController ()
{
    ZEToolKitView * _toolKitView;
}
@end

@implementation ZEToolKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"工具包"];
    [self initView];
    [self sendRequest];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

-(void)initView
{
    _toolKitView = [[ZEToolKitView alloc]initWithFrame:CGRectMake(0, 64.0f, SCREEN_WIDTH, SCREEN_HEIGHT - 64.0f)];
    _toolKitView.delegate = self;
    [self.view addSubview:_toolKitView];
}

-(void)sendRequest
{
    [self progressBegin:nil];
    [ZEUserServer getToolKitListSuccess:^(id data) {
        if ([ZEUtil isNotNull:[data objectForKey:@"data"]]) {
            [_toolKitView contentViewReloadData:[data objectForKey:@"data"]];
        }
        [self progressEnd:nil];
    } fail:^(NSError *errorCode) {
        NSLog(@"%@",errorCode);
        [self progressEnd:nil];
    }];
}

#pragma mark - SuperMethod

-(void)leftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - ZEToolKitViewDelegate
-(void)selectToolKitWithSkillID:(NSString *)skillID
{
    ZESkillViewController * skillVC = [[ZESkillViewController alloc]init];
    skillVC.skillID = skillID;
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

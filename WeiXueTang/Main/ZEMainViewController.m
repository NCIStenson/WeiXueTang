//
//  ZEMainViewController.m
//  NewCentury
//
//  Created by Stenson on 16/1/20.
//  Copyright © 2016年  Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import "ZEMainViewController.h"

#import "ZEToolKitViewController.h"
#import "ZEDianZanViewController.h"
#import "ZEExpertAssessmentVC.h"
@interface ZEMainViewController ()
{

}
@end

@implementation ZEMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    [self initView];
}

-(void)initView
{
    ZEMainView * mainView = [[ZEMainView alloc]initWithFrame:self.view.frame];
    mainView.delegate = self;
    [self.view addSubview:mainView];
}

#pragma mark - ZEMainViewDelegate

-(void)goToolKitView
{
    ZEToolKitViewController * toolKitVC = [[ZEToolKitViewController alloc]init];
    [self.navigationController pushViewController:toolKitVC animated:YES];
}

-(void)goDianZanView
{
    ZEDianZanViewController * dianZanVC = [[ZEDianZanViewController alloc]init];
    [self.navigationController pushViewController:dianZanVC animated:YES];
}

-(void)gozhuanjiaAssessmentView
{
    ZEExpertAssessmentVC * expertAssVC = [[ZEExpertAssessmentVC alloc]init];
    [self.navigationController pushViewController:expertAssVC animated:YES];
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

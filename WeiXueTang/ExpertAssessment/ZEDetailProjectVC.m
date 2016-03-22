
//
//  ZEDetailProjectVC.m
//  WeiXueTang
//
//  Created by Stenson on 16/3/22.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import "ZEDetailProjectVC.h"

@interface ZEDetailProjectVC ()

@end

@implementation ZEDetailProjectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.expertAssM.detail_PROJECTNAME;
    [self.titleLabel setAdjustsFontSizeToFitWidth:YES];
    [self initView];
}

-(void)initView
{
    ZEDetailProjectView * projectView = [[ZEDetailProjectView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT) withModel:_expertAssM];
    [self.view addSubview:projectView];
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

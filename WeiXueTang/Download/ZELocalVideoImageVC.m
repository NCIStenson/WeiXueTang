//
//  ZELocalVideoImageVC.m
//  WeiXueTang
//
//  Created by Stenson on 16/4/18.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import "ZELocalVideoImageVC.h"

@interface ZELocalVideoImageVC ()

@end

@implementation ZELocalVideoImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@">>>  %d",_fileType);
    self.view.backgroundColor = [UIColor whiteColor];
    if (_fileType == LOCALFILE_TYPE_VIDEO) {
        self.title = @"本地视频";
    }else{
        self.title = @"本地图片";
    }
    
    [self initView];
}

-(void)initView
{
    ZELocalVideoImageView * localVideoView = [[ZELocalVideoImageView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT) withFileType:_fileType];
    [self.view addSubview:localVideoView];
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

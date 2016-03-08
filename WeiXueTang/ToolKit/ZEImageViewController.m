//
//  ZEImageViewController.m
//  WeiXueTang
//
//  Created by Stenson on 16/3/8.
//  Copyright © 2016年 Stenson. All rights reserved.
//

#import "ZEImageViewController.h"
#import "ZEImageView.h"

@interface ZEImageViewController ()

@end

@implementation ZEImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"1/1";
    
    [self initView];
}

-(void)initView
{
    ZEImageView * imageView = [[ZEImageView alloc]initWithFrame:CGRectMake(0, 64.0f, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:imageView];
    [imageView reloadView:self.pngPageNum pngFielPath:self.filePath pngType:self.pngType];
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

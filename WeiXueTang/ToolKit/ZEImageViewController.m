//
//  ZEImageViewController.m
//  WeiXueTang
//
//  Created by Stenson on 16/3/8.
//  Copyright © 2016年 Stenson. All rights reserved.
//

#import "ZEImageViewController.h"

@interface ZEImageViewController ()

@end

@implementation ZEImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [NSString stringWithFormat:@"1 / %@",_pngPageNum];
    
    [self initView];
}

-(void)initView
{
    ZEImageView * imageView = [[ZEImageView alloc]initWithFrame:CGRectMake(0, 64.0f, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:imageView];
    imageView.delegate = self;
    [imageView reloadView:self.pngPageNum pngFielPath:self.filePath pngType:self.pngType];
}
#pragma mark - ZEImageViewDelegate
-(void)collectionViewDidEndDecelerating:(NSString *)currentPage
{
    self.title = [NSString stringWithFormat:@"%@ / %@",currentPage,_pngPageNum];
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

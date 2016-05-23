//
//  ZELocalVideoImageVC.m
//  WeiXueTang
//
//  Created by Stenson on 16/4/18.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import "ZELocalVideoImageVC.h"
#import "JRPlayerViewController.h"
#import "SDPhotoBrowser.h"
@interface ZELocalVideoImageVC ()<SDPhotoBrowserDelegate>

@property (nonatomic,strong) NSMutableArray * downloadImageArr;

@end

@implementation ZELocalVideoImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    localVideoView.delegate = self;
    [self.view addSubview:localVideoView];
}

#pragma mark - localVideoViewDelegate

-(void)playLocalVideoWithPath:(NSString *)videoPath
{
    NSString * escapedUrlString = [videoPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * urlStr  = [NSURL URLWithString:[NSString stringWithFormat:@"file://%@",escapedUrlString]];
    JRPlayerViewController * playView = [[JRPlayerViewController alloc]initWithLocalMediaURL:urlStr];
    [self presentViewController:playView animated:YES completion:^{
        [playView play:nil];
    }];
}

-(void)loadLocalImageWithPath:(NSString *)imagePath withIndex:(NSInteger)index withImagePathArr:(NSArray *)imagePathArr
{
    self.downloadImageArr = [NSMutableArray arrayWithCapacity:imagePathArr.count];

    for (int i = 0; i < imagePathArr.count; i ++){
        NSString * str = [imagePath stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%d.",index + 1] withString:[NSString stringWithFormat:@"%d.",i+1]];
        [self.downloadImageArr addObject:str];
    }
    
    SDPhotoBrowser *browser           = [[SDPhotoBrowser alloc] init];
    browser.delegate                  = self;
    browser.sourceImagesContainerView = self.view;
    browser.imageCount                = self.downloadImageArr.count;
    browser.currentImageIndex         = index;
    [browser show];
}
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *imageName = nil;
    imageName           = self.downloadImageArr[index];
    NSURL *url          = [NSURL URLWithString:imageName];
    return url;
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImage * image = [UIImage imageWithContentsOfFile:self.downloadImageArr[index]];
    return image;
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

//
//  ZESkillViewController.m
//  WeiXueTang
//
//  Created by Stenson on 16/3/7.
//  Copyright © 2016年  Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import "ZESkillViewController.h"
#import "JRPlayerViewController.h"
#import "ZEUserServer.h"

#import "ZEImageViewController.h"

@interface ZESkillViewController ()
{
    ZESkillView * _skillView;
}

@property (nonatomic,retain) NSMutableArray * photosArr;
@end

@implementation ZESkillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"课件";
    [self sendRequest];
    [self initView];
}

-(void)initView
{
    _skillView          = [[ZESkillView alloc]initWithFrame:CGRectMake(0, 64.0f, SCREEN_WIDTH, SCREEN_HEIGHT - 64.0f)];
    [self.view addSubview:_skillView];
    _skillView.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kUnzipSuccess) name:KDOWNLOADSUCCESS object:nil];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KDOWNLOADSUCCESS object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}
-(void)sendRequest
{
    [self progressBegin:nil];
    [ZEUserServer getCoursewareList:_skillID success:^(id data) {
        if ([ZEUtil isNotNull:[data objectForKey:@"data"]]) {
            [_skillView contentViewReloadData:[data objectForKey:@"data"]];
        }
        [self progressEnd:nil];
    } fail:^(NSError *errorCode) {
        [self progressEnd:nil];
    }];
}

#pragma mark - 解压成功
-(void)kUnzipSuccess
{
    [_skillView contentViewReload];
}

#pragma mark - ZESkillViewDelegate

-(void)playCourswareVideo:(NSString *)filepath
{
    NSString *str = [filepath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * urlStr = [NSURL URLWithString:str];
    JRPlayerViewController * playView = [[JRPlayerViewController alloc]initWithHTTPLiveStreamingMediaURL:urlStr];
    [self presentViewController:playView animated:YES completion:^{
                [playView play:nil];
    }];

}
-(void)playCourswareImagePath:(NSString *)filepath withType:(NSString *)pngType withPageNum:(NSString *)pageNum
{
    self.photosArr = [NSMutableArray array];
    for(int i = 0; i < [pageNum integerValue]; i ++){
        NSString *str                = [[NSString stringWithFormat:@"%@/\%ld%@",filepath,(long)i + 1,pngType] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [self.photosArr addObject:str];
    }
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.currentImageIndex = 0;
    browser.sourceImagesContainerView = self.view;
    browser.imageCount = self.photosArr.count;
    browser.delegate = self;
    [browser show];
}

-(void)downloadImagesWithUrlPath:(NSString *)urlPath
                       cachePath:(NSString *)cachePath
                    progressView:(ZEProgressView *)progressView
{
    NSString *str = [[NSString stringWithFormat:@"%@.zip",urlPath] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [ZEServerEngine downloadImageZipFromURL:str
                                  cachePath:cachePath
                               withProgress:^(CGFloat progress) {
                                   dispatch_async(dispatch_get_main_queue(), ^{
                                       [progressView setProgress:progress];
                                   });
                               } completion:^(NSString *filePath) {
                                   NSLog(@">>>  %@",filePath);
                               } onError:^(NSError *error) {
                                   
                               }];
    
}

-(void)downloadVideosWithUrlPath:(NSString *)urlPath
                       cachePath:(NSString *)cachePath
                        fileName:(NSString *)fileName
                    progressView:(ZEProgressView *)progressView
{
    NSString *str = [[NSString stringWithFormat:@"%@.mp4",urlPath] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@" str   》》》   %@",str);
    [ZEServerEngine downloadVideoFromURL:str
                                fileName:fileName
                               cachePath:cachePath
                            withProgress:^(CGFloat progress) {
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    [progressView setProgress:progress];
                                    if (progress == 1) {
                                        [_skillView contentViewReload];
                                    }
                                });
                            } completion:^(NSURL *filePath) {
                                NSLog(@"下载完成");
                            } onError:^(NSError *error) {
                                NSLog(@"%@",error);
                            }];
}




#pragma mark - SDPhotoBrowserDelegate

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *imageName = self.photosArr[index];
    NSURL *url = [NSURL URLWithString:imageName];
    return url;
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return [UIImage imageNamed:@"timeline_image_loading.png"];
}


#pragma mark - SuperMethod

-(void)leftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end

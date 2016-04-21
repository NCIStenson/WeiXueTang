//
//  ZEChildTeamFileVC.m
//  WeiXueTang
//
//  Created by Stenson on 16/4/19.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import "ZEChildTeamFileVC.h"
#import "ZEUserServer.h"
#import "MBProgressHUD.h"
#import "JRPlayerViewController.h"
@interface ZEChildTeamFileVC ()
{
    ZEChildTeamFileView * childTeamView;
}
@property (nonatomic,retain) NSMutableArray * photosArr;

@end

@implementation ZEChildTeamFileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.userInteractionEnabled = YES;
    [self initView];
    
    if (_enterType == DOWNLOADFILE_TYPE_DEFAULT) {
        self.title = _fatherFileName;
        [self sendChildTeamFileVCRequest];
    }else{
        [self sendSearchCourseRequest];
        self.title = @"搜索记录";
    }
}
-(void)dealloc
{
    self.photosArr = nil;
    childTeamView = nil;
    NSLog( @">>>   释放了" );
}
-(void)initView
{
    childTeamView = [[ZEChildTeamFileView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT)];
    childTeamView.delegate = self;
    [self.view addSubview:childTeamView];
}

-(void)sendChildTeamFileVCRequest
{
    [MBProgressHUD showHUDAddedTo:childTeamView animated:YES];
    [ZEUserServer getteamfilechild:_childFilePath
                           success:^(id data) {
                               NSLog(@" getteamfilechild >>>  %@ ",data);
                               [MBProgressHUD hideAllHUDsForView:childTeamView animated:YES];
                               if ([ZEUtil isNotNull:[data objectForKey:@"data"]]) {
                                   [childTeamView contentViewReloadData:[data objectForKey:@"data"]];
                               }
    }
                              fail:^(NSError *errorCode) {
                                  [MBProgressHUD hideAllHUDsForView:childTeamView animated:YES];
    }];
}

-(void)sendSearchCourseRequest{
    [MBProgressHUD showHUDAddedTo:childTeamView animated:YES];
    [ZEUserServer findcourseWithStr:_searchStr
                           success:^(id data) {
                               NSLog(@" getteamfilechild >>>  %@ ",data);
                               [MBProgressHUD hideAllHUDsForView:childTeamView animated:YES];
                               if ([ZEUtil isNotNull:[data objectForKey:@"data"]] &&  [[data objectForKey:@"data"] count] > 0) {
                                   [childTeamView contentViewReloadData:[data objectForKey:@"data"]];
                               }else{
                                   UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"没有该字符搜索结果" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                   [alertView show];
                               }
                           }
                              fail:^(NSError *errorCode) {
                                  [MBProgressHUD hideAllHUDsForView:childTeamView animated:YES];
                              }];
}

#pragma mark - ZEChildTeamFileViewDelegate
-(void)goChildTeamWithPath:(NSString *)filePath withFileName:(NSString *)fileName
{
    ZEChildTeamFileVC * fileVC = [[ZEChildTeamFileVC alloc]init];
    fileVC.childFilePath = filePath;
    fileVC.fatherFileName = fileName;
    [self.navigationController pushViewController:fileVC animated:YES];
}
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

-(void)downloadImagesWithFileName:(NSString *)fileName
                          urlPath:(NSString *)urlPath
                        cachePath:(NSString *)cachePath
                     progressView:(ZEProgressView *)progressView
{
    NSString *str = [[NSString stringWithFormat:@"%@.zip",urlPath] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [ZEServerEngine downloadImageZipFromURL:str
                           noSuffixFileName:fileName
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
    [ZEServerEngine downloadVideoFromURL:str
                                fileName:fileName
                               cachePath:cachePath
                            withProgress:^(CGFloat progress) {
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    [progressView setProgress:progress];
                                    if (progress == 1) {
                                        [childTeamView contentViewReloadData:nil];
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


@end


//
//  ZEChildTeamFileView.h
//  WeiXueTang
//
//  Created by Stenson on 16/4/19.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZEProgressView.h"

@class ZEChildTeamFileView;
@protocol ZEChildTeamFileViewDelegate <NSObject>
/**
 *  @author Zenith Electronic Technology Co., Ltd., 16-04-19 16:04:56
 *
 *  前往子目录
 *
 *  @param filePath 文件路径
 *  @param fileName 父文件名
 */
-(void)goChildTeamWithPath:(NSString *)filePath withFileName:(NSString *)fileName;
/**
 *  @author Stenson, 16-03-08 14:03:36
 *
 *  播放课件视频
 *
 *  @param filepath 文件路径
 */
-(void)playCourswareVideo:(NSString *)filepath;
/**
 *  @author Stenson, 16-03-08 14:03:24
 *
 *  展示课件图片
 *
 *  @param filepath 文件路径
 *  @param pngType  文件图片类型（docx，pdf）
 *  @param pageNum  图片数量（文件默认从1开始）
 */
-(void)playCourswareImagePath:(NSString *)filepath withType:(NSString *)pngType withPageNum:(NSString *)pageNum;

/**
 *  @author Stenson, 16-03-11 14:03:36
 *
 *  下载视频
 *
 *  @param videoPath 视频路径
 */
-(void)downloadVideosWithUrlPath:(NSString *)urlPath cachePath:(NSString *)cachePath fileName:(NSString *)fileName progressView:(ZEProgressView *)progressView;
/**
 *  @author Stenson, 16-03-11 14:03:36
 *
 *  下载图片
 *
 *  @param fileName  图片路径
 *  @param videoPath 图片路径
 *  @param cachePath 沙盒路径
 */
-(void)downloadImagesWithFileName:(NSString*)fileName urlPath:(NSString *)urlPath cachePath:(NSString *)cachePath progressView:(ZEProgressView *)progressView;
/**
 *  @author Zenith Electronic Technology Co., Ltd., 16-04-22 14:04:03
 *
 *  播放本地视频文件
 *
 *  @param videoPath 文件路径
 */
-(void)playLocalVideoFile:(NSString *)videoPath;

/**
 *  @author Zenith Electronic Technology Co., Ltd., 16-04-22 16:04:17
 *
 *  加载本地图片文件
 *
 *  @param imagePath 图片路径
 */
-(void)loadLocalImageFile:(NSString *)imagePath withType:(NSString *)pngType withPageNum:(NSString *)pageNum;


@end

@interface ZEChildTeamFileView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) id <ZEChildTeamFileViewDelegate>delegate;
-(void)contentViewReloadData:(NSArray *)arr;
-(void)contentViewReload;

@end

//
//  ZELocalVideoImageView.h
//  WeiXueTang
//
//  Created by Stenson on 16/4/18.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZELocalVideoImageView;
@protocol ZELocalVideoImageViewDelegate <NSObject>

/**
 *  @author Zenith Electronic Technology Co., Ltd., 16-04-25 11:04:36
 *
 *  播放本地视频文件
 *
 *  @param videoPath 视频文件路径
 */
-(void)playLocalVideoWithPath:(NSString *)videoPath;


/**
 *  @author Zenith Electronic Technology Co., Ltd., 16-04-25 11:04:33
 *
 *  加载本地图片文件
 *
 *  @param imagePath 图片文件路径
 */
-(void)loadLocalImageWithPath:(NSString *)imagePath;

@end

@interface ZELocalVideoImageView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)id <ZELocalVideoImageViewDelegate> delegate;
-(id)initWithFrame:(CGRect)frame withFileType:(LOCALFILE_TYPE)fileType;

@end

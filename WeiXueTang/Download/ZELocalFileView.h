//
//  ZELocalFileView.h
//  WeiXueTang
//
//  Created by Stenson on 16/4/7.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZELocalFileView;

@protocol ZELocalFileViewDelegate <NSObject>

/**
 *  @author Zenith Electronic Technology Co., Ltd., 16-04-18 11:04:20
 *
 *  从下载文件中进入本地文件预览
 *
 *  @param fileType 视频或者图片
 */
-(void)goVideoOrImageView:(LOCALFILE_TYPE)fileType;

@end

@interface ZELocalFileView : UIView

@property (nonatomic,weak) id <ZELocalFileViewDelegate> delegate;

-(id)initWithFrame:(CGRect)rect;

-(void)reloadView;

@end

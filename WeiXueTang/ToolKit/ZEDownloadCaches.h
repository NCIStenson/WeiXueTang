//
//  ZEDownloadCaches.h
//  WeiXueTang
//
//  Created by Stenson on 16/3/14.
//  Copyright © 2016年  Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZEProgressView.h"
@interface ZEDownloadCaches : NSObject

+ (ZEDownloadCaches*)instance;

/**
 *  添加下载任务缓存
 */
-(void)setCurrentDownloadTasks:(NSString *)filePath loadView:(ZEProgressView *)progressView;

@end

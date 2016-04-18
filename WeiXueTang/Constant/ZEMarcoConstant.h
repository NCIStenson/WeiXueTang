//
//  ZEMarcoConstant.h
//  NewCentury
//
//  Created by Stenson on 16/1/20.
//  Copyright © 2016年  Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import "UIImage+ZEImage.h"

#ifndef ZEMarcoConstant_h
#define ZEMarcoConstant_h

#define IS_IOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0
#define IS_IOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0

#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH     [[UIScreen mainScreen] bounds].size.width
#define NAV_HEIGHT      64.0f
#define kAspect         (750.0f / SCREEN_HEIGHT)
#define FRAME_WIDTH     [[UIScreen mainScreen] applicationFrame].size.width
#define FRAME_HEIGHT    [[UIScreen mainScreen] applicationFrame].size.height
#define IPHONE5_MORE     ([[UIScreen mainScreen] bounds].size.height > 480)
#define IPHONE4S_LESS    ([[UIScreen mainScreen] bounds].size.height <= 480)
#define IPHONE5     ([[UIScreen mainScreen] bounds].size.height == 568)
#define IPHONE6_MORE     ([[UIScreen mainScreen] bounds].size.height > 568)
#define IPHONE6     ([[UIScreen mainScreen] bounds].size.height == 667)
#define IPHONE6P     ([[UIScreen mainScreen] bounds].size.height == 736)

#define HTTPMETHOD_GET @"GET"
#define HTTPMETHOD_POST @"POST"

/************ 下载成功通知 **************/
#define KDOWNLOADSUCCESS  @"keyDownloadSuccess"
/************ 修改专家评估分数成功通知 **************/
#define KCHANGEEXPERTASSESSMENTSCORESUCCESS  @"keyChangeScore"
/************ 缓存数组最大容量 **************/
#define kCACHESARRMAXCOUNT 100

#define Zenith_Server [[[NSBundle mainBundle] infoDictionary] objectForKey:@"ZenithServerAddress"]
#define CACHEPATH [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(), [ZEUtil getmd5WithString:[ZEUtil getUsername]]]

//文件下载缓存在存放的plist文件中
#define DOWNLOADFILEPATH [NSString stringWithFormat:@"%@/downloadFile.plist",CACHEPATH]
//  服务器图片地址
#define PRE_PHOTO [NSString stringWithFormat:@"%@/file/photo/",Zenith_Server]

//  下载到本地的文件缓存 key 值

#define kImageCachePath @"imageCachePath"
#define kImageCacheName @"imageCacheName"
#define kImageCacheArr  @"imageCacheArr"

#define kVideoCachePath @"videoCachePath"
#define kVideoCacheName @"videoCacheName"

#endif /* ZEMarcoConstant_h */

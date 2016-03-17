//
//  ZEDownloadCaches.m
//  WeiXueTang
//
//  Created by Stenson on 16/3/14.
//  Copyright © 2016年 Stenson. All rights reserved.
//

#import "ZEDownloadCaches.h"

@interface ZEDownloadCaches ()

@property (nonatomic,retain) NSMutableArray * downloadTask;

@end

@implementation ZEDownloadCaches

static ZEDownloadCaches * downloadCaches = nil;

-(id)initSingle
{
    self = [super init];
    if (self) {
        //        self.optionDic = [NSMutableDictionary dictionary];
    }
    return self;
}

-(id)init
{
    return [ZEDownloadCaches instance];
}

+(ZEDownloadCaches *)instance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        downloadCaches = [[ZEDownloadCaches alloc] initSingle];
    });
    return downloadCaches;
}


#pragma mark - 添加下载任务



@end

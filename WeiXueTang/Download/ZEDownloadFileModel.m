//
//  ZEDownloadFileModel.m
//  WeiXueTang
//
//  Created by Stenson on 16/4/19.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import "ZEDownloadFileModel.h"

static ZEDownloadFileModel * downloadFileM = nil;

@implementation ZEDownloadFileModel

+(ZEDownloadFileModel *)getDetailWithDic:(NSDictionary *)dic
{
    downloadFileM = [[ZEDownloadFileModel alloc]init];
    downloadFileM.filename = [dic objectForKey:@"filename"];
    downloadFileM.filepath = [dic objectForKey:@"filepath"];
    downloadFileM.filesize = [dic objectForKey:@"filesize"];
    downloadFileM.filetype = [dic objectForKey:@"filetype"];
    downloadFileM.pngnum = [dic objectForKey:@"pngnum"];
    downloadFileM.pngtype = [dic objectForKey:@"pngtype"];
    
    return downloadFileM;
}

@end

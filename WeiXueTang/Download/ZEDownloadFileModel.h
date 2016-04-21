//
//  ZEDownloadFileModel.h
//  WeiXueTang
//
//  Created by Stenson on 16/4/19.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZEDownloadFileModel : NSObject

@property (nonatomic,copy) NSString * filename;
@property (nonatomic,copy) NSString * filepath;
@property (nonatomic,copy) NSString * filesize;
@property (nonatomic,copy) NSString * filetype;
@property (nonatomic,copy) NSString * pngnum;
@property (nonatomic,copy) NSString * pngtype;

+(ZEDownloadFileModel *)getDetailWithDic:(NSDictionary *)dic;

@end

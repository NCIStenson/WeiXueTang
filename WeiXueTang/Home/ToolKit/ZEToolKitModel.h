//
//  ZEToolKitModel.h
//  WeiXueTang
//
//  Created by Stenson on 16/3/7.
//  Copyright © 2016年  Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZEToolKitModel : NSObject

/*********  技术名称  *********/
@property (nonatomic,copy) NSString * SKILL_NAME;
/*********  技术ID  *********/
@property (nonatomic,copy) NSString * SEQKEY;


/*********  文件名  *********/
@property (nonatomic,copy) NSString * filename;
/*********  文件路径  *********/
@property (nonatomic,copy) NSString * filepath;
/*********  文件大小  *********/
@property (nonatomic,copy) NSString * filesize;
/*********  文件类型  *********/
@property (nonatomic,copy) NSString * filetype;
/*********  图片类型  *********/
@property (nonatomic,copy) NSString * pngtype;
/*********  图片数量  *********/
@property (nonatomic,copy) NSString * pngnum;



+(ZEToolKitModel *)getDetailWithDic:(NSDictionary *)dic;

@end

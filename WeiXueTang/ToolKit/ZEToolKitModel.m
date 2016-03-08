//
//  ZEToolKitModel.m
//  WeiXueTang
//
//  Created by Stenson on 16/3/7.
//  Copyright © 2016年 Stenson. All rights reserved.
//

#import "ZEToolKitModel.h"

static ZEToolKitModel * toolKitM = nil;

@implementation ZEToolKitModel

+(ZEToolKitModel *)getDetailWithDic:(NSDictionary *)dic
{
    toolKitM = [[ZEToolKitModel alloc]init];
    
    toolKitM.SKILL_NAME = [dic objectForKey:@"SKILL_NAME"];
    toolKitM.SEQKEY     = [dic objectForKey:@"SEQKEY"];
    
    toolKitM.filename = [dic objectForKey:@"filename"];
    toolKitM.filepath = [dic objectForKey:@"filepath"];
    toolKitM.filesize = [dic objectForKey:@"filesize"];
    toolKitM.filetype = [dic objectForKey:@"filetype"];
    toolKitM.pngtype  = [dic objectForKey:@"pngtype"];
    toolKitM.pngnum   = [dic objectForKey:@"pngnum"];
    
    return toolKitM;
}

@end


//
//  ZEExpertAssModel.m
//  WeiXueTang
//
//  Created by Stenson on 16/3/21.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import "ZEExpertAssModel.h"

@implementation ZEExpertAssModel

static ZEExpertAssModel * expertAssM = nil;
+ (ZEExpertAssModel *)getDetailModelWithDic:(NSDictionary *)dic
{
    expertAssM            = [[ZEExpertAssModel alloc]init];

    expertAssM.ORGCODE    = [dic objectForKey:@"ORGCODE"];
    expertAssM.ORGNAME    = [dic objectForKey:@"ORGNAME"];
    expertAssM.POINTS     = [dic objectForKey:@"POINTS"];
    expertAssM.POSCODE    = [dic objectForKey:@"POSCODE"];
    expertAssM.PSNNAME    = [dic objectForKey:@"PSNNAME"];
    expertAssM.SKILLID    = [dic objectForKey:@"SKILLID"];
    expertAssM.SKILL_NAME = [dic objectForKey:@"SKILL_NAME"];
    expertAssM.STATE      = [dic objectForKey:@"STATE"];
    
    expertAssM.detailarray = [[dic objectForKey:@"detailarray"] objectForKey:@"data"];
    
    expertAssM.detail_ITEMS       = [dic objectForKey:@"ITEMS"];
    expertAssM.detail_MARKS       = [dic objectForKey:@"MARKS"];
    expertAssM.detail_EXPERTSCORE = [dic objectForKey:@"EXPERTSCORE"];
    expertAssM.detail_QUALITY     = [dic objectForKey:@"QUALITY"];
    expertAssM.detail_PROJECTNAME = [dic objectForKey:@"PROJECTNAME"];
    expertAssM.detail_ITEMS       = [dic objectForKey:@"ITEMS"];
    expertAssM.detail_BENCHMARK   = [dic objectForKey:@"BENCHMARK"];

    
    return expertAssM;
}

@end

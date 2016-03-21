
//
//  ZEDianZanModel.m
//  WeiXueTang
//
//  Created by Stenson on 16/3/17.
//  Copyright © 2016年  Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import "ZEDianZanModel.h"

@implementation ZEDianZanModel

static ZEDianZanModel * _dianZanM = nil;

+(instancetype) getDetailWithDic:(NSDictionary *)dic
{
    _dianZanM             = [[ZEDianZanModel alloc]init];
    
    _dianZanM.perSkill    = [dic objectForKey:@"perSkill"];
    _dianZanM.teamSkill   = [dic objectForKey:@"teamSkill"];
    
    _dianZanM.skill_name  = [dic objectForKey:@"skill_name"];
    _dianZanM.list   = [dic objectForKey:@"list"];
    _dianZanM.skill_state = [dic objectForKey:@"skill_state"];
    _dianZanM.photoname   = [dic objectForKey:@"photoname"];
    _dianZanM.psnname     = [dic objectForKey:@"psnname"];
    
    return _dianZanM;
}


@end

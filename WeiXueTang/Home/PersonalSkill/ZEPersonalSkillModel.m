//
//  ZEPersonalSkillModel.m
//  WeiXueTang
//
//  Created by Stenson on 16/3/30.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import "ZEPersonalSkillModel.h"

@implementation ZEPersonalSkillModel

static ZEPersonalSkillModel * _personM = nil;
+(instancetype)getDetailModelWithDic:(NSDictionary *)dic
{
    _personM                = [[ZEPersonalSkillModel alloc]init];

    _personM.SYSVERSIONCODE = [dic objectForKey:@"SYSVERSIONCODE"];
    _personM.course_path    = [dic objectForKey:@"course_path"];
    _personM.seqkey         = [dic objectForKey:@"seqkey"];
    _personM.skill_code     = [dic objectForKey:@"skill_code"];
    _personM.skill_name     = [dic objectForKey:@"skill_name"];
    _personM.state          = [dic objectForKey:@"state"];
    
    return _personM;
}

@end

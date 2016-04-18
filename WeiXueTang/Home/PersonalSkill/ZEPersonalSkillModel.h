//
//  ZEPersonalSkillModel.h
//  WeiXueTang
//
//  Created by Stenson on 16/3/30.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZEPersonalSkillModel : NSObject

/**************** 版本编号 ****************/
@property (nonatomic,copy) NSString * SYSVERSIONCODE;
/**************** 技能路径 ****************/
@property (nonatomic,copy) NSString * course_path;
/**************** 主键 ****************/
@property (nonatomic,copy) NSString * seqkey;
/**************** 技能编码 ****************/
@property (nonatomic,copy) NSString * skill_code;
/**************** 技能名 ****************/
@property (nonatomic,copy) NSString * skill_name;
/**************** 技能状态 ****************/
@property (nonatomic,copy) NSString * state;


+(instancetype)getDetailModelWithDic:(NSDictionary *)dic;

@end

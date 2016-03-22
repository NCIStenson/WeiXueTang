//
//  ZEExpertAssModel.h
//  WeiXueTang
//
//  Created by Stenson on 16/3/21.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZEExpertAssModel : NSObject

/**************** 部门编码 ****************/
@property (nonatomic,copy) NSString * ORGCODE;
/**************** 部门名称 ****************/
@property (nonatomic,copy) NSString * ORGNAME;
/**************** 分值  ****************/
@property (nonatomic,copy) NSString * POINTS;
/**************** 部门编码 ****************/
@property (nonatomic,copy) NSString * POSCODE;
/**************** 员工名称 ****************/
@property (nonatomic,copy) NSString * PSNNAME;
/**************** 技能ID ****************/
@property (nonatomic,copy) NSString * SKILLID;
/**************** 技能ID ****************/
@property (nonatomic,copy) NSString * SKILL_NAME;
/**************** 技能状态 ****************/
@property (nonatomic,copy) NSString * STATE;



///**************** 评估详情 ****************/
@property (nonatomic,strong) NSArray * detailarray;

///**************** 评估分类 ****************/
@property (nonatomic,copy) NSString * detail_ITEMS;

///**************** 评估详情 项目名称 ****************/
@property (nonatomic,copy) NSString * detail_PROJECTNAME;

///**************** 评估详情 项目分数 ****************/
@property (nonatomic,copy) NSString * detail_MARKS;

///**************** 评估详情 项目质量 ****************/
@property (nonatomic,copy) NSString * detail_QUALITY;

///**************** 评估详情 评分标准 ****************/
@property (nonatomic,copy) NSString * detail_BENCHMARK;

///**************** 评估详情 专家评分 ****************/
@property (nonatomic,copy) NSString * detail_EXPERTSCORE;


+ (ZEExpertAssModel *)getDetailModelWithDic:(NSDictionary *)dic;

@end

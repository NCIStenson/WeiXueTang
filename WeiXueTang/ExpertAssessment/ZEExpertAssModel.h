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
/****************  ****************/
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

///**************** 员工名称 ****************/
//@property (nonatomic,copy) NSString * PSNNAME;

+ (ZEExpertAssModel *)getDetailModelWithDic:(NSDictionary *)dic;

@end

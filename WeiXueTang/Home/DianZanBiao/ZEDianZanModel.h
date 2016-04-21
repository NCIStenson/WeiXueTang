//
//  ZEDianZanModel.h
//  WeiXueTang
//
//  Created by Stenson on 16/3/17.
//  Copyright © 2016年  Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZEDianZanModel : NSObject

/*********** 员工列表 **********/
@property (nonatomic,retain) NSArray * perSkill;
/*********** 技能列表 **********/
@property (nonatomic,retain) NSArray * teamSkill;

/*********** 员工技能掌握列表 **********/
@property (nonatomic,retain) NSArray * list;


/*********** 技能名称 **********/
@property (nonatomic,copy) NSString * skill_name;
/*********** 技能状态 **********/
@property (nonatomic,copy) NSString * skill_state;
/*********** 技能ID **********/
@property (nonatomic,copy) NSString * instance_key;
/*********** 照片路径 **********/
@property (nonatomic,copy) NSString * photoname;
/*********** 员工姓名 **********/
@property (nonatomic,copy) NSString * psnname;
/*********** 技能ID **********/
@property (nonatomic,copy) NSString * skill_seqkey;

/*********** 照片路径 **********/
//@property (nonatomic,copy) NSString * poscode;
///*********** 照片路径 **********/
//@property (nonatomic,copy) NSString * course;
///*********** 照片路径 **********/
///*********** 照片路径 **********/
//@property (nonatomic,copy) NSString * skill_code;
/*********** 照片路径 **********/
//@property (nonatomic,copy) NSString * skillorder;
///*********** 照片路径 **********/
//@property (nonatomic,copy) NSString * type_name;

+(instancetype) getDetailWithDic:(NSDictionary *)dic;

@end

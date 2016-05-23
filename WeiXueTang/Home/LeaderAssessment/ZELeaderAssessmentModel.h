//
//  ZELeaderAssessmentModel.h
//  WeiXueTang
//
//  Created by Stenson on 16/5/19.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZELeaderAssessmentModel : NSObject

@property (nonatomic,copy) NSString * createdate;
@property (nonatomic,copy) NSString * examtime;
@property (nonatomic,copy) NSString * psnnum;
@property (nonatomic,copy) NSString * remarks;
@property (nonatomic,copy) NSString * seqkey;
@property (nonatomic,copy) NSString * skill_name;
@property (nonatomic,copy) NSString * skillid;
@property (nonatomic,copy) NSString * state;
@property (nonatomic,copy) NSString * user_name;

+(ZELeaderAssessmentModel *)getDetailFromDic:(NSDictionary *)dic;

@end

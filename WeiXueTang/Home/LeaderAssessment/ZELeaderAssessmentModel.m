//
//  ZELeaderAssessmentModel.m
//  WeiXueTang
//
//  Created by Stenson on 16/5/19.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import "ZELeaderAssessmentModel.h"
static ZELeaderAssessmentModel * leaderAssM = nil;

@implementation ZELeaderAssessmentModel

+(ZELeaderAssessmentModel *)getDetailFromDic:(NSDictionary *)dic
{
    leaderAssM = [[ZELeaderAssessmentModel alloc] init];
    NSArray * dateStrArr = [[dic objectForKey:@"createdate"] componentsSeparatedByString:@" "];

    leaderAssM.createdate = dateStrArr[0];
    leaderAssM.examtime   = [dic objectForKey:@"examtime"];
    leaderAssM.psnnum     = [dic objectForKey:@"psnnum"];
    leaderAssM.remarks    = [dic objectForKey:@"remarks"];
    leaderAssM.seqkey     = [dic objectForKey:@"seqkey"];
    leaderAssM.skill_name = [dic objectForKey:@"skill_name"];
    leaderAssM.skillid    = [dic objectForKey:@"skillid"];
    leaderAssM.state      = [dic objectForKey:@"state"];
    leaderAssM.user_name  = [dic objectForKey:@"user_name"];
    
    return leaderAssM;
}

@end

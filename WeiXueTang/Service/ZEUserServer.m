//
//  ZEUserServer.m
//  NewCentury
//
//  Created by Stenson on 16/1/20.
//  Copyright © 2016年  Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#define orgCode @"50172656"

#define kGetToolKitList @"getteamskill"     //  获取工具包列表
#define kGetteamfile    @"getteamfile"      //  获取技能课件列表
#define kSkillSelfView  @"skillSelfView"    //  获取点赞表详情

#import "ZEUserServer.h"
//#import "AFHTTPRequestOperation.h"

@implementation ZEUserServer

+ (void)getToolKitListSuccess:(ServerResponseSuccessBlock)successBlock
                         fail:(ServerResponseFailBlock)failBlock
{
    [[ZEServerEngine sharedInstance]requestWithServerMethod:nil
                                                     params:@{@"type":kGetToolKitList,
                                                              @"data":orgCode}
                                                 httpMethod:HTTPMETHOD_POST
                                                    success:^(id data) {
                                                        successBlock(data);
                                                    } fail:^(NSError * error) {
                                                        failBlock(error);
                                                    }];
}

+ (void)getCoursewareList:(NSString *)skillID
                  success:(ServerResponseSuccessBlock)successBlock
                     fail:(ServerResponseFailBlock)failBlock
{
    [[ZEServerEngine sharedInstance]requestWithServerMethod:nil
                                                     params:@{@"type":kGetteamfile,
                                                              @"data":skillID}
                                                 httpMethod:HTTPMETHOD_POST
                                                    success:^(id data) {
                                                        successBlock(data);
                                                    } fail:^(NSError * error) {
                                                        failBlock(error);
                                                    }];
    
}

+ (void)getSkillSelfViewWithPage:(NSString *)pageNum
                         success:(ServerResponseSuccessBlock)successBlock
                            fail:(ServerResponseFailBlock)failBlock
{
    [[ZEServerEngine sharedInstance]requestWithServerMethod:nil
                                                     params:@{@"type":kSkillSelfView,
                                                              @"data":[NSString stringWithFormat:@"%@#%@",orgCode,pageNum]}
                                                 httpMethod:HTTPMETHOD_POST
                                                    success:^(id data) {
                                                        successBlock(data);
                                                    } fail:^(NSError * error) {
                                                        failBlock(error);
                                                    }];
}

+ (void)getExpertAssessmentList:(NSString *)username
                       password:(NSString *)password
                        success:(ServerResponseSuccessBlock)successBlock
                           fail:(ServerResponseFailBlock)failBlock
{
    [[ZEServerEngine sharedInstance]requestWithServerMethod:@"ExpertLogin"
                                                     params:@{@"username":username,
                                                              @"password":password}
                                                 httpMethod:HTTPMETHOD_POST
                                                    success:^(id data) {
                                                        successBlock(data);
                                                    } fail:^(NSError * error) {
                                                        failBlock(error);
                                                    }];

}


@end

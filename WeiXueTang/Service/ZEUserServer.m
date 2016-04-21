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

#define kGetExpertAssessmentList    @"ExpertLogin"   //  评估就是登陆接口
#define kGetPersonalCourse          @"getPersonalCourse" // 获取个人技能库
#define kGetSkillSelfView           @"skillSelfView"   // 自我评估

#define kSkillSelf                  @"skillSelf"    // 自我点赞
#define kGetteamfilechild           @"getteamfilechild"     //  获取子文件目录列表
#define kPostExpertAssessmentMessage @"ExpertCommit"       //  评估提交

#define kGetAllCourse               @"getallcourse"        //  获取所有的技能

#define kFindCourse                 @"findcourse"           // 搜索下载文件
#define kClickGoodDetail            @"clickGoodDetail"      // 点赞表详情
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
    [[ZEServerEngine sharedInstance]requestWithServerMethod:kGetExpertAssessmentList
                                                     params:@{@"username":username,
                                                              @"password":password}
                                                 httpMethod:HTTPMETHOD_POST
                                                    success:^(id data) {
                                                        successBlock(data);
                                                    } fail:^(NSError * error) {
                                                        failBlock(error);
                                                    }];

}


+ (void)postExpertAssessmentMessage:(NSString *)expertType
                     assessmentData:(NSDictionary *)data
                              files:(NSArray *)filesArr
                            success:(ServerResponseSuccessBlock)successBlock
                               fail:(ServerResponseFailBlock)failBlock
{
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:nil];
    NSString * jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    [[ZEServerEngine sharedInstance]requestWithServerMethod:kPostExpertAssessmentMessage
                                                     params:@{@"expertType":expertType,
                                                              @"data":jsonStr}
                                                 httpMethod:HTTPMETHOD_POST
                                                    success:^(id data) {
                                                        successBlock(data);
                                                    } fail:^(NSError * error) {
                                                        failBlock(error);
                                                    }];
}


+ (void)getPersonalCourseSuccess:(ServerResponseSuccessBlock)successBlock
                            fail:(ServerResponseFailBlock)failBlock
{
    [[ZEServerEngine sharedInstance] requestWithServerMethod:nil
                                                      params:@{@"type":kGetPersonalCourse,
                                                               @"data":[NSString stringWithFormat:@"%@#%@",[ZEUtil getUsername],[ZEUtil getPassword]]}
                                                  httpMethod:HTTPMETHOD_POST
                                                     success:^(id data) {
                                                         successBlock(data);
                                                     } fail:^(NSError *errorCode) {
                                                         failBlock(errorCode);
                                                     }];
}
+ (void)getSkillSelfViewSuccess:(ServerResponseSuccessBlock)successBlock
                           fail:(ServerResponseFailBlock)failBlock
{
    [[ZEServerEngine sharedInstance] requestWithServerMethod:nil
                                                      params:@{@"type":kGetSkillSelfView,
                                                               @"data":[NSString stringWithFormat:@"%@#%@",[ZEUtil getUsername],0]}
                                                  httpMethod:HTTPMETHOD_POST
                                                     success:^(id data) {
                                                         successBlock(data);
                                                     } fail:^(NSError *errorCode) {
                                                         failBlock(errorCode);
                                                     }];
}

+(void)skillSelfSkillID:(NSString *)skillId
                success:(ServerResponseSuccessBlock)successBlock
                   fail:(ServerResponseFailBlock)failBlock
{
    [[ZEServerEngine sharedInstance] requestWithServerMethod:nil
                                                      params:@{@"type":kSkillSelf,
                                                               @"data":skillId}
                                                  httpMethod:HTTPMETHOD_POST
                                                     success:^(id data) {
                                                         successBlock(data);
                                                     } fail:^(NSError *errorCode) {
                                                         failBlock(errorCode);
                                                     }];
}

+(void)getteamfilechild:(NSString *)filePath
                success:(ServerResponseSuccessBlock)successBlock
                   fail:(ServerResponseFailBlock)failBlock
{
    NSLog(@" filePath >>>  %@", filePath);
    [[ZEServerEngine sharedInstance] requestWithServerMethod:nil
                                                      params:@{@"type":kGetteamfilechild,
                                                               @"data":filePath}
                                                  httpMethod:HTTPMETHOD_POST
                                                     success:^(id data) {
                                                                   successBlock(data);
                                                               }
                                                        fail:^(NSError *errorCode) {
                                                                   failBlock(errorCode);
                                                               }];
}

/*
 *  获取课件下载列表
 */
+(void)getAllCourseSuccess:(ServerResponseSuccessBlock)successBlock
                      fail:(ServerResponseFailBlock)failBlock
{
    [[ZEServerEngine sharedInstance]requestWithServerMethod:nil
                                                     params:@{@"type":kGetAllCourse}
                                                 httpMethod:HTTPMETHOD_POST
                                                    success:^(id data) {
                                                        successBlock(data);
                                                    } fail:^(NSError *errorCode) {
                                                        failBlock(errorCode);
                                                    }];
}

/**
 *  课件下载搜索
 */
+(void)findcourseWithStr:(NSString *)searchStr
                 success:(ServerResponseSuccessBlock)successBlock
                    fail:(ServerResponseFailBlock)failBlock
{
    [[ZEServerEngine sharedInstance]requestWithServerMethod:nil
                                                     params:@{@"type":kFindCourse,
                                                              @"data":searchStr}
                                                 httpMethod:HTTPMETHOD_POST
                                                    success:^(id data) {
                                                        successBlock(data);
                                                    } fail:^(NSError *errorCode) {
                                                        failBlock(errorCode);
                                                    }];
}

/**
 *  点赞表详情页面
 */
+(void)clickGoodDetail:(NSString *)key
               success:(ServerResponseSuccessBlock)successBlock
                  fail:(ServerResponseFailBlock)failBlock
{
    [[ZEServerEngine sharedInstance]requestWithServerMethod:nil
                                                     params:@{@"type":kClickGoodDetail,
                                                              @"data":key}
                                                 httpMethod:HTTPMETHOD_POST
                                                    success:^(id data) {
                                                        successBlock(data);
                                                    } fail:^(NSError *errorCode) {
                                                        failBlock(errorCode);
                                                    }];
}


@end

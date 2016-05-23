//
//  ZEUserServer.m
//  NewCentury
//
//  Created by Stenson on 16/1/20.
//  Copyright © 2016年  Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#define kGetToolKitList              @"getteamskill"     //  获取工具包列表
#define kGetteamfile                 @"getteamfile"      //  获取技能课件列表
#define kSkillSelfView               @"skillSelfView"    //  获取点赞表详情
#define kLeaderAssessment            @"awaitAssessList"  //  获取班组长评估列表
#define kTeamAssess                  @"teamAssess"       //  班组长审核
#define kGetTeamMember               @"getTeamMember"     //  获取小组成员

#define kGetExpertAssessmentList     @"ExpertLogin"      //  评估就是登陆接口
#define kGetPersonalCourse           @"getPersonalCourse"//  获取个人技能库
#define kGetSkillSelfView            @"skillSelfView"    //  自我评估

#define kSkillSelf                   @"skillSelf"        //  自我点赞
#define kGetteamfilechild            @"getteamfilechild" //  获取子文件目录列表
#define kPostExpertAssessmentMessage @"ExpertCommit"     //  评估提交

#define kGetAllCourse                @"getallcourse"     //  获取所有的技能

#define kFindCourse                  @"findcourse"       //  搜索下载文件
#define kClickGoodDetail             @"clickGoodDetail"  //  点赞表详情
#define kUserInformation             @"userInformation"  //  个人用户详情

#define kGetTelLogin                 @"getTelLogin"      //  登录
#import "ZEUserServer.h"
//#import "AFHTTPRequestOperation.h"

@implementation ZEUserServer

+(void)loginServerWithUsername:(NSString *)username
                      password:(NSString *)password
                        sucess:(ServerResponseSuccessBlock)successBlock
                          fail:(ServerResponseFailBlock)failBlock
{
    [[ZEServerEngine sharedInstance]requestWithServerMethod:nil
                                                     params:@{@"type":kGetTelLogin,
                                                              @"data":[NSString stringWithFormat:@"%@#%@",username,password]}
                                                 httpMethod:HTTPMETHOD_POST
                                                    success:^(id data) {
                                                        successBlock(data);
                                                    }
                                                       fail:^(NSError *errorCode) {
                                                           failBlock(errorCode);
                                                       }];
}

+ (void)getToolKitListSuccess:(ServerResponseSuccessBlock)successBlock
                         fail:(ServerResponseFailBlock)failBlock
{
    [[ZEServerEngine sharedInstance]requestWithServerMethod:nil
                                                     params:@{@"type":kGetToolKitList,
                                                              @"data":[ZESetLocalData getOrgcode]}
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
                                                              @"data":[NSString stringWithFormat:@"%@#%@",[ZESetLocalData getOrgcode],pageNum]}
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
/**
 *  个人用户信息
 */
+(void)getUserInformationMessageSuccess:(ServerResponseSuccessBlock)successBlock
                                   fail:(ServerResponseFailBlock)failBlock
{
    [[ZEServerEngine sharedInstance]requestWithServerMethod:nil
                                                     params:@{@"type":kUserInformation,
                                                              @"data":[ZEUtil getUsername]}
                                                 httpMethod:HTTPMETHOD_POST
                                                    success:^(id data) {
                                                        successBlock(data);
                                                    } fail:^(NSError *errorCode) {
                                                        failBlock(errorCode);
                                                    }];
}
/**
 *  班组长评估列表
 */
+(void)getLeaderAssessmentMessageSuccess:(ServerResponseSuccessBlock)successBlock
                                    fail:(ServerResponseFailBlock)failBlock
{
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:@{@"loginaccout":[ZEUtil getUsername],
                                                                  @"loginpsw":[ZEUtil getPassword]} options:NSJSONWritingPrettyPrinted error:nil];
    NSString * jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    [[ZEServerEngine sharedInstance]requestWithServerMethod:nil
                                                     params:@{@"type":kLeaderAssessment,
                                                              @"data":jsonString}
                                                 httpMethod:HTTPMETHOD_POST
                                                    success:^(id data) {
                                                        successBlock(data);
                                                    } fail:^(NSError *errorCode) {
                                                        failBlock(errorCode);
                                                    }];
}

+(void)leaderAssessmentWithSeqkey:(NSString *)seqKey
                       withStatus:(NSString *)status
                          success:(ServerResponseSuccessBlock)successBlock
                             fail:(ServerResponseFailBlock)failBlock
{
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:@{@"seqkey":seqKey,
                                                                  @"status":status}
                                                        options:NSJSONWritingPrettyPrinted
                                                          error:nil];
    NSString * jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    [[ZEServerEngine sharedInstance]requestWithServerMethod:nil
                                                     params:@{@"type":kTeamAssess,
                                                              @"data":jsonString}
                                                 httpMethod:HTTPMETHOD_POST
                                                    success:^(id data) {
                                                        successBlock(data);
                                                    } fail:^(NSError *errorCode) {
                                                        failBlock(errorCode);
                                                    }];
}

+(void)getTeamAssessmentMemberSuccess:(ServerResponseSuccessBlock)successBlock
                                 fail:(ServerResponseFailBlock)failBlock
{
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:@{@"loginaccout":[ZEUtil getUsername],
                                                                  @"loginpsw":[ZEUtil getPassword]}
                                                        options:NSJSONWritingPrettyPrinted
                                                          error:nil];
    NSString * jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    [[ZEServerEngine sharedInstance]requestWithServerMethod:nil
                                                     params:@{@"type":kGetTeamMember,
                                                              @"data":jsonString}
                                                 httpMethod:HTTPMETHOD_POST
                                                    success:^(id data) {
                                                        successBlock(data);
                                                    } fail:^(NSError *errorCode) {
                                                        failBlock(errorCode);
                                                    }];
}



@end

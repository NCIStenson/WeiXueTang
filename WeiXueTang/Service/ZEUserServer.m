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

#define kGetExpertAssessmentList    @"ExpertLogin"
#define kGetPersonalCourse          @"getPersonalCourse"
#define kGetSkillSelfView           @"skillSelfView"

#define kSkillSelf                  @"skillSelf"
#define kGetteamfilechild           @"getteamfilechild"
#define kPostExpertAssessmentMessage @"ExpertCommit"

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
    [[ZEServerEngine sharedInstance] requestWithServerMethod:nil
                                                      params:@{@"type":kGetteamfilechild,
                                                               @"data":filePath} httpMethod:HTTPMETHOD_POST success:^(id data) {
                                                                   successBlock(data);
                                                               } fail:^(NSError *errorCode) {
                                                                   failBlock(errorCode);
                                                               }];
}

@end

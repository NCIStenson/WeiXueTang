//
//  ZEUserServer.h
//  NewCentury
//
//  Created by Stenson on 16/1/20.
//  Copyright © 2016年  Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZEServerEngine.h"

@interface ZEUserServer : NSObject

/**
 *  @author Stenson, 16-03-07 15:03:12
 *
 *  获取工具包列表
 *
 */
+ (void)getToolKitListSuccess:(ServerResponseSuccessBlock)successBlock
                          fail:(ServerResponseFailBlock)failBlock;

/**
 *  @author Stenson, 16-03-07 15:03:44
 *
 *  根据技能ID获取技能列表
 *
 *  @param skillID      技能ID
 */
+ (void)getCoursewareList:(NSString *)skillID
                  success:(ServerResponseSuccessBlock)successBlock
                         fail:(ServerResponseFailBlock)failBlock;
/**
 *  获取点赞表
 *
 *  @param pageNum      当前页面
 */

+ (void)getSkillSelfViewWithPage:(NSString *)pageNum
                         success:(ServerResponseSuccessBlock)successBlock
                            fail:(ServerResponseFailBlock)failBlock;
/**
 *  @author Zenith Electronic Technology Co., Ltd., 16-03-21 17:03:58
 *
 *  登陆获取
 *
 *  @param username     用户名
 *  @param password     用户密码
 */
+ (void)getExpertAssessmentList:(NSString *)username
                       password:(NSString *)password
                        success:(ServerResponseSuccessBlock)successBlock
                           fail:(ServerResponseFailBlock)failBlock;

/**
 *  @author Zenith Electronic Technology Co., Ltd., 16-03-28 11:03:32
 *
 *  专家评估
 *
 *  @param expertType   专家类型 （类型为4  传 @“1”  不为4传 @“2”）
 *  @param data         评估的各项分数
 *  @param filesArr     上传的文件
 *  @param successBlock 成功回调
 *  @param failBlock    失败回调
 */
+ (void)postExpertAssessmentMessage:(NSString *)expertType
                     assessmentData:(NSDictionary *)data
                              files:(NSArray *)filesArr
                            success:(ServerResponseSuccessBlock)successBlock
                               fail:(ServerResponseFailBlock)failBlock;

/**
 *  获取个人技能表
 */
+ (void)getPersonalCourseSuccess:(ServerResponseSuccessBlock)successBlock
                               fail:(ServerResponseFailBlock)failBlock;
/**
 *  自我点赞表
 */
+ (void)getSkillSelfViewSuccess:(ServerResponseSuccessBlock)successBlock
                           fail:(ServerResponseFailBlock)failBlock;

/**
 *  @author Zenith Electronic Technology Co., Ltd., 16-03-31 11:03:40
 *
 *  自我点赞
 *
 *  @param skillId      点赞ID
 *  @param successBlock 成功回调
 *  @param failBlock    失败回调  
 */
+(void)skillSelfSkillID:(NSString *)skillId
                success:(ServerResponseSuccessBlock)successBlock
                   fail:(ServerResponseFailBlock)failBlock;
/**
 *  @author Zenith Electronic Technology Co., Ltd., 16-04-05 16:04:33
 *
 *  获取自我点赞技能库中文件详情
 *
 *  @param filePath     上传给服务器的路径
 *  @param successBlock 成功回调
 *  @param failBlock    失败回调
 */
+(void)getteamfilechild:(NSString *)filePath
                success:(ServerResponseSuccessBlock)successBlock
                   fail:(ServerResponseFailBlock)failBlock;

@end

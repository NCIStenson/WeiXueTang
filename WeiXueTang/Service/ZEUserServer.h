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


@end

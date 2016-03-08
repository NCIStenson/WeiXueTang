//
//  ZEUserServer.m
//  NewCentury
//
//  Created by Stenson on 16/1/20.
//  Copyright © 2016年 Stenson. All rights reserved.
//

#define orgCode @"33002005"

#define kGetToolKitList @"getteamskill"     //  获取工具包列表
#define kGetteamfile    @"getteamfile"     //  获取技能课件列表

#import "ZEUserServer.h"

@implementation ZEUserServer

+ (void)getToolKitListSuccess:(ServerResponseSuccessBlock)successBlock
                         fail:(ServerResponseFailBlock)failBlock
{
    [[ZEServerEngine sharedInstance]requestWithParams:@{@"type":kGetToolKitList,
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
    [[ZEServerEngine sharedInstance]requestWithParams:@{@"type":kGetteamfile,
                                                        @"data":skillID}
                                           httpMethod:HTTPMETHOD_POST
                                              success:^(id data) {
                                                  successBlock(data);
                                              } fail:^(NSError * error) {
                                                  failBlock(error);
                                              }];

}

@end

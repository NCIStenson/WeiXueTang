//
//  NCIServerEngine.h
//  NewCentury
//
//  Created by Stenson on 16/1/19.
//  Copyright © 2016年 Stenson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^ServerResponseBlock) (NSDictionary *result);
typedef void (^ServerResponseSuccessBlock) (id data);
typedef void (^ServerResponseFailBlock) (NSError *errorCode);
typedef void (^ServerErrorRecordBlock) (void);  // 记录服务器错误block

@interface ZEServerEngine : NSObject

+ (ZEServerEngine *)sharedInstance;

-(void)requestWithParams:(NSDictionary *)params
              httpMethod:(NSString *)httpMethod
                 success:(ServerResponseSuccessBlock)successBlock
                    fail:(ServerResponseFailBlock)failBlock;
/**
 *  @author Stenson, 16-03-11 16:03:55
 *
 *  下载图片压缩文件
 *
 *  @param URL             服务器地址
 *  @param cachePath       沙盒路径
 *  @param progressBlock   <#progressBlock description#>
 *  @param completionBlock <#completionBlock description#>
 *  @param errorBlock      <#errorBlock description#>
 */
+(void)downloadImageZipFromURL:(NSString *) URL
                     cachePath:(NSString *) cachePath
                  withProgress:(void (^)(CGFloat progress))progressBlock
                    completion:(void (^)(NSURL *filePath))completionBlock
                       onError:(void (^)(NSError *error))errorBlock;

/**
 *  @author Stenson, 16-03-11 16:03:33
 *
 *  下载视频
 *
 *  @param URL             视频服务器地址
 *  @param cachePath       沙盒路径
 *  @param progressBlock   <#progressBlock description#>
 *  @param completionBlock <#completionBlock description#>
 *  @param errorBlock      <#errorBlock description#>
 */
+(void)downloadVideoFromURL:(NSString *) URL
                   fileName:(NSString *)fileName
                  cachePath:(NSString *) cachePath
               withProgress:(void (^)(CGFloat progress))progressBlock
                 completion:(void (^)(NSURL *filePath))completionBlock
                    onError:(void (^)(NSError *error))errorBlock;


@end

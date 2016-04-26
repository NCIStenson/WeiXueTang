//
//  NCIServerEngine.m
//  NewCentury
//
//  Created by Stenson on 16/1/19.
//  Copyright © 2016年  Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import "ZEServerEngine.h"

#define kServerErrorNotLogin                @"E020601" // 用户未登陆
#define kServerErrorLoginTimeOut            @"E020602" // 登陆超时
#define kServerErrorReqTimeOut              @"E020603" // 请求超时
#define kServerErrorIllegalReq              @"E020604" // 非法请求

#import "ZipArchive.h"

static ZEServerEngine *serverEngine = nil;

@implementation ZEServerEngine

+ (ZEServerEngine *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        serverEngine = [[ZEServerEngine alloc] initSingle];
    });
    return serverEngine;
}

-(id)initSingle
{
    self = [super init];
    if ( self) {
        
    }
    return self;
}

-(void)requestWithServerMethod:(NSString *)serverMethod
                        params:(NSDictionary *)params
                    httpMethod:(NSString *)httpMethod
                       success:(ServerResponseSuccessBlock)successBlock
                          fail:(ServerResponseFailBlock)failBlock
{
    NSString * serverAdress = [NSString stringWithFormat:@"%@/GetDataServlet",Zenith_Server];
    if ([ZEUtil isStrNotEmpty:serverMethod]) {
        serverAdress = [NSString stringWithFormat:@"%@/%@",Zenith_Server,serverMethod];
    }
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    sessionManager.requestSerializer.timeoutInterval = 10.f;
    
    if ([httpMethod isEqualToString:HTTPMETHOD_GET]) {
        [sessionManager GET:serverAdress
                 parameters:nil
                   progress:nil
                    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        NSDictionary * responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                        if ([responseDic isKindOfClass:[NSDictionary class]] && [ZEUtil isNotNull:responseDic]) {
                            if (successBlock != nil) {
                                successBlock (responseDic);
                            }
                        }
                    }
                    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        if (error != nil) {
                            failBlock(error);
                        }}];
    }else if ([httpMethod isEqualToString:HTTPMETHOD_POST]){
        [sessionManager POST:serverAdress
                  parameters:params
                    progress:nil
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                         if (![ZEUtil isNotNull:responseObject]) {
                             [self showNetErrorAlertView];
                         }
                         NSDictionary * responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//                         if ([ZEUtil isNotNull:responseDic]) {
                             if (successBlock != nil) {
                                 successBlock(responseDic);
                             }
//                         }
                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         [self showNetErrorAlertView];
                         failBlock(error);
                     }];
    }
    
    
}

+(void)downloadImageZipFromURL:(NSString *) URL
              noSuffixFileName:(NSString *)noSuffixFileName
                     cachePath:(NSString *) cachePath
                  withProgress:(void (^)(CGFloat progress))progressBlock
                    completion:(void (^)(NSString *filePath))completionBlock
                       onError:(void (^)(NSError *error))errorBlock
{
    
//  @"Documents\e.g.\e.g." 目标路径转换成 @"/Documents/e.g./e.g."格式
    NSString * newCachesPath = [cachePath stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
//    解压zip压缩包时  系统会默认创建一个 同名文件夹 所以移除路径中最后的文件夹路径
    NSArray * pathNameArr = [newCachesPath componentsSeparatedByString:@"/"];
    NSString * finalCachesPath = [newCachesPath stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"//%@",[pathNameArr lastObject]] withString:@""];

    NSString * serverAdress = URL;
    //Configuring the session manager
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    //Most URLs I come across are in string format so to convert them into an NSURL and then instantiate the actual request
    NSURL *formattedURL = [NSURL URLWithString:serverAdress];
    NSURLRequest *request = [NSURLRequest requestWithURL:formattedURL];
    
    //Watch the manager to see how much of the file it's downloaded
    [manager setDownloadTaskDidWriteDataBlock:^(NSURLSession *session, NSURLSessionDownloadTask *downloadTask, int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        //Convert totalBytesWritten and totalBytesExpectedToWrite into floats so that percentageCompleted doesn't get rounded to the nearest integer
        CGFloat written = totalBytesWritten;
        CGFloat total = totalBytesExpectedToWrite;
        CGFloat percentageCompleted = written/total;
        //Return the completed progress so we can display it somewhere else in app
        progressBlock(percentageCompleted);
    }];
    
    
    //Start the download
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        //Getting the path of the document directory
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil];
        NSURL *fullURL = [documentsDirectoryURL URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.zip",[pathNameArr lastObject]]];

        [ZEServerEngine unZipFileOrgPath:fullURL.path desPath:finalCachesPath withFileName:noSuffixFileName];
        //If we already have a video file saved, remove it from the phone
        return fullURL;
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (!error) {
            //If there's no error, return the completion block
            completionBlock(cachePath);
        } else {
            //Otherwise return the error block
            errorBlock(error);
        }
        
    }];
    
    [downloadTask resume];
}


+(void)unZipFileOrgPath:(NSString *)orgPath desPath:(NSString *)desPath withFileName:(NSString *)noSuffixFileName
{
    dispatch_queue_t concurrentQueue = dispatch_queue_create("my.concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(concurrentQueue, ^{
        NSString * finaPath = [NSString stringWithFormat:@"%@/%@",CACHEPATH,desPath];
        ZipArchive *za = [[ZipArchive alloc] init];
        // 1. 在内存中解压缩文件
        if ([za UnzipOpenFile: orgPath]) {
            // 2. 将解压缩的内容写到缓存目录中
            BOOL ret = [za UnzipFileTo:finaPath  overWrite:YES];
            if (NO == ret){
//                NSLog(@"失败了");
            }else{
                NSString * imageCachePath = [NSString stringWithFormat:@"Documents/%@/%@/%@",[ZEUtil getmd5WithString:[ZEUtil getUsername]],desPath,noSuffixFileName];
                NSFileManager * fileManager = [NSFileManager defaultManager];
                NSArray * allFileNameArr = [fileManager contentsOfDirectoryAtPath:[NSString stringWithFormat:@"%@/%@",NSHomeDirectory(),imageCachePath] error:nil];
//                获取图片文件类型
                NSString * fielType = [[[allFileNameArr firstObject] componentsSeparatedByString:@"."] lastObject];
                NSMutableArray * orderlyArr = [NSMutableArray arrayWithCapacity:allFileNameArr.count ];
                for (int i = 0; i < allFileNameArr.count; i ++) {
                    [orderlyArr addObject:[NSString stringWithFormat:@"%d.%@",i+1,fielType]];
                }
                //  因每次启动 NSHomeDirectory() 路径会产生变化 所以只缓存文件名之后的路径 加载时 动态获取 NSHomeDirectory()路径 解决问题
                NSMutableDictionary * dic = [NSMutableDictionary dictionary];

                [dic setObject:orderlyArr forKey:kImageCacheArr];
                [dic setObject:noSuffixFileName forKey:kImageCacheName];
                [dic setObject:imageCachePath forKey:kImageCachePath];
                
                [ZEUtil writeImageMessageToFile:dic];
            
                [[NSNotificationCenter defaultCenter] postNotificationName:KDOWNLOADSUCCESS object:nil];
                [self removeVideoAtPath:orgPath];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [za UnzipCloseFile];
                });
            }
        }else{
            [self unZipFileOrgPath:orgPath desPath:desPath withFileName:noSuffixFileName];
        }
    });
    
}


+ (void)removeVideoAtPath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        [fileManager removeItemAtPath:filePath error:NULL];
    }
}

#pragma mark - 下载视频

+(void)downloadVideoFromURL:(NSString *) URL
                   fileName:(NSString *)fileName
                  cachePath:(NSString *) cachePath
               withProgress:(void (^)(CGFloat progress))progressBlock
                 completion:(void (^)(NSURL *filePath))completionBlock
                    onError:(void (^)(NSError *error))errorBlock;
{
//    NSString * plistPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/downloadFile.plist"];
    
    //  @"Documents\e.g.\e.g." 目标路径转换成 @"/Documents/e.g./e.g."格式
    NSString * newCachesPath = [cachePath stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
    
    NSString * serverAdress = URL;
    //Configuring the session manager
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.operationQueue.maxConcurrentOperationCount = 5;
    //Most URLs I come across are in string format so to convert them into an NSURL and then instantiate the actual request
    NSURL *formattedURL = [NSURL URLWithString:serverAdress];
    NSURLRequest *request = [NSURLRequest requestWithURL:formattedURL];
    
    //Watch the manager to see how much of the file it's downloaded
    [manager setDownloadTaskDidWriteDataBlock:^(NSURLSession *session, NSURLSessionDownloadTask *downloadTask, int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        //Convert totalBytesWritten and totalBytesExpectedToWrite into floats so that percentageCompleted doesn't get rounded to the nearest integer
        CGFloat written = totalBytesWritten;
        CGFloat total = totalBytesExpectedToWrite;
        CGFloat percentageCompleted = written/total;
        //Return the completed progress so we can display it somewhere else in app
        progressBlock(percentageCompleted);
    }];
    
    //Start the download
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        //Getting the path of the document directory
        //        判断文件夹路径是否存在 不存在就创建文件夹路径
        NSString * filePath = [NSString stringWithFormat:@"%@/%@",CACHEPATH,newCachesPath];
        NSFileManager * fileManager = [[NSFileManager alloc]init];
        if (![fileManager fileExistsAtPath:filePath]) {
            [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
//        获取文件缓存路径目标文件夹 同时把视频文件命名为filename
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil];
        NSURL *fullURL = [documentsDirectoryURL URLByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@/%@",[ZEUtil getmd5WithString:[ZEUtil getUsername]],newCachesPath,fileName]];
        
        NSString * videoCachePath = [NSString stringWithFormat:@"Documents/%@/%@",[ZEUtil getmd5WithString:[ZEUtil getUsername]],newCachesPath,fileName];
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        [dic setObject:fileName forKey:kVideoCacheName];
        [dic setObject:videoCachePath forKey:kVideoCachePath];
        [ZEUtil writeVideoMessageToFile:dic];

        return fullURL;
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (!error) {
            //If there's no error, return the completion block
            [[NSNotificationCenter defaultCenter] postNotificationName:KDOWNLOADSUCCESS object:nil];
            
//            NSMutableDictionary * dic = [];
            
            completionBlock(filePath);
        } else {
            //Otherwise return the error block
            errorBlock(error);
        }
        
    }];
    
    [downloadTask resume];
}



-(void)showNetErrorAlertView
{
    //    if (IS_IOS8) {
    //        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"网络连接异常，请重试"
    //                                                                                 message:nil
    //                                                                          preferredStyle:UIAlertControllerStyleAlert];
    //        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    //        [alertController addAction:okAction];
    ////        [self presentViewController:alertController animated:YES completion:nil];
    //
    //    }else{
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"网络连接异常，请重试"
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"好的"
                                              otherButtonTitles:nil, nil];
    [alertView show];
    //    }
}




@end

//
//  ZEUtil.m
//  NewCentury
//
//  Created by Stenson on 16/1/20.
//  Copyright © 2016年  Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import "ZEUtil.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import <CommonCrypto/CommonDigest.h>

@implementation ZEUtil

+ (BOOL)isNotNull:(id)object
{
    if ([object isEqual:[NSNull null]]) {
        return NO;
    } else if ([object isKindOfClass:[NSNull class]]) {
        return NO;
    } else if (object == nil) {
        return NO;
    }
    return YES;
}

+ (BOOL)isStrNotEmpty:(NSString *)str
{
    if ([ZEUtil isNotNull:str]) {
        if ([str isEqualToString:@""]) {
            return NO;
        } else {
            return YES;
        }
    } else {
        return NO;
    }
}
+ (double)heightForString:(NSString *)str font:(UIFont *)font andWidth:(float)width
{
    double height = 0.0f;
    if (IS_IOS7) {
        CGRect rect = [str boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
        height = ceil(rect.size.height);
    }
//    else {
//        CGSize sizeToFit = [str sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
//        height = sizeToFit.height;
//    }
    
    return height;
}

+ (double)widthForString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize
{
    double width = 0.0f;
    if (IS_IOS7) {
        CGRect rect = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
        width = rect.size.width;
    }
//    else {
//        CGSize sizeToFit = [str sizeWithFont:font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
//        width = sizeToFit.width;
//    }
    return width;
}

+ (NSString*)getmd5WithString:(NSString *)string
{
    const char* original_str=[string UTF8String];
    unsigned char digist[CC_MD5_DIGEST_LENGTH]; //CC_MD5_DIGEST_LENGTH = 16
    CC_MD5(original_str, strlen(original_str), digist);

    NSMutableString* outPutStr = [NSMutableString stringWithCapacity:10];
    for(int  i =0; i<CC_MD5_DIGEST_LENGTH;i++){
        [outPutStr appendFormat:@"%02x", digist[i]];// 小写 x 表示输出的是小写 MD5 ，大写 X 表示输出的是大写 MD5
    }
    return [outPutStr uppercaseString];
}

+ (NSDictionary *)getSystemInfo
{
    NSMutableDictionary *infoDic = [[NSMutableDictionary alloc] init];
    
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    
    NSString *systemName = [[UIDevice currentDevice] systemName];
    
    NSString *device = [[UIDevice currentDevice] model];
    
    NSDictionary *bundleInfo = [[NSBundle mainBundle] infoDictionary];
    
    NSString *appVersion = [bundleInfo objectForKey:@"CFBundleShortVersionString"];
    
    NSString *appBuildVersion = [bundleInfo objectForKey:@"CFBundleVersion"];
    
    NSArray *languageArray = [NSLocale preferredLanguages];
    
    NSString *language = [languageArray objectAtIndex:0];
    
    NSLocale *locale = [NSLocale currentLocale];
    
    NSString *country = [locale localeIdentifier];
    
    // 手机型号
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char*)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *deviceModel = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    [infoDic setObject:country forKey:@"country"];
    [infoDic setObject:language forKey:@"language"];
    [infoDic setObject:systemName forKey:@"systemName"];
    [infoDic setObject:systemVersion forKey:@"systemVersion"];
    [infoDic setObject:device forKey:@"device"];
    [infoDic setObject:deviceModel forKey:@"deviceModel"];
    [infoDic setObject:appVersion forKey:@"appVersion"];
    [infoDic setObject:appBuildVersion forKey:@"appBuildVersion"];
    
    return infoDic;
}
+ (UIImage *)imageFromColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage * image = nil;
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (NSString *)formatDate:(NSDate *)date
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyyMMdd_HHmmssSSS"];
    return [df stringFromDate:date];
}


#pragma mark - 点赞表

+ (NSString *)getDianZanTypeChineseText:(DIANZAN_TYPE)type
{
    switch (type) {
        case DIANZAN_TYPE_DONE:
            return @"已点赞";
            break;
        case DIANZAN_TYPE_DOING:
            return @"评估中";
            break;
        case DIANZAN_TYPE_Master:
            return @"已掌握";
            break;
        case DIANZAN_TYPE_NO:
            return @"未点赞";
            break;
        default:
            return @"未点赞";
            break;
    }
}
+ (NSString *)getDianZanTypeImageName:(DIANZAN_TYPE)type
{
    switch (type) {
        case DIANZAN_TYPE_DONE:
            return @"good_yet";
            break;
        case DIANZAN_TYPE_DOING:
            return @"good_assess";
            break;
        case DIANZAN_TYPE_Master:
            return @"good_grasp";
            break;
        case DIANZAN_TYPE_NO:
            return @"good_not";
            break;
        default:
            return @"good_not";
            break;
    }
}

/**
 *      登录工号
 */
+ (void)setUsername:(NSString *)username
{
    [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"username"];
}
+ (NSString *)getUsername
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
}
/**
*      登录密码
*/
+ (void)setPassword:(NSString *)password
{
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"];
}
+ (NSString *)getPassword
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
}
/**
 *  获取本地已经缓存的下载信息
 */
+ (NSMutableDictionary *)getDownloadFileMessage
{
//    NSString * plistPath = [NSString stringWithFormat:@"%@/downloadFile.plist",CACHEPATH];
    NSMutableDictionary * dictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:DOWNLOADFILEPATH];
    return dictionary;
}

+(void)writeImageMessageToFile:(NSDictionary *)dic
{
    NSMutableArray * mutableArr = [NSMutableArray arrayWithArray:[[self getDownloadFileMessage] objectForKey:@"image"]];
    [mutableArr addObject:dic];
    NSMutableDictionary * resultDic = [NSMutableDictionary dictionary];
    [resultDic setObject:[[ZEUtil getDownloadFileMessage] objectForKey:@"video"] forKey:@"video"];
    [resultDic setObject:mutableArr forKey:@"image"];
    [resultDic writeToFile:DOWNLOADFILEPATH atomically:YES];
    
}
+(void)writeVideoMessageToFile:(NSDictionary *)dic
{
    NSMutableArray * mutableArr = [NSMutableArray arrayWithArray:[[self getDownloadFileMessage] objectForKey:@"video"]];
    [mutableArr addObject:dic];
    NSMutableDictionary * resultDic = [NSMutableDictionary dictionary];
    [resultDic setObject:[[ZEUtil getDownloadFileMessage] objectForKey:@"image"] forKey:@"image"];
    [resultDic setObject:mutableArr forKey:@"video"];
    [resultDic writeToFile:DOWNLOADFILEPATH atomically:YES];
    
}
@end

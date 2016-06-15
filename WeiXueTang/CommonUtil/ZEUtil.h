//
//  ZEUtil.h
//  NewCentury
//
//  Created by Stenson on 16/1/20.
//  Copyright © 2016年  Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import "ZEEnumConstant.h"

@interface ZEUtil : NSObject
// 检查对象是否为空
+ (BOOL)isNotNull:(id)object;

// 检查字符串是否为空
+ (BOOL)isStrNotEmpty:(NSString *)str;

// 计算文字高度
+ (double)heightForString:(NSString *)str font:(UIFont *)font andWidth:(float)width;

+ (double)widthForString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize;

// MD5算法
+ (NSString*)getmd5WithString:(NSString *)string;
// 根据颜色生成图片
+ (UIImage *)imageFromColor:(UIColor *)color;

//  时间格式化
+ (NSString *)formatDate:(NSDate *)date;

/**
 *     点赞表中文注释
 */
+ (NSString *)getDianZanTypeChineseText:(DIANZAN_TYPE)type;
/**
 *     点赞表图片名
 */
+ (NSString *)getDianZanTypeImageName:(DIANZAN_TYPE)type;
/**
 *      登录工号
 */
+ (void)setUsername:(NSString *)username;
+ (NSString *)getUsername;
/**
 *      登录密码
 */
+ (void)setPassword:(NSString *)password;
+ (NSString *)getPassword;
+ (void)setLoginUserInfo:(NSDictionary *)dic;

/**
 *  清楚用户登录信息
 */
+(void)clearUserInfo;
/**
 *  班组名称
 */
+ (NSString *)getOrgname;
/**
 *  获取本地已经缓存的下载信息
 */

+ (NSMutableDictionary *)getDownloadFileMessage;
+(void)writeImageMessageToFile:(NSDictionary *)dic;
+(void)writeVideoMessageToFile:(NSDictionary *)dic;

/**
 *  改变  “\\” === >  "/"
 */
+(NSString *)changeURLStrFormat:(NSString *)str;

@end

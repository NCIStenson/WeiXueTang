//
//  ZESetLocalData.m
//  NewCentury
//
//  Created by Stenson on 16/1/22.
//  Copyright © 2016年 Zenith Electronic. All rights reserved.
//

#import "ZESetLocalData.h"

static NSString * kUserInformation = @"keyUserInformation";

@implementation ZESetLocalData

+(id)Get:(NSString*)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+(NSString *)GetStringWithKey:(NSString *)key
{
    id value = [self Get:key];
    
    if (value == [NSNull null] || value == nil) {
        return @"";
    }
    
    return value;
}

+(int)GetIntWithKey:(NSString *)key
{
    id value = [self Get:key];
    
    if (value == [NSNull null] || value == nil) {
        return -1;
    }
    
    return [value intValue];
}

+(void)Set:(NSString*)key value:(id)value
{
    if (value == [NSNull null] || value == nil) {
        value = @"";
    }
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)setLocalUserData:(NSDictionary *)dic
{
    [self Set:kUserInformation value:dic];
}

+(NSDictionary *)getUserData
{
    return [self Get:kUserInformation];
}

+(void)deleteLoaclUserData
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserInformation];
}
/**
 *  用户名
 */

+(NSString *)getUsername
{
    NSDictionary * dic = [self getUserData];
    return [dic objectForKey:@"uname"];
}
+(NSString *)getOrgcode
{
    NSDictionary * dic = [self getUserData];
    return [dic objectForKey:@"orgCode"];
}

+(NSString *)getUnitcode
{
    NSDictionary * dic = [self getUserData];
    return [dic objectForKey:@"unitCode"];
}

/**
 *  部门名称
 */
+(NSString *)getUserOrgCodeName
{
    NSDictionary * dic = [self getUserData];
    return [dic objectForKey:@"orgName"];
}
/**
 *  部门名称
 */
+(NSString *)getUnitName
{
    NSDictionary * dic = [self getUserData];
    return [dic objectForKey:@"unitName"];
}


@end
//
//  ZEExpertAssessmentCache.h
//  WeiXueTang
//
//  Created by Stenson on 16/3/28.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZEExpertAssessmentCache : NSObject

+(ZEExpertAssessmentCache *)instance;

/**
 *  缓存输入分数
 */
-(void)setExpertAssessmentScore:(NSString * )score index:(NSInteger)index;
-(NSString *)getScoreWithIndex:(NSInteger)index;

/**
 *  缓存输入备注
 */
-(void)setExpertAssessmentRemark:(NSString * )remarkStr index:(NSInteger)index;
-(NSString *)getRemarkWithIndex:(NSInteger)index;

/**
 *  清除缓存
 */
-(void)clear;

@end

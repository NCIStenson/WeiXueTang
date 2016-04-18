//
//  ZEExpertAssessmentCache.m
//  WeiXueTang
//
//  Created by Stenson on 16/3/28.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import "ZEExpertAssessmentCache.h"

@interface ZEExpertAssessmentCache ()

{
    
}

@property (nonnull,nonatomic,strong) NSMutableArray * scoreArr;
@property (nonnull,nonatomic,strong) NSMutableArray * remarkArr;

@end

@implementation ZEExpertAssessmentCache

static ZEExpertAssessmentCache * expertAssCache = nil;

-(id)initSingle
{
    self = [super init];
    if (self) {
        self.scoreArr = [[NSMutableArray alloc]initWithCapacity:kCACHESARRMAXCOUNT];
        self.remarkArr = [[NSMutableArray alloc]initWithCapacity:kCACHESARRMAXCOUNT];
        for (int i = 0; i < kCACHESARRMAXCOUNT ; i ++) {
            [self.scoreArr addObject:@"0"];
            [self.remarkArr addObject:@""];
        }
    }
    return self;
}

-(id)init
{
    return [ZEExpertAssessmentCache instance];
}

+(ZEExpertAssessmentCache *)instance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        expertAssCache = [[self alloc]initSingle];
    });
    return expertAssCache;
}

/**
 *  缓存输入分数
 */
-(void)setExpertAssessmentScore:(NSString * )score index:(NSInteger)index
{
    [self.scoreArr replaceObjectAtIndex:index withObject:score];
}
-(NSString *)getScoreWithIndex:(NSInteger)index
{
    return  self.scoreArr[index];
}
/**
 *  缓存输入备注
 */
-(void)setExpertAssessmentRemark:(NSString * )remarkStr index:(NSInteger)index
{
    [self.remarkArr replaceObjectAtIndex:index withObject:remarkStr];
}
-(NSString *)getRemarkWithIndex:(NSInteger)index
{
    return self.remarkArr[index];
}
/**
 *  清除缓存
 */
-(void)clear
{
    self.scoreArr = [[NSMutableArray alloc]initWithCapacity:kCACHESARRMAXCOUNT];
    self.remarkArr = [[NSMutableArray alloc]initWithCapacity:kCACHESARRMAXCOUNT];
    for (int i = 0; i < kCACHESARRMAXCOUNT ; i ++) {
        [self.scoreArr addObject:@"0"];
        [self.remarkArr addObject:@""];
    }
}

@end

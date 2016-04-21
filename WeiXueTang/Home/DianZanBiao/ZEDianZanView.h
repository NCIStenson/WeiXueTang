//
//  ZEDianZanView.h
//  WeiXueTang
//
//  Created by Stenson on 16/3/17.
//  Copyright © 2016年  Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZEDianZanView.h"
@class ZEDianZanView;

@protocol ZEDianZanViewDelegate <NSObject>

/**
 *  前一页数据
 */
-(void)previousPage;

/**
 *  后一页数据
 */
-(void)nextPage;

/**
 *  进入技能详情列表
 */
-(void)goSkillDetail:(NSString *)skillID;
/**
 *  进入技能评估详情
 */
-(void)goSkillExpertAss:(NSString *)seqkey
          withSkillName:(NSString *)skillName
            withOrgName:(NSString * )orgname
          withStaffName:(NSString *)staffName;

@end

@interface ZEDianZanView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) id <ZEDianZanViewDelegate> delegate;

-(id)initWithFrame:(CGRect)rect;

/**
 *  刷新数据
 */

-(void)reloadData:(NSDictionary *)dic;

@end

//
//  ZELeaderAssDetailView.h
//  WeiXueTang
//
//  Created by Stenson on 16/5/19.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZELeaderAssessmentModel.h"

@class ZELeaderAssDetailView;

@protocol ZELeaderAssDetailViewDelegate <NSObject>
/**
 *  @author Zenith Electronic Technology Co., Ltd., 16-05-20 09:05:15
 *
 *  通过
 */
-(void)passAssessment:(ZELeaderAssessmentModel *)mod;
/**
 *  @author Zenith Electronic Technology Co., Ltd., 16-05-20 09:05:58
 *
 *  驳回审核
 */
-(void)refuseAssessment:(ZELeaderAssessmentModel *)mod;

@end

@interface ZELeaderAssDetailView : UIView

@property (nonatomic,weak) id <ZELeaderAssDetailViewDelegate> delegate;

-(id)initWithFrame:(CGRect)frame withLeaderAssessmentM:(ZELeaderAssessmentModel *)leaderAssM;

@end

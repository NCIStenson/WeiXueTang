//
//  ZELeaderAssmessmentView.h
//  WeiXueTang
//
//  Created by Stenson on 16/5/19.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZELeaderAssessmentModel.h"

@class ZELeaderAssmessmentView;

@protocol ZELeaderAssmessmentViewDelegate <NSObject>

-(void)didSelectLeaderAssess:(ZELeaderAssessmentModel *)leaderAssessM;


-(void)showAllTeamMember;

@end

@interface ZELeaderAssmessmentView : UIView

@property(nonatomic,weak)id<ZELeaderAssmessmentViewDelegate>delegate;

-(id)initWithFrame:(CGRect)frame;

#pragma mark - Public Method

-(void)reloadData:(NSArray *)arr;
-(void)showAllTeamMember:(NSArray *)memberArr;
@end

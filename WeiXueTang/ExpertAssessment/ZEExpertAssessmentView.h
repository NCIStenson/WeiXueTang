//
//  ZEExpertAssessmentView.h
//  WeiXueTang
//
//  Created by Stenson on 16/3/21.
//  Copyright © 2016年  Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZEExpertAssessmentView;
@protocol ZEExpertAssessmentViewDelegate <NSObject>

/**
 * 进入详情界面
 */
-(void)didSelectRow:(NSInteger)row;

@end

@interface ZEExpertAssessmentView : UIView<UITableViewDataSource,UITableViewDelegate>

#pragma mark - Public Method

@property (nonatomic,weak) id <ZEExpertAssessmentViewDelegate> delegate;

-(void)expertAssessmentReloadView:(NSArray *)arr;

@end

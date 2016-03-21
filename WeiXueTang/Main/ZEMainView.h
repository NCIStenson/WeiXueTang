//
//  ZEMainView.h
//  WeiXueTang
//
//  Created by Stenson on 16/3/3.
//  Copyright © 2016年  Zenith Electronic Technology Co., Ltd. All rights reserved.
//

@class ZEMainView;
@protocol ZEMainViewDelegate <NSObject>

/**
 *  @author Stenson, 16-03-07 09:03:24
 *
 *  进入工具包页面
 */
-(void)goToolKitView;

/**
 *  进入点赞表页面
 */
-(void)goDianZanView;

/**
 *  进入专家评估页面
 */
-(void)gozhuanjiaAssessmentView;

@end


#import <UIKit/UIKit.h>

@interface ZEMainView : UIView

@property (nonatomic,assign) id <ZEMainViewDelegate> delegate;

-(id)initWithFrame:(CGRect)rect;


@end

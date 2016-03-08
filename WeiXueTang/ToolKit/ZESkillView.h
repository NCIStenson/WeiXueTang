//
//  ZESkillView.h
//  WeiXueTang
//
//  Created by Stenson on 16/3/7.
//  Copyright © 2016年 Stenson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZESkillView;
@protocol ZESkillViewDelegate <NSObject>

/**
 *  @author Stenson, 16-03-07 15:03:45
 *
 *  选中单元行时 进入下一界面
 *
 *  @param skillID 技能ID
 */
-(void)playCourswareVideo:(NSString *)filepath;

@end


@interface ZESkillView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) id <ZESkillViewDelegate> delegate;

-(id)initWithFrame:(CGRect)rect;

#pragma mark Public Method
-(void)contentViewReloadData:(NSArray *)arr;

@end

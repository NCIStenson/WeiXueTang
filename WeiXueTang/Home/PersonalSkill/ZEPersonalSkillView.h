//
//  ZEPersonalSkillView.h
//  WeiXueTang
//
//  Created by Stenson on 16/3/29.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZEPersonalSkillView;
@protocol ZEPersonalSkillViewDelegate <NSObject>

-(void)skillSelf:(ZEPersonalSkillView * )skillView withID:(NSString *)skillID;

/**
 *  @author Zenith Electronic Technology Co., Ltd., 16-04-05 16:04:12
 *
 *  进入技能详情页面
 *
 *  @param filePath 文件course_path
 */
-(void)enterSkillFileVC:(NSString *)filePath;

@end

@interface ZEPersonalSkillView : UIView<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,weak) id <ZEPersonalSkillViewDelegate> delegate;

-(void)contentViewReloadData:(NSArray *)arr;
@end

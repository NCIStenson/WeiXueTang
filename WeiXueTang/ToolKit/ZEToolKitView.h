//
//  ZEToolKitView.h
//  WeiXueTang
//
//  Created by Stenson on 16/3/7.
//  Copyright © 2016年 Stenson. All rights reserved.
//

@class ZEToolKitView;
@protocol ZEToolKitViewDelegate <NSObject>

/**
 *  @author Stenson, 16-03-07 15:03:45
 *
 *  选中单元行时 进入下一界面
 *
 *  @param skillID 技能ID
 */
-(void)selectToolKitWithSkillID:(NSString *)skillID;

@end

#import <UIKit/UIKit.h>

@interface ZEToolKitView : UIView<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,assign) id <ZEToolKitViewDelegate> delegate;

-(id)initWithFrame:(CGRect)rect;

#pragma mark Public Method
-(void)contentViewReloadData:(NSArray *)arr;

@end

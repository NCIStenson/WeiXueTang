//
//  ZEDownloadView.h
//  WeiXueTang
//
//  Created by Stenson on 16/4/5.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZEDownloadSearchView;

@protocol ZEDownloadSearchViewDelegate <NSObject>

/**
 *  @author Zenith Electronic Technology Co., Ltd., 16-04-07 13:04:45
 *
 *  开始查询
 *
 *  @param inputStr 输入字符
 */
-(void)beginSearch:(NSString *)inputStr;

//

-(void)goChildTeamWithPath:(NSString *)filePath withFileName:(NSString *)fileName;

@end

@interface ZEDownloadSearchView : UIView<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak) id <ZEDownloadSearchViewDelegate> delegate;
-(id)initWithFrame:(CGRect)frame;

-(void)contentViewReloadData:(NSArray *)arr;

@end

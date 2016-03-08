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
 *  @author Stenson, 16-03-08 14:03:36
 *
 *  播放课件视频
 *
 *  @param filepath 文件路径
 */
-(void)playCourswareVideo:(NSString *)filepath;
/**
 *  @author Stenson, 16-03-08 14:03:24
 *
 *  展示课件图片
 *
 *  @param filepath 文件路径
 *  @param pngType  文件图片类型（docx，pdf）
 *  @param pageNum  图片数量（文件默认从1开始）
 */
-(void)playCourswareImagePath:(NSString *)filepath withType:(NSString *)pngType withPageNum:(NSString *)pageNum;

@end


@interface ZESkillView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) id <ZESkillViewDelegate> delegate;

-(id)initWithFrame:(CGRect)rect;

#pragma mark Public Method
-(void)contentViewReloadData:(NSArray *)arr;

@end

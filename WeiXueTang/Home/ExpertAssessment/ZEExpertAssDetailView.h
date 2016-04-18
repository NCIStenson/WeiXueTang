//
//  ZEExpertAssDetailView.h
//  WeiXueTang
//
//  Created by Stenson on 16/3/21.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZEExpertAssModel.h"

@class ZEExpertAssDetailView;
@protocol ZEExpertAssDetailViewDelegate  <NSObject>

/**
 *  进入评分标准页面
 */
-(void)enterDetailProject:(ZEExpertAssModel * )expertAssM index:(NSInteger)row;

@end

@interface ZEExpertAssDetailView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak) id <ZEExpertAssDetailViewDelegate> delegate;

-(id)initWithFrame:(CGRect)frame withModel:(ZEExpertAssModel *)model withType:(EXPERTASSESSMENT_TYPE)enterType;

#pragma mark - PublicMethod 

-(void)reloadView;

@end


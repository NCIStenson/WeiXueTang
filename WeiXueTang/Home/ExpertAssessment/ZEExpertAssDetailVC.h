//
//  ZEExpertAssDetailVC.h
//  WeiXueTang
//
//  Created by Stenson on 16/3/21.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import "ZESettingRootVC.h"
#import "ZEExpertAssModel.h"
#import "ZEExpertAssDetailView.h"

@interface ZEExpertAssDetailVC : ZESettingRootVC<ZEExpertAssDetailViewDelegate>

@property (nonatomic,assign) EXPERTASSESSMENT_TYPE experAssType;
@property (nonatomic,retain) ZEExpertAssModel * expertAssM;

@end

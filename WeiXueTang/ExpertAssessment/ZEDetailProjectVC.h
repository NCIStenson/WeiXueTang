//
//  ZEDetailProjectVC.h
//  WeiXueTang
//
//  Created by Stenson on 16/3/22.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import "ZESettingRootVC.h"

#import "ZEDetailProjectView.h"
#import "ZEExpertAssModel.h"
@interface ZEDetailProjectVC : ZESettingRootVC

@property (nonatomic,assign) EXPERTASSESSMENT_TYPE experAssType;
@property (nonatomic,strong) ZEExpertAssModel * expertAssM;

@end

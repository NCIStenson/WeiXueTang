//
//  ZESkillViewController.h
//  WeiXueTang
//
//  Created by Stenson on 16/3/7.
//  Copyright © 2016年 Stenson. All rights reserved.
//

#import "ZESettingRootVC.h"
#import "ZESkillView.h"

@interface ZESkillViewController : ZESettingRootVC<ZESkillViewDelegate>

@property (nonatomic,copy) NSString * skillID;

@end

//
//  ZEChildTeamFileVC.h
//  WeiXueTang
//
//  Created by Stenson on 16/4/19.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZESettingRootVC.h"
#import "SDPhotoBrowser.h"
#import "ZEChildTeamFileView.h"

@interface ZEChildTeamFileVC : ZESettingRootVC<ZEChildTeamFileViewDelegate,SDPhotoBrowserDelegate>

@property (nonatomic,copy) NSString * childFilePath;
@property (nonatomic,copy) NSString * fatherFileName;

@property (nonatomic,assign) DOWNLOADFILE_TYPE enterType;
@property (nonatomic,copy) NSString * searchStr;

@end

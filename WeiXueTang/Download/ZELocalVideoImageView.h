//
//  ZELocalVideoImageView.h
//  WeiXueTang
//
//  Created by Stenson on 16/4/18.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZELocalVideoImageView : UIView<UITableViewDelegate,UITableViewDataSource>

-(id)initWithFrame:(CGRect)frame withFileType:(LOCALFILE_TYPE)fileType;

@end

//
//  DPSettingRootVC.h
//
//  Created by Stensonon 15/9/8.
//  Copyright (c) 2015年 Zenith Electronic Technology Co., Ltd. http://www.molijing.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

#define kScale (SCREEN_HEIGHT - (IPHONE4S_LESS ? 40.0 : 50.0f)) / (666.0f - (IPHONE4S_LESS ? 40.0 : 50.0f))

@interface ZESettingRootVC : UIViewController
{
    UIButton *_leftBtn;
    UIButton *_rightBtn;
    UILabel *_titleLabel;
    NSString *_titleStr;
    NSString *_rightBtnTitleStr;
}

@property (nonatomic,strong) UILabel * titleLabel;

/**
 *  添加一条提示 1s后消失
 */
- (void)showTips:(NSString *)labelText;
/**
 *  开始加载HUD
 */
- (void)progressBegin:(NSString *)labelText;
/**
 *  结束加载HUD 1s后消失
 */
- (void)progressEnd:(NSString *)labelText;

- (void)leftBtnClick;
- (void)rightBtnClick;
- (void)setTitle:(NSString *)title;
- (void)setRightBtnTitle:(NSString *)rightBtnTitle;
- (void)disableLeftBtn;
- (void)disableRightBtn;

- (void)hiddenLine;
@end

//
//  ZEMainView.m
//  WeiXueTang
//
//  Created by Stenson on 16/3/3.
//  Copyright © 2016年 Stenson. All rights reserved.
//

#define kToolKitBtnMarginLeft   0.0f
#define kToolKitBtnMarginTop    40.0f
#define kToolKitBtnWidth        SCREEN_WIDTH
#define kToolKitBtnHeight       80.0f

#import "ZEMainView.h"

@implementation ZEMainView

-(id)initWithFrame:(CGRect)rect
{
    self = [super initWithFrame:rect];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView
{
    UIButton * toolKitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    toolKitBtn.frame = CGRectMake(kToolKitBtnMarginLeft, kToolKitBtnMarginTop, kToolKitBtnWidth, kToolKitBtnHeight);
    toolKitBtn.backgroundColor = [UIColor cyanColor];
    [toolKitBtn setTitle:@"工具包" forState:UIControlStateNormal];
    [toolKitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:toolKitBtn];
    [toolKitBtn addTarget:self action:@selector(goToolKitView) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * dianZanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dianZanBtn.frame = CGRectMake(kToolKitBtnMarginLeft, kToolKitBtnMarginTop + kToolKitBtnHeight, kToolKitBtnWidth, kToolKitBtnHeight);
    dianZanBtn.backgroundColor = [UIColor yellowColor];
    [dianZanBtn setTitle:@"点赞表" forState:UIControlStateNormal];
    [dianZanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:dianZanBtn];
    [dianZanBtn addTarget:self action:@selector(goDianZanView) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - SelfDelegate

-(void)goToolKitView
{
    if ([self.delegate respondsToSelector:@selector(goToolKitView) ]) {
        [self.delegate goToolKitView];
    }
}

-(void)goDianZanView
{
    if ([self.delegate respondsToSelector:@selector(goDianZanView) ]) {
        [self.delegate goDianZanView];
    }
}


@end

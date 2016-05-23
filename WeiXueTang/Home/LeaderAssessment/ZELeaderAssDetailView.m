//
//  ZELeaderAssDetailView.m
//  WeiXueTang
//
//  Created by Stenson on 16/5/19.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#define kMessageLabelMarginLeft    10.0f
#define kMessageLabelMarginTop     0.0f
#define kMessageLabelMarginWidth   SCREEN_WIDTH - 20.0f
#define kMessageLabelMarginHeight  40.0f

#import "ZELeaderAssDetailView.h"

@interface ZELeaderAssDetailView ()
{
    ZELeaderAssessmentModel * _detailLeaderAss;
}
@end

@implementation ZELeaderAssDetailView

-(id)initWithFrame:(CGRect)frame withLeaderAssessmentM:(ZELeaderAssessmentModel *)leaderAssM
{
    self = [super initWithFrame:frame];
    if (self) {
        _detailLeaderAss = leaderAssM;
        [self initView];
    }
    return self;
}

-(void)initView
{

    for (int i = 0; i < 3; i ++) {
        UILabel * messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(kMessageLabelMarginLeft, kMessageLabelMarginTop + kMessageLabelMarginHeight * i, kMessageLabelMarginWidth, kMessageLabelMarginHeight)];
        messageLabel.font = [UIFont systemFontOfSize:14];
        messageLabel.numberOfLines = 0;
        [self addSubview:messageLabel];
        
        CALayer * lineLayer = [CALayer layer];
        lineLayer.frame = CGRectMake(messageLabel.frame.origin.x, messageLabel.frame.origin.y + 39.5, messageLabel.frame.size.width, 0.5);
        lineLayer.backgroundColor = [[UIColor colorWithWhite:0 alpha:0.5] CGColor];
        [self.layer addSublayer:lineLayer];
        
        switch (i) {
            case 0:
                messageLabel.text = [NSString stringWithFormat:@"技能名称：%@",_detailLeaderAss.skill_name];
                break;
            case 1:
                messageLabel.text = [NSString stringWithFormat:@"班员姓名：%@",_detailLeaderAss.user_name];
                break;
            case 2:
                messageLabel.text = [NSString stringWithFormat:@"创建日期：%@",_detailLeaderAss.createdate];
                break;
                
            default:
                break;
        }
    }
    
    
    UIView * btnBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0,kMessageLabelMarginHeight * 3 , SCREEN_WIDTH, 50)];
//    btnBackgroundView.backgroundColor = [UIColor redColor];
    [self addSubview:btnBackgroundView];
    
    for (int i = 0; i < 2; i ++) {
        UIButton * chooseBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        chooseBtn.frame = CGRectMake(10 + SCREEN_WIDTH / 2 * i, 0, (SCREEN_WIDTH - 40)/2, 50);
        [btnBackgroundView addSubview:chooseBtn];
        [chooseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [chooseBtn setBackgroundColor:MAIN_COLOR];
        if (i == 0) {
            [chooseBtn setTitle:@"通过" forState:UIControlStateNormal];
            [chooseBtn addTarget:self action:@selector(passTheAssessment) forControlEvents:UIControlEventTouchUpInside];
        }else{
            [chooseBtn setBackgroundColor:MAIN_LINE_COLOR];
            [chooseBtn setTitle:@"驳回" forState:UIControlStateNormal];
            [chooseBtn addTarget:self action:@selector(refuseTheAssessment) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

#pragma mark - ZELeaderAssDetailViewDelegate

-(void)passTheAssessment
{
    if ([self.delegate respondsToSelector:@selector(passAssessment:)]) {
        [self.delegate passAssessment:_detailLeaderAss];
    }
}

-(void)refuseTheAssessment
{
    if ([self.delegate respondsToSelector:@selector(refuseAssessment:)]) {
        [self.delegate refuseAssessment:_detailLeaderAss];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

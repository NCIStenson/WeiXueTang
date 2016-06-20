//
//  ZEMainView.m
//  WeiXueTang
//
//  Created by Stenson on 16/3/3.
//  Copyright © 2016年  Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#define kToolKitBtnMarginLeft   0.0f
#define kToolKitBtnMarginTop    40.0f
#define kToolKitBtnWidth        SCREEN_WIDTH
#define kToolKitBtnHeight       80.0f

// 导航栏
#define kNavBarWidth SCREEN_WIDTH
#define kNavBarHeight 64.0f
#define kNavBarMarginLeft 0.0f
#define kNavBarMarginTop 0.0f

// 导航栏标题
#define kNavTitleLabelWidth (SCREEN_WIDTH - 110.0f)
#define kNavTitleLabelHeight 44.0f
#define kNavTitleLabelMarginLeft (kNavBarWidth - kNavTitleLabelWidth) / 2.0f
#define kNavTitleLabelMarginTop 20.0f


#import "ZEMainView.h"

@implementation ZEMainView

-(id)initWithFrame:(CGRect)rect
{
    self = [super initWithFrame:rect];
    if (self) {
//        [self initView];
        
        [self initNavBar];
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
    
    UIButton * zhuanjiaAssessment = [UIButton buttonWithType:UIButtonTypeCustom];
    zhuanjiaAssessment.frame = CGRectMake(kToolKitBtnMarginLeft, kToolKitBtnMarginTop + kToolKitBtnHeight * 2, kToolKitBtnWidth, kToolKitBtnHeight);
    zhuanjiaAssessment.backgroundColor = [UIColor purpleColor];
    [zhuanjiaAssessment setTitle:@"专家评估" forState:UIControlStateNormal];
    [zhuanjiaAssessment setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:zhuanjiaAssessment];
    [zhuanjiaAssessment addTarget:self action:@selector(gozhuanjiaAssessmentView) forControlEvents:UIControlEventTouchUpInside];
}

-(void)initNavBar
{
    UIView *navBar                = [[UIView alloc] initWithFrame:CGRectMake(kNavBarMarginLeft, kNavBarMarginTop, kNavBarWidth, kNavBarHeight)];
    navBar.backgroundColor        = MAIN_NAV_COLOR;

    UILabel * _titleLabel         = [[UILabel alloc] initWithFrame:CGRectMake(kNavTitleLabelMarginLeft, kNavTitleLabelMarginTop, kNavTitleLabelWidth, kNavTitleLabelHeight)];
    _titleLabel.backgroundColor   = [UIColor clearColor];
    _titleLabel.textAlignment     = NSTextAlignmentCenter;
    _titleLabel.textColor         = [UIColor whiteColor];
    _titleLabel.font              = [UIFont systemFontOfSize:22.0f];
    _titleLabel.text              = @"宁波电力三基工具包";
    [navBar addSubview:_titleLabel];

    [self addSubview:navBar];

    UIImage * bannerImg           = [UIImage imageNamed:@"banner.jpg"];
    UIImageView * bannerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_WIDTH * (bannerImg.size.height / bannerImg.size.width))];
    bannerImageView.image         = bannerImg;
    [self addSubview:bannerImageView];
    
    for(int i = 0 ; i <  5; i ++){
        UIButton * enterBtn     = [UIButton buttonWithType:UIButtonTypeCustom];
        enterBtn.frame          = CGRectMake(0 + SCREEN_WIDTH / 3 * i, (bannerImageView.frame.origin.y + bannerImageView.frame.size.height) , SCREEN_WIDTH / 3, (IPHONE4S_LESS ? 100 : 120));
        [enterBtn setImage:[UIImage imageNamed:@"home_toolkit"] forState:UIControlStateNormal];
        [self addSubview:enterBtn];
        [enterBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        UILabel * tipsLabel     = [[UILabel alloc]init];
        tipsLabel.font          = [UIFont systemFontOfSize:14];
        tipsLabel.textAlignment = NSTextAlignmentCenter;
        tipsLabel.frame         = CGRectMake(enterBtn.frame.origin.x, (enterBtn.frame.origin.y +( IPHONE4S_LESS ? 85 : 120)), SCREEN_WIDTH/3,30);
        [self addSubview:tipsLabel];
        
        switch (i) {
            case 0:
                [enterBtn setImage:[UIImage imageNamed:@"home_toolkit"] forState:UIControlStateNormal];
                tipsLabel.text  = @"工具包";
                [enterBtn addTarget:self action:@selector(goToolKitView) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 1:
                [enterBtn setImage:[UIImage imageNamed:@"home_expertsassess"] forState:UIControlStateNormal];
                tipsLabel.text  = @"专家评估";
                [enterBtn addTarget:self action:@selector(gozhuanjiaAssessmentView) forControlEvents:UIControlEventTouchUpInside];

                break;
            case 2:
                [enterBtn setImage:[UIImage imageNamed:@"home_personalskills"] forState:UIControlStateNormal];
                tipsLabel.text  = @"个人技能库";
                [enterBtn addTarget:self action:@selector(goPersonalSkillView) forControlEvents:UIControlEventTouchUpInside];

                break;
            case 3:
                enterBtn.frame  = CGRectMake(0 , (bannerImageView.frame.origin.y + bannerImageView.frame.size.height) + ( IPHONE4S_LESS ? 100 : 150) , SCREEN_WIDTH / 3, (IPHONE4S_LESS ? 100 : 120));
                tipsLabel.frame = CGRectMake(enterBtn.frame.origin.x,enterBtn.frame.origin.y + ( IPHONE4S_LESS ? 85 : 120), SCREEN_WIDTH/3,30);
                tipsLabel.text  = @"点赞表";
                [enterBtn addTarget:self action:@selector(goDianZanView) forControlEvents:UIControlEventTouchUpInside];
                [enterBtn setImage:[UIImage imageNamed:@"tab_dianzan"] forState:UIControlStateNormal];
                break;
            case 4:
            {
                if(![[ZESetLocalData getRoleFlag] boolValue]){
                    break;
                }
                [enterBtn setImage:[UIImage imageNamed:@"home_toolkit"] forState:UIControlStateNormal];
                tipsLabel.text  = @"班组长评估";
                enterBtn.frame  = CGRectMake(SCREEN_WIDTH / 3 * (i - 3) , (bannerImageView.frame.origin.y + bannerImageView.frame.size.height) + ( IPHONE4S_LESS ? 100 : 150) , SCREEN_WIDTH / 3, (IPHONE4S_LESS ? 100 : 120));
                tipsLabel.frame = CGRectMake(enterBtn.frame.origin.x,enterBtn.frame.origin.y + ( IPHONE4S_LESS ? 85 : 120), SCREEN_WIDTH/3,30);
                [enterBtn addTarget:self action:@selector(goLeaderAssessmentVC) forControlEvents:UIControlEventTouchUpInside];
            }
                break;

            default:
                break;
        }
        
    }
    
    
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

-(void)gozhuanjiaAssessmentView
{
    if ([self.delegate respondsToSelector:@selector(gozhuanjiaAssessmentView) ]) {
        [self.delegate gozhuanjiaAssessmentView];
    }
}
-(void)goPersonalSkillView
{
    if ([self.delegate respondsToSelector:@selector(goPersonalSkillView)]) {
        [self.delegate goPersonalSkillView];
    }
}
-(void)goLeaderAssessmentVC
{
    if ([self.delegate respondsToSelector:@selector(goLeaderAssessmentVC)]) {
        [self.delegate goLeaderAssessmentVC];
    }
}



@end

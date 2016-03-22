//
//  ZEDetailProjectView.m
//  WeiXueTang
//
//  Created by Stenson on 16/3/22.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//


#define kContentNameLableMarginLeft 10.0f
#define kContentNameLabelMarginTop  0.0f
#define kContentNameLabelWidth      95.0f
#define kContentNameLabelHeight     40.0f

#define kContentLabelMarginLeft kContentNameLabelWidth + 10.0f
#define kContentLabelMarginTop  0.0f
#define kContentLabelWidth      (SCREEN_WIDTH - kContentNameLabelWidth - 15.0f)
#define kContentLabelHeight     40.0f

#import "ZEDetailProjectView.h"
#import "Masonry.h"

@interface ZEDetailProjectView ()
{
    ZEExpertAssModel * _detailExpertAssM;
}
@end

@implementation ZEDetailProjectView

-(id)initWithFrame:(CGRect)frame withModel:(ZEExpertAssModel *)expert;
{
    self = [super initWithFrame:frame];
    if (self) {
        _detailExpertAssM = expert;
        [self initProjectNameView];
    }
    return self;
}

-(void)initProjectNameView
{
    UIView * projectNameView        = [[UIView alloc]initWithFrame:CGRectZero];
    [self addSubview:projectNameView];
    [projectNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 40));
    }];
    
    UILabel * contentNameLable = [[UILabel alloc]init];
    contentNameLable.text = @"项目名称：";
    contentNameLable.font = [UIFont systemFontOfSize:13];
    [projectNameView addSubview:contentNameLable];
    [contentNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kContentNameLableMarginLeft);
        make.top.mas_equalTo(kContentNameLabelMarginTop);
        make.size.mas_equalTo(CGSizeMake(kContentNameLabelWidth, kContentNameLabelHeight));
    }];
    
    UILabel * contentLable = [[UILabel alloc]init];
    contentLable.text = _detailExpertAssM.detail_PROJECTNAME;
    contentLable.font = [UIFont systemFontOfSize:13];
    contentLable.textColor = [UIColor lightGrayColor];
    [projectNameView addSubview:contentLable];
    [contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kContentLabelMarginLeft);
        make.top.mas_equalTo(kContentLabelMarginTop);
        make.size.mas_equalTo(CGSizeMake(kContentLabelWidth, kContentLabelHeight));
    }];
    
    [self initQuarlityRequire:40.0f];
}

-(void)initQuarlityRequire:(float)Yoffset
{
    NSString * quarlity          = [_detailExpertAssM.detail_QUALITY stringByReplacingOccurrencesOfString:@";" withString:@";\n"];
    float quarlityHeight         = [ZEUtil heightForString:quarlity font:[UIFont systemFontOfSize:13] andWidth:kContentLabelWidth];
    UIView * quarlityView        = [[UIView alloc]initWithFrame:CGRectZero];
    [self addSubview:quarlityView];
    [quarlityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(Yoffset);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, quarlityHeight));
    }];
    
    UILabel * contentNameLable = [[UILabel alloc]init];
    contentNameLable.text = @"质量要求：";
    contentNameLable.font = [UIFont systemFontOfSize:13];
    [quarlityView addSubview:contentNameLable];
    [contentNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kContentNameLableMarginLeft);
        make.top.mas_equalTo(kContentNameLabelMarginTop);
        make.size.mas_equalTo(CGSizeMake(kContentNameLabelWidth, 17));
    }];
    
    UILabel * contentLable = [[UILabel alloc]init];
    contentLable.numberOfLines = 0;
    contentLable.text = _detailExpertAssM.detail_QUALITY;
    contentLable.font = [UIFont systemFontOfSize:13];
    contentLable.textColor = [UIColor lightGrayColor];
    [quarlityView addSubview:contentLable];
    [contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kContentLabelMarginLeft);
        make.top.mas_equalTo(kContentLabelMarginTop);
        make.size.mas_equalTo(CGSizeMake(kContentLabelWidth, quarlityHeight));
    }];
    
    [self initScoreView:(Yoffset + quarlityHeight)];
}

-(void)initScoreView:(float)Yoffset
{
    UIView * scoreView        = [[UIView alloc]initWithFrame:CGRectMake(0, Yoffset, SCREEN_WIDTH, 40)];
    [self addSubview:scoreView];
    [scoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(Yoffset);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 40));
    }];
    
    UILabel * contentNameLable = [[UILabel alloc]init];
    contentNameLable.text = @"分值：";
    contentNameLable.font = [UIFont systemFontOfSize:13];
    [scoreView addSubview:contentNameLable];
    [contentNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kContentNameLableMarginLeft);
        make.top.mas_equalTo(kContentNameLabelMarginTop);
        make.size.mas_equalTo(CGSizeMake(kContentNameLabelWidth, kContentNameLabelHeight));
    }];
    
    UILabel * contentLable = [[UILabel alloc]init];
    contentLable.numberOfLines = 0;
    contentLable.text = _detailExpertAssM.detail_MARKS;
    contentLable.font = [UIFont systemFontOfSize:13];
    contentLable.textColor = [UIColor lightGrayColor];
    [scoreView addSubview:contentLable];
    [contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kContentLabelMarginLeft);
        make.top.mas_equalTo(kContentLabelMarginTop);
        make.size.mas_equalTo(CGSizeMake(kContentLabelWidth, kContentLabelHeight));
    }];
    
    [self initScoreCiriteriaView:Yoffset + 40];
}
-(void)initScoreCiriteriaView:(float)Yoffset
{
    NSString * scoreCriteriaStr        = [_detailExpertAssM.detail_BENCHMARK stringByReplacingOccurrencesOfString:@"；" withString:@"；\n"];
    float scoreCirteriaHeight          = [ZEUtil heightForString:scoreCriteriaStr font:[UIFont systemFontOfSize:13] andWidth:kContentLabelWidth];
    UIView * scoreCiriteriaView        = [[UIView alloc]initWithFrame:CGRectZero];
    [self addSubview:scoreCiriteriaView];
    [scoreCiriteriaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(Yoffset);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, scoreCirteriaHeight));
    }];
    
    UILabel * contentNameLable = [[UILabel alloc]init];
    contentNameLable.text = @"评分标准：";
    contentNameLable.font = [UIFont systemFontOfSize:13];
    [scoreCiriteriaView addSubview:contentNameLable];
    [contentNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kContentNameLableMarginLeft);
        make.top.mas_equalTo(kContentNameLabelMarginTop);
        make.size.mas_equalTo(CGSizeMake(kContentNameLabelWidth, kContentNameLabelHeight));
    }];
    
    UILabel * contentLable = [[UILabel alloc]init];
    contentLable.numberOfLines = 0;
    contentLable.text = _detailExpertAssM.detail_BENCHMARK;
    contentLable.font = [UIFont systemFontOfSize:13];
    contentLable.textColor = [UIColor lightGrayColor];
    [scoreCiriteriaView addSubview:contentLable];
    [contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kContentLabelMarginLeft);
        make.top.mas_equalTo(kContentLabelMarginTop);
        make.size.mas_equalTo(CGSizeMake(kContentLabelWidth, kContentLabelHeight));
    }];
    
    [self initExpertScoreView:Yoffset + 40];
}

-(void)initExpertScoreView:(float)YOffset
{
    UIView * expertScoreView        = [[UIView alloc]initWithFrame:CGRectZero];
    expertScoreView.backgroundColor = [UIColor whiteColor];
    [self addSubview:expertScoreView];
    [expertScoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(YOffset);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 40));
    }];
    
    UILabel * contentNameLable = [[UILabel alloc]init];
    contentNameLable.text = @"基层专家评分";
    contentNameLable.font = [UIFont systemFontOfSize:13];
    [expertScoreView addSubview:contentNameLable];
    [contentNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kContentNameLableMarginLeft);
        make.top.mas_equalTo(kContentNameLabelMarginTop);
        make.size.mas_equalTo(CGSizeMake(kContentNameLabelWidth, kContentNameLabelHeight));
    }];
    
    UITextField * contentField = [[UITextField alloc]init];
    contentField.text = @"0";
    contentField.font = [UIFont systemFontOfSize:13];
    contentField.textColor = [UIColor blackColor];
    [expertScoreView addSubview:contentField];
    contentField.clipsToBounds = YES;
    contentField.layer.cornerRadius = 5;
    contentField.backgroundColor = MAIN_LINE_COLOR;
    contentField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
    contentField.leftViewMode = UITextFieldViewModeAlways;
    [contentField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kContentLabelMarginLeft);
        make.top.mas_equalTo(2);
        make.size.mas_equalTo(CGSizeMake(kContentLabelWidth, 36));
    }];

    
    [self initExpertRemark:YOffset + 40];
}
-(void)initExpertRemark:(CGFloat)YOffset
{
    UIView * expertScoreView        = [[UIView alloc]initWithFrame:CGRectZero];
    [self addSubview:expertScoreView];
    [expertScoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(YOffset);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 100));
    }];
    
    UILabel * contentNameLable = [[UILabel alloc]init];
    contentNameLable.text = @"基层专家评分说明：";
    contentNameLable.font = [UIFont systemFontOfSize:13];
    [expertScoreView addSubview:contentNameLable];
    [contentNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kContentNameLableMarginLeft);
        make.top.mas_equalTo(kContentNameLabelMarginTop);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, kContentNameLabelHeight));
    }];
}
@end

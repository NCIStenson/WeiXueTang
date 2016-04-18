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
#import "ZEExpertAssessmentCache.h"
@interface ZEDetailProjectView ()<UITextViewDelegate,UITextFieldDelegate,UIScrollViewDelegate>
{
    ZEExpertAssModel * _detailExpertAssM;
    UIScrollView * _scrollView;
    
    EXPERTASSESSMENT_TYPE _expertAssType;//是否评估过状态
}
@property (nonatomic,assign) NSInteger indexRow;

@end

@implementation ZEDetailProjectView

-(id)initWithFrame:(CGRect)frame withModel:(ZEExpertAssModel *)expert withType:(EXPERTASSESSMENT_TYPE)type withIndex:(NSInteger)index
{
    self = [super initWithFrame:frame];
    if (self) {
        _indexRow = index;
        _expertAssType = type;
        _detailExpertAssM = expert;
        [self initProjectNameView];
    }
    return self;
}

-(void)initProjectNameView
{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
    [self addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, self.frame.size.height));
    }];
    UITapGestureRecognizer * sigleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture)];
    sigleTap.numberOfTapsRequired = 1;
    
    [_scrollView addGestureRecognizer:sigleTap];

    
    UIView * projectNameView        = [[UIView alloc]initWithFrame:CGRectZero];
    [_scrollView addSubview:projectNameView];
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
    [_scrollView addSubview:quarlityView];
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
    [_scrollView addSubview:scoreView];
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
    [_scrollView addSubview:scoreCiriteriaView];
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
    [_scrollView addSubview:expertScoreView];
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
    
    self.contentField                    = [[UITextField alloc]init];
    _contentField.keyboardType       = UIKeyboardTypePhonePad;
    _contentField.delegate           = self;
    _contentField.placeholder        = _detailExpertAssM.detail_EXPERTSCORE;
    _contentField.font               = [UIFont systemFontOfSize:13];
    _contentField.textColor          = [UIColor blackColor];
    [expertScoreView addSubview:_contentField];
    _contentField.clipsToBounds      = YES;
    _contentField.layer.cornerRadius = 5;
    _contentField.backgroundColor    = MAIN_LINE_COLOR;
    _contentField.leftView           = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
    _contentField.leftViewMode       = UITextFieldViewModeAlways;
    if ([[[ZEExpertAssessmentCache instance]getScoreWithIndex:_indexRow] integerValue] != 0) {
        _contentField.text = [[ZEExpertAssessmentCache instance]getScoreWithIndex:_indexRow];
    }
    [_contentField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kContentLabelMarginLeft);
        make.top.mas_equalTo(2);
        make.size.mas_equalTo(CGSizeMake(kContentLabelWidth, 36));
    }];
    [_contentField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    if (_expertAssType == EXPERTASSESSMENT_TYPE_DONE) {
        _contentField.enabled = NO;
    }
    
    [self initExpertRemark:YOffset + 40];
}
-(void)initExpertRemark:(CGFloat)YOffset
{
    UIView * expertRemarkView        = [[UIView alloc]initWithFrame:CGRectZero];
    [_scrollView addSubview:expertRemarkView];

    [expertRemarkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(YOffset);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 100));
    }];
    
    UILabel * contentNameLable = [[UILabel alloc]init];
    contentNameLable.text = @"基层专家评分说明：";
    contentNameLable.font = [UIFont systemFontOfSize:13];
    [expertRemarkView addSubview:contentNameLable];
    [contentNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kContentNameLableMarginLeft);
        make.top.mas_equalTo(kContentNameLabelMarginTop);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, kContentNameLabelHeight));
    }];
    
    _remarkTextView = [[UITextView alloc]init];
    _remarkTextView.backgroundColor = MAIN_LINE_COLOR;
    [expertRemarkView addSubview:_remarkTextView];
    _remarkTextView.textContainerInset = UIEdgeInsetsMake(10, 10, 0, 10);//设置页边距
    _remarkTextView.clipsToBounds = YES;
    _remarkTextView.delegate = self;
    _remarkTextView.layer.cornerRadius = 5;
    [_remarkTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kContentNameLableMarginLeft);
        make.top.mas_equalTo(30);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 70));

    }];

    if (![[[ZEExpertAssessmentCache instance]getRemarkWithIndex:_indexRow] isEqualToString:@""]) {
        _remarkTextView.text = [[ZEExpertAssessmentCache instance]getRemarkWithIndex:_indexRow];
    }
    if (_expertAssType == EXPERTASSESSMENT_TYPE_DONE) {
        _remarkTextView.editable = NO;
    }
    
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, YOffset + 100);
}

#pragma mark - UITextFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.29 animations:^{
        if (_scrollView.contentSize.height > SCREEN_HEIGHT - NAV_HEIGHT) {
            _scrollView.frame = CGRectMake(0, -252, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT);
        }else{
            if (_scrollView.contentSize.height  + 280 + 36 > SCREEN_HEIGHT) {
                _scrollView.frame = CGRectMake(0,  ((SCREEN_HEIGHT - 64 )- (_scrollView.contentSize.height + 252)) , SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT);
            }
        }
    }];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldDidChange:(UITextField *)textField
{
    if ([textField.text floatValue] > [_detailExpertAssM.detail_MARKS floatValue]) {
        
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"输入分数不能大于分值" message:nil delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alertView show];
        
        textField.text = [textField.text substringToIndex:textField.text.length - 1];
    }
    
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{

}

#pragma mark - UITextViewDelegate

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.29 animations:^{
        if (_scrollView.contentSize.height > SCREEN_HEIGHT - NAV_HEIGHT) {
            _scrollView.frame = CGRectMake(0, -252, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT);
        }else{
            if (_scrollView.contentSize.height  + 252 > SCREEN_HEIGHT - NAV_HEIGHT) {
                _scrollView.frame = CGRectMake(0,  ((SCREEN_HEIGHT - 64 )- (_scrollView.contentSize.height + 252)) , SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT);
            }
        }
    }];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
}


#pragma mark - downTheKeyBoard

-(void)handleTapGesture
{
    [UIView animateWithDuration:0.29 animations:^{
        _scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT);
    }];
    [self endEditing:YES];
}


@end

//
//  ZEDownloadView.m
//  WeiXueTang
//
//  Created by Stenson on 16/4/5.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

//#define labelTextColor [UIColor colorWithRed:28/255.0 green:157/255.0 blue:209/255.0 alpha:1]

#import "ZEDownloadSearchView.h"
#import "Masonry.h"
@interface ZEDownloadSearchView ()
{
    CALayer * lineLayer;
    UITableView * _contentTableView;
    UITextField * _textField;
}

@property (nonatomic,strong) NSMutableArray * allSearchArr;
@property (nonatomic,strong) NSMutableArray * searchArr;

@end

@implementation ZEDownloadSearchView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self initView];
        [self initContentView];
    }
    return self;
}

//-(void)initView
//{
//    for (int i = 0; i < 2; i ++) {
//        UIButton * downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        
//        downloadBtn.frame =  CGRectMake(0 + SCREEN_WIDTH / 2 * i, 0, SCREEN_WIDTH / 2, 33);
//        [downloadBtn setTitle:@"课件下载" forState:UIControlStateNormal];
//        [downloadBtn setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
//        downloadBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//        [self addSubview:downloadBtn];
//        [downloadBtn addTarget:self action:@selector(changeChildView:) forControlEvents:UIControlEventTouchUpInside];
//        
//        if(i == 1){
//            [downloadBtn setTitle:@"本地文件" forState:UIControlStateNormal];
//        }
//    }
//    
//    lineLayer = [CALayer layer];
//    lineLayer.frame = CGRectMake(0, 33.0f, SCREEN_WIDTH / 2, 2.0f);
//    lineLayer.backgroundColor = [MAIN_COLOR CGColor];
//    [self.layer addSublayer:lineLayer];
//}
//
//-(void)changeChildView:(UIButton *)button
//{
//    lineLayer.frame = CGRectMake(button.frame.origin.x, 33.0f, SCREEN_WIDTH / 2, 2.0f);
//}

-(void)initContentView
{
    _contentTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _contentTableView.delegate = self;
    _contentTableView.dataSource = self;
    _contentTableView.showsVerticalScrollIndicator = NO;
    _contentTableView.showsHorizontalScrollIndicator = NO;
    _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_contentTableView];
    [_contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0.0f);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT - 40 - 49));
    }];
}
#pragma mark - Public Method

-(void)contentViewReloadData:(NSArray *)arr
{
    self.allSearchArr = arr;
    self.searchArr = [NSMutableArray arrayWithArray:arr];
    [_contentTableView reloadData];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * searchView = [[UIView alloc]init];
    searchView.backgroundColor = [UIColor whiteColor];
    
    _textField = [[UITextField alloc]initWithFrame:CGRectZero];
    [searchView addSubview:_textField];
    _textField.backgroundColor = [UIColor clearColor];
    [_textField setClipsToBounds:YES];
    [_textField.layer setCornerRadius:15.0f];
    _textField.layer.borderWidth = 0.5;
    _textField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _textField.placeholder = @"请输入搜索信息...";
    _textField.leftViewMode = UITextFieldViewModeAlways;
    _textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15.0f, 30.0f)];
    [_textField setDelegate:self];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10.0f);
        make.right.mas_equalTo(-10.0f);
        make.top.mas_equalTo(10.0f);
        make.bottom.mas_equalTo(-10.0f);
    }];
    [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(beginSearchFile) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:searchBtn];
    searchBtn.backgroundColor = [UIColor redColor];
    searchBtn.contentMode = UIViewContentModeRight;
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH - 70.0f);
        //        make.right.mas_equalTo(-10.0f);
        make.top.mas_equalTo(10.0f);
        make.size.mas_equalTo(CGSizeMake(40.0f, 30.0f));
    }];
    
    CALayer * backgroundLayer = [CALayer layer];
    backgroundLayer.frame = CGRectMake(0, 49.5f, SCREEN_WIDTH, 0.5f);
    backgroundLayer.backgroundColor = [MAIN_LINE_COLOR CGColor];
    [searchView.layer addSublayer:backgroundLayer];
    
    return searchView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ZEPersonalSkillModel * skillM = [ZEPersonalSkillModel getDetailModelWithDic:self.searchArr[indexPath.row]];
//    
//    float cellH = [ZEUtil heightForString:skillM.skill_name font:[UIFont systemFontOfSize:14] andWidth:SCREEN_WIDTH  - 80];
    
    return 0 + 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    ZEPersonalSkillModel * skillM = [ZEPersonalSkillModel getDetailModelWithDic:self.searchArr[indexPath.row]];
    
    for (UIView * view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
//    float cellH = [ZEUtil heightForString:skillM.skill_name font:[UIFont systemFontOfSize:14] andWidth:SCREEN_WIDTH  - 80];
    
//    UILabel * nameLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 80, cellH)];
//    [cell.contentView addSubview:nameLable];
//    nameLable.text = skillM.skill_name;
//    nameLable.numberOfLines = 0;
//    nameLable.font = [UIFont systemFontOfSize:14];
    
    CALayer * cellLineLayer = [CALayer layer];
//    cellLineLayer.frame = CGRectMake(SCREEN_WIDTH - 60, 5, 0.5, cellH + 10);
    [cell.contentView.layer addSublayer:cellLineLayer];
    cellLineLayer.backgroundColor = [MAIN_LINE_COLOR CGColor];
    
    UIButton * dianzanBtn     = [UIButton buttonWithType:UIButtonTypeCustom];
//    dianzanBtn.frame          = CGRectMake(SCREEN_WIDTH - 60,0,60,cellH + 20);
//    dianzanBtn.tag = indexPath.row;
//    if ([skillM.state integerValue] == 60) {
//        [dianzanBtn setImage:[UIImage imageNamed:[ZEUtil getDianZanTypeImageName:DIANZAN_TYPE_Master]] forState:UIControlStateNormal];
//    }else{
        [dianzanBtn setImage:[UIImage imageNamed:[ZEUtil getDianZanTypeImageName:DIANZAN_TYPE_NO]] forState:UIControlStateNormal];
        [dianzanBtn addTarget:self action:@selector(dianZanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    }
    [cell.contentView addSubview:dianzanBtn];
    [dianzanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    return cell;
}

-(void)beginSearchFile
{
    NSLog(@"beginSearchFile");
    [_textField resignFirstResponder];
    if([self.delegate respondsToSelector:@selector(beginSearch:)]){
        [self.delegate beginSearch:_textField.text];
    }
}

-(void)dianZanBtnClick:(UIButton *)button
{
//    ZEPersonalSkillModel * personSkillM = [ZEPersonalSkillModel getDetailModelWithDic:self.searchArr[button.tag]];
//    if ([self.delegate respondsToSelector:@selector(skillSelf:withID:)]) {
//        [self.delegate skillSelf:self withID:personSkillM.seqkey];
//    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ZEPersonalSkillModel * personSkillM = [ZEPersonalSkillModel getDetailModelWithDic:self.searchArr[indexPath.row]];
//    if ([self.delegate respondsToSelector:@selector(enterSkillFileVC:)]) {
//        [self.delegate enterSkillFileVC:personSkillM.course_path];
//    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldDidChange:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""]) {
        self.searchArr = [NSMutableArray arrayWithArray:self.allSearchArr];
        [_contentTableView reloadData];
        return YES;
    }
    self.searchArr = [NSMutableArray array];
    for (int i = 0 ; i < self.allSearchArr.count; i ++) {
//        ZEPersonalSkillModel * personSkillM = [ZEPersonalSkillModel getDetailModelWithDic:self.personSkillArr[i]];
        }
    [_contentTableView reloadData];
    
    
    return YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![_textField isExclusiveTouch]) {
        [_textField resignFirstResponder];
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

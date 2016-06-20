//
//  ZEPersonalSkillView.m
//  WeiXueTang
//
//  Created by Stenson on 16/3/29.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import "ZEPersonalSkillView.h"
#import "Masonry.h"
#import "ZEPersonalSkillModel.h"

@interface ZEPersonalSkillView ()
{
    UITextField * _textField;
    UITableView * _contentTableView;
}

@property (nonnull,nonatomic,strong) NSArray * personSkillArr;
@property (nonnull,nonatomic,strong) NSMutableArray * searchArr;

@end

@implementation ZEPersonalSkillView


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}
-(void)initView
{
    _contentTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _contentTableView.delegate = self;
    _contentTableView.dataSource = self;
    _contentTableView.showsVerticalScrollIndicator = NO;
    _contentTableView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_contentTableView];
    [_contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(NAV_HEIGHT);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT));
    }];
}
#pragma mark - Public Method

-(void)contentViewReloadData:(NSArray *)arr
{
    self.personSkillArr = arr;
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
    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * searchView = [[UIView alloc]init];
    searchView.backgroundColor = MAIN_LINE_COLOR;
    
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
        make.top.mas_equalTo(5.0f);
        make.bottom.mas_equalTo(-5.0f);
    }];
    [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    UIImageView *searchIcon = [[UIImageView alloc] initWithFrame: CGRectZero];
    searchIcon.image = [UIImage imageNamed:@"icon_search"];
    [searchView addSubview:searchIcon];
    searchIcon.contentMode = UIViewContentModeRight;
    searchIcon.backgroundColor = [UIColor clearColor];
    searchIcon.clipsToBounds = YES;
    searchIcon.userInteractionEnabled = YES;
    [searchIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH - 70.0f);
        //        make.right.mas_equalTo(-10.0f);
        make.top.mas_equalTo(5.0f);
        make.size.mas_equalTo(CGSizeMake(40.0f, 30.0f));
    }];
    
    return searchView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZEPersonalSkillModel * skillM = [ZEPersonalSkillModel getDetailModelWithDic:self.searchArr[indexPath.row]];

    float cellH = [ZEUtil heightForString:skillM.skill_name font:[UIFont systemFontOfSize:14] andWidth:SCREEN_WIDTH  - 80];
    
    return cellH + 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ZEPersonalSkillModel * skillM = [ZEPersonalSkillModel getDetailModelWithDic:self.searchArr[indexPath.row]];
    
    for (UIView * view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    float cellH = [ZEUtil heightForString:skillM.skill_name font:[UIFont systemFontOfSize:14] andWidth:SCREEN_WIDTH  - 80];

    UILabel * nameLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 80, cellH)];
    [cell.contentView addSubview:nameLable];
    nameLable.text = skillM.skill_name;
    nameLable.numberOfLines = 0;
    nameLable.font = [UIFont systemFontOfSize:14];

    CALayer * lineLayer = [CALayer layer];
    lineLayer.frame = CGRectMake(SCREEN_WIDTH - 60, 5, 0.5, cellH + 10);
    [cell.contentView.layer addSublayer:lineLayer];
    lineLayer.backgroundColor = [MAIN_LINE_COLOR CGColor];
    
    UIButton * dianzanBtn     = [UIButton buttonWithType:UIButtonTypeCustom];
    dianzanBtn.frame          = CGRectMake(SCREEN_WIDTH - 60,0,60,cellH + 20);
    dianzanBtn.tag = indexPath.row;
    
    NSLog(@">>  %@",skillM.state);

    if ([skillM.state integerValue] == 60) {
        [dianzanBtn setImage:[UIImage imageNamed:[ZEUtil getDianZanTypeImageName:DIANZAN_TYPE_Master]] forState:UIControlStateNormal];
    }else if ([skillM.state integerValue] == 2){
        [dianzanBtn setImage:[UIImage imageNamed:[ZEUtil getDianZanTypeImageName:DIANZAN_TYPE_DOING]] forState:UIControlStateNormal];
    }else{
        [dianzanBtn setImage:[UIImage imageNamed:[ZEUtil getDianZanTypeImageName:DIANZAN_TYPE_NO]] forState:UIControlStateNormal];
        [dianzanBtn addTarget:self action:@selector(dianZanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    [cell.contentView addSubview:dianzanBtn];
    [dianzanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    return cell;
}

-(void)dianZanBtnClick:(UIButton *)button
{
    ZEPersonalSkillModel * personSkillM = [ZEPersonalSkillModel getDetailModelWithDic:self.searchArr[button.tag]];
    if ([self.delegate respondsToSelector:@selector(skillSelf:withID:)]) {
        [self.delegate skillSelf:self withID:personSkillM.seqkey];
    }    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZEPersonalSkillModel * personSkillM = [ZEPersonalSkillModel getDetailModelWithDic:self.searchArr[indexPath.row]];
    if ([self.delegate respondsToSelector:@selector(enterSkillFileVC:)]) {
        [self.delegate enterSkillFileVC:personSkillM.course_path];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldDidChange:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""]) {
        self.searchArr = [NSMutableArray arrayWithArray:self.personSkillArr];
        [_contentTableView reloadData];
        return YES;
    }
    self.searchArr = [NSMutableArray array];
    for (int i = 0 ; i < self.personSkillArr.count; i ++) {
        ZEPersonalSkillModel * personSkillM = [ZEPersonalSkillModel getDetailModelWithDic:self.personSkillArr[i]];
        if([personSkillM.skill_name rangeOfString:textField.text].location !=NSNotFound){
            [self.searchArr addObject:self.personSkillArr[i]];
        }else{

        }
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

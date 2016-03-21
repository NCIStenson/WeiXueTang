//
//  ZEToolKitView.m
//  WeiXueTang
//
//  Created by Stenson on 16/3/7.
//  Copyright © 2016年  Zenith Electronic Technology Co., Ltd. All rights reserved.
//


#define kContentViewMarginLeft  0.0f
#define kContentViewMarginTop   (kSearchViewHeight)
#define kContentViewWidth       SCREEN_WIDTH
#define kContentViewHeight      (SCREEN_HEIGHT - 64.0f - 44.0f)

#define kSearchViewMarginLeft  0.0f
#define kSearchViewMarginTop   0.0f
#define kSearchViewWidth       SCREEN_WIDTH
#define kSearchViewHeight      44.0f

#import "ZEToolKitView.h"
#import "Masonry.h"

#import "ZEToolKitModel.h"

@interface ZEToolKitView()
{
    UITableView * _contentView;
    UITextField * _textField;
}
@property (nonatomic,retain) NSArray * toolKitListArr;  //   工具包数据列表
@property (nonatomic,retain) NSMutableArray * searchArr;  //  本地搜索

@end

@implementation ZEToolKitView

-(id)initWithFrame:(CGRect)rect
{
    self = [super initWithFrame:rect];
    if (self) {
        [self initView];
        [self initSearchView];
    }
    return self;
}

#pragma mark - initView

-(void)initView
{
    _contentView =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _contentView.delegate = self;
    _contentView.dataSource =self;
    [self addSubview:_contentView];
    _contentView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kContentViewMarginLeft);
        make.top.mas_equalTo(kContentViewMarginTop);
        make.size.mas_equalTo(CGSizeMake(kContentViewWidth,kContentViewHeight));
    }];
}

-(void)initSearchView
{
    UIView * searchView = [[UIView alloc]init];
    searchView.backgroundColor = MAIN_LINE_COLOR;
    [self addSubview:searchView];
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kSearchViewMarginLeft);
        make.top.mas_equalTo(kSearchViewMarginTop);
        make.size.mas_equalTo(CGSizeMake(kSearchViewWidth,kSearchViewHeight));
    }];
    
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

}

#pragma mark - Public Method

-(void)contentViewReloadData:(NSArray *)arr
{
    self.toolKitListArr = arr;
    self.searchArr = [NSMutableArray arrayWithArray:arr];
    [_contentView reloadData];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ZEToolKitModel * toolKitM = [ZEToolKitModel getDetailWithDic:self.searchArr[indexPath.row]];
    cell.textLabel.text = toolKitM.SKILL_NAME;
    
    return cell;
}
#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (![_textField isExclusiveTouch]) {
        [_textField resignFirstResponder];
    }

    ZEToolKitModel * toolKitM = [ZEToolKitModel getDetailWithDic:self.searchArr[indexPath.row]];
    if ([self.delegate respondsToSelector:@selector(selectToolKitWithSkillID:)]) {
        [self.delegate selectToolKitWithSkillID:toolKitM.SEQKEY];
    }
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldDidChange:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""]) {
        self.searchArr = [NSMutableArray arrayWithArray:self.toolKitListArr];
        [_contentView reloadData];
        return YES;
    }
    self.searchArr = [NSMutableArray array];
    for (int i = 0 ; i < self.toolKitListArr.count; i ++) {
        ZEToolKitModel * toolKitM = [ZEToolKitModel getDetailWithDic:self.toolKitListArr[i]];
        if([toolKitM.SKILL_NAME rangeOfString:textField.text].location !=NSNotFound){
            NSLog(@"yes");
            [self.searchArr addObject:self.toolKitListArr[i]];
        }else{
            NSLog(@"no");
        }
    }
    [_contentView reloadData];
    

    return YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![_textField isExclusiveTouch]) {
        [_textField resignFirstResponder];
    }
}

@end

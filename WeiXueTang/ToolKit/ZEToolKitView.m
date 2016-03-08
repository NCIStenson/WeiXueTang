//
//  ZEToolKitView.m
//  WeiXueTang
//
//  Created by Stenson on 16/3/7.
//  Copyright © 2016年 Stenson. All rights reserved.
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
}
@property (nonatomic,retain) NSArray * toolKitListArr;  //   工具包数据列表

@end

@implementation ZEToolKitView

-(id)initWithFrame:(CGRect)rect
{
    self = [super initWithFrame:rect];
    if (self) {
        [self initView];
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
    
    UIView * searchView = [[UIView alloc]init];
    searchView.backgroundColor = [UIColor redColor];
    [self addSubview:searchView];
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kSearchViewMarginLeft);
        make.top.mas_equalTo(kSearchViewMarginTop);
        make.size.mas_equalTo(CGSizeMake(kSearchViewWidth,kSearchViewHeight));
    }];
    
}

#pragma mark - Public Method

-(void)contentViewReloadData:(NSArray *)arr
{
    self.toolKitListArr = arr;
    [_contentView reloadData];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.toolKitListArr.count;
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
    
    ZEToolKitModel * toolKitM = [ZEToolKitModel getDetailWithDic:self.toolKitListArr[indexPath.row]];
    cell.textLabel.text = toolKitM.SKILL_NAME;
    
    return cell;
}
#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    ZEToolKitModel * toolKitM = [ZEToolKitModel getDetailWithDic:self.toolKitListArr[indexPath.row]];
    if ([self.delegate respondsToSelector:@selector(selectToolKitWithSkillID:)]) {
        [self.delegate selectToolKitWithSkillID:toolKitM.SEQKEY];
    }
}


@end

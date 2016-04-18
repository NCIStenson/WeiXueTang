 //
//  ZEExpertAssessmentView.m
//  WeiXueTang
//
//  Created by Stenson on 16/3/21.
//  Copyright © 2016年  Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import "ZEExpertAssessmentView.h"
#import "Masonry.h"
#import "ZEExpertAssModel.h"
@interface ZEExpertAssessmentView ()
{
    CGRect _frameRect;
    UITableView * _contentTableView;
}

@property (nonatomic,retain) NSArray * dataArr;

@end

@implementation ZEExpertAssessmentView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _frameRect = frame;
        [self initView];
    }
    return self;
}

-(void)initView
{
    _contentTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _contentTableView.dataSource = self;
    _contentTableView.delegate = self;
    _contentTableView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_contentTableView];
    [_contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, _frameRect.size.height));
    }];
}

#pragma mark - Public Method

-(void)expertAssessmentReloadView:(NSArray *)arr
{
    self.dataArr = arr;
    [_contentTableView reloadData];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdenetifer = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdenetifer];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdenetifer];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ZEExpertAssModel * expertM = self.dataArr[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ 【%@ %@】",expertM.SKILL_NAME,expertM.PSNNAME,expertM.ORGNAME];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    
    
    CALayer * lineLayer = [CALayer layer];
    lineLayer.frame = CGRectMake(0, 43.5f, SCREEN_WIDTH, 0.5f);
    lineLayer.backgroundColor = [MAIN_LINE_COLOR CGColor];
    [cell.contentView.layer addSublayer:lineLayer];
    
    return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(didSelectRow:)]) {
        [self.delegate didSelectRow:indexPath.row];
    }
}


@end

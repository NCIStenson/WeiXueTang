//
//  ZEExpertAssDetailView.m
//  WeiXueTang
//
//  Created by Stenson on 16/3/21.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import "ZEExpertAssDetailView.h"

#import "ZEExpertAssessmentCache.h"

@interface ZEExpertAssDetailView ()<UITextFieldDelegate>{
    CGRect _viewFrame;
    UITableView * _contentTableView;
    ZEExpertAssModel * _expertAssM;
    EXPERTASSESSMENT_TYPE _enterType;
    NSString * _currentStr;
    
    UILabel * _allScoreLabel;
}

@end

@implementation ZEExpertAssDetailView

-(id)initWithFrame:(CGRect)frame withModel:(ZEExpertAssModel *)model withType:(EXPERTASSESSMENT_TYPE)enterType;
{
    self = [super initWithFrame:frame];
    if (self) {
        _viewFrame = frame;
        _expertAssM = model;
        _enterType = enterType;
        [self initView];
    }
    return self;
}

-(void)initView
{
    _contentTableView                = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,_viewFrame.size.height) style:UITableViewStylePlain];
    _contentTableView.showsVerticalScrollIndicator = NO;
    _contentTableView.delegate       = self;
    _contentTableView.dataSource     = self;
    [self addSubview:_contentTableView];
    _contentTableView.bounces = NO;
    _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)reloadView
{
    [_contentTableView reloadData];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _expertAssM.detailarray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 150;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,150)];
    headerView.backgroundColor = [UIColor whiteColor];
    NSInteger allScore = 0;
    for (int i = 0; i < kCACHESARRMAXCOUNT ; i ++) {
        NSInteger score = [[[ZEExpertAssessmentCache instance]getScoreWithIndex:i] integerValue];
        allScore += score;
    }
    
    UIView * grayView = [[UIView alloc]initWithFrame:CGRectMake(0,90, SCREEN_WIDTH, 60.0f)];
    [headerView addSubview:grayView];
    grayView.backgroundColor = MAIN_LINE_COLOR;
    
    for (int i = 0 ; i < 5; i ++) {
        UILabel * listLabel = nil;
        if (i < 4) {
            listLabel      = [[UILabel alloc]initWithFrame:CGRectMake(10, 0 + 30 * i, SCREEN_WIDTH - 20, 30)];
            listLabel.font = [UIFont systemFontOfSize:14];
            [headerView addSubview:listLabel];
        }
        
        CALayer * lineLayer       = [CALayer layer];
        lineLayer.frame           = CGRectMake(0, 29.5 + 30 * i, SCREEN_WIDTH, 0.5f);
        [headerView.layer addSublayer:lineLayer];
        lineLayer.backgroundColor = [[UIColor lightGrayColor] CGColor];
        
        switch (i) {
            case 0:
                listLabel.text = [NSString stringWithFormat:@"技能名称：%@",_expertAssM.SKILL_NAME];
                break;
            case 1:
                listLabel.text = [NSString stringWithFormat:@"班组：%@",_expertAssM.ORGNAME];
                if (_enterType == EXPERTASSESSMENT_TYPE_DIANZAN) {
                    listLabel.text = [NSString stringWithFormat:@"职位：%@",_expertAssM.ORGNAME];
                }
                break;
            case 2:
                listLabel.text = [NSString stringWithFormat:@"姓名：%@",_expertAssM.PSNNAME];
                break;
            case 3:{
                listLabel.text = @"技能掌握专家评分";
                    _allScoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 110, 0 + 30 * i, 100, 30)];
                    _allScoreLabel.font = [UIFont systemFontOfSize:14];
                    _allScoreLabel.textAlignment = NSTextAlignmentRight;
                    [headerView addSubview:_allScoreLabel];
                if (allScore > 0) {
                    _allScoreLabel.text = [NSString stringWithFormat:@"得分：%d",allScore];
                }
            }
                break;
            default:
                break;
        }
    }
    
    for (int i = 0; i < 3; i ++) {
        UILabel * listLabel     = [[UILabel alloc]initWithFrame:CGRectZero];
        listLabel.font          = [UIFont systemFontOfSize:13];
        [headerView addSubview:listLabel];
        listLabel.textAlignment = NSTextAlignmentCenter;
        
        switch (i) {
            case 0:
            {
                listLabel.textAlignment = NSTextAlignmentLeft;
                listLabel.text          = @"分类";
                listLabel.frame         = CGRectMake(10, 120.0f, SCREEN_WIDTH / 4 - 10, 30.0f);
            }
                break;
            case 1:
            {
                listLabel.text = @"项目名称（分值）";
                listLabel.frame = CGRectMake(SCREEN_WIDTH / 4, 120.0f, SCREEN_WIDTH / 2, 30.0f);
            }
                break;
            case 2:
            {
                listLabel.text = @"专家评分";
                listLabel.frame = CGRectMake(SCREEN_WIDTH * 0.75, 120.0f, SCREEN_WIDTH / 4 - 10, 30.0f);
            }
                break;
            default:
                break;
        }

    }
    return headerView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"CELL";
//    cellID = [NSString stringWithFormat:@"%d",indexPath.row];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    for (UIView * view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self initCellView:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - initCellView
-(void)initCellView:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    ZEExpertAssModel * expertM = [ZEExpertAssModel getDetailModelWithDic:_expertAssM.detailarray[indexPath.row]];
    
    CALayer * lineLayer = [CALayer layer];
    [cell.contentView.layer addSublayer:lineLayer];
    lineLayer.backgroundColor = [[UIColor lightGrayColor] CGColor];
    lineLayer.frame = CGRectMake(0, 29.5, SCREEN_WIDTH ,0.5f);
    
    for (int i = 0; i < 3; i ++) {
        UILabel * listLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        listLabel.font = [UIFont systemFontOfSize:11];
        [cell.contentView addSubview:listLabel];
        listLabel.textAlignment = NSTextAlignmentCenter;

        CALayer * lineLayer = [CALayer layer];
        [cell.contentView.layer addSublayer:lineLayer];
        lineLayer.backgroundColor = [[UIColor lightGrayColor] CGColor];

        switch (i) {
            case 0:
            {
                listLabel.textAlignment = NSTextAlignmentLeft;
                if (indexPath.row == 0) {
                    listLabel.text = expertM.detail_ITEMS;
                    _currentStr =expertM.detail_ITEMS;
                }
                if (![expertM.detail_ITEMS isEqualToString:_currentStr]) {
                    listLabel.text = expertM.detail_ITEMS;
                    _currentStr =expertM.detail_ITEMS;
                }
                
                listLabel.frame = CGRectMake(10, 0, SCREEN_WIDTH / 4 - 10, 30.0f);
                lineLayer.frame = CGRectMake(SCREEN_WIDTH / 4, 0, 0.5, 30);
            }
                break;
            case 1:
            {
                listLabel.text = [NSString stringWithFormat:@"%@（%@）",expertM.detail_PROJECTNAME,expertM.detail_MARKS];
                listLabel.frame = CGRectMake(SCREEN_WIDTH / 4, 0, SCREEN_WIDTH / 2, 30.0f);
                lineLayer.frame = CGRectMake(SCREEN_WIDTH * 0.75, 0, 0.5, 30);
            }
                break;
            case 2:
            {
                if (_enterType == EXPERTASSESSMENT_TYPE_DONE) {
                    if([expertM.detail_EXPERTSCORE floatValue] == 0){
                        listLabel.text = @"";
                    }else{
                        listLabel.text = [NSString stringWithFormat:@"%@", expertM.detail_EXPERTSCORE];
                    }
                    listLabel.frame = CGRectMake(SCREEN_WIDTH * 0.75, 0, SCREEN_WIDTH / 4 - 10, 30.0f);
                }else{
                    UITextField *contentField                    = [[UITextField alloc]init];
                    contentField.keyboardType       = UIKeyboardTypePhonePad;
                    contentField.delegate           = self;
                    contentField.tag                = indexPath.row;
                    contentField.font               = [UIFont systemFontOfSize:13];
                    contentField.textColor          = [UIColor blackColor];
                    [cell.contentView addSubview:contentField];
                    contentField.clipsToBounds      = YES;
                    contentField.layer.cornerRadius = 5;
                    contentField.textAlignment = NSTextAlignmentCenter;
                    contentField.frame = CGRectMake(SCREEN_WIDTH * 0.75, 0, SCREEN_WIDTH / 4 - 10, 30.0f);
                    if ([[[ZEExpertAssessmentCache instance]getScoreWithIndex:indexPath.row] integerValue] != 0) {
                        contentField.text = [[ZEExpertAssessmentCache instance]getScoreWithIndex:indexPath.row];
                    }
                    
                    [contentField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
                }
            }
                break;
            default:
                break;
        }
    }
}


- (BOOL)textFieldDidChange:(UITextField *)textField
{
    ZEExpertAssModel * expertM = [ZEExpertAssModel getDetailModelWithDic:_expertAssM.detailarray[textField.tag]];

    if ([textField.text floatValue] > [expertM.detail_MARKS floatValue]) {
        
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"输入分数不能大于分值" message:nil delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alertView show];
        
        textField.text = [textField.text substringToIndex:textField.text.length - 1];
    }
    
    return YES;
}

#pragma mark - UITextFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.29 animations:^{
        _contentTableView.frame = CGRectMake(0, -216, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT);
    }];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [[ZEExpertAssessmentCache instance] setExpertAssessmentScore:textField.text index:textField.tag];
    NSInteger allScore = 0;
    for (int i = 0; i < kCACHESARRMAXCOUNT ; i ++) {
        NSInteger score = [[[ZEExpertAssessmentCache instance]getScoreWithIndex:i] integerValue];
        allScore += score;
    }
    _allScoreLabel.text = [NSString stringWithFormat:@"得分：%d",allScore];

    [UIView animateWithDuration:0.29 animations:^{
        _contentTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT);
    }];
}
#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self endEditing:YES];
    ZEExpertAssModel * expertM = [ZEExpertAssModel getDetailModelWithDic:_expertAssM.detailarray[indexPath.row]];
    if ([self.delegate respondsToSelector:@selector(enterDetailProject:index:)]) {
        [self.delegate enterDetailProject:expertM index:indexPath.row];
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

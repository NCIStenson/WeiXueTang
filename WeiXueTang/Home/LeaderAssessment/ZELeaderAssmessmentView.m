//
//  ZELeaderAssmessmentView.m
//  WeiXueTang
//
//  Created by Stenson on 16/5/19.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#define kMessageContentViewMarginLeft 0.0f
#define kMessageContentViewMarginTop  0.0f
#define kMessageContentViewWidth      SCREEN_WIDTH
#define kMessageContentViewHeight     30

#define kMemberTabMarginLeft    5.0f
#define kMemberTabMarginTop     kMessageContentViewHeight
#define kMemberTabWidth         SCREEN_WIDTH - kMemberTabMarginLeft * 2
#define kMemberTabHeight        220.0f

#define kLeaderAssContentViewMarginLeft 0.0f
#define kLeaderAssContentViewMarginTop  kMessageContentViewHeight
#define kLeaderAssContentViewWidth      SCREEN_WIDTH
#define kLeaderAssContentViewHeight     SCREEN_HEIGHT - NAV_HEIGHT - kMessageContentViewHeight

#import "ZELeaderAssmessmentView.h"
#import "MASonry.h"

@interface ZELeaderAssmessmentView ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _leaderAssContentView;
    UITableView * _memberContentTableView;
    
    UILabel * nameLabel;
    UIImageView * tipsImage;
}

@property(nonatomic,strong) NSArray * leaderAssArr;

@property(nonatomic,strong) NSMutableArray * conditionArr;
@property(nonatomic,strong) NSArray * memberAssArr;

@end

@implementation ZELeaderAssmessmentView


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
    UIView * messageView = [[UIView alloc]initWithFrame:CGRectZero];
    messageView.backgroundColor = MAIN_LINE_COLOR;
    [self addSubview:messageView];
    [messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMessageContentViewMarginLeft);
        make.top.mas_equalTo(kMessageContentViewMarginTop);
        make.size.mas_equalTo(CGSizeMake(kMessageContentViewWidth, kMessageContentViewHeight));
    }];
    
    tipsImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 25, 7.5, 15, 15)];
    tipsImage.image = [UIImage imageNamed:@"icon_up" color:MAIN_NAV_COLOR];
    tipsImage.contentMode = UIViewContentModeScaleAspectFit;
    [messageView addSubview:tipsImage];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getAllTeamMember)];
    tap.numberOfTapsRequired = 1;
    [messageView addGestureRecognizer:tap];
    
    
    nameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    nameLabel.font = [UIFont systemFontOfSize:13];
    nameLabel.text = [NSString stringWithFormat:@"所有人员"];
    nameLabel.adjustsFontSizeToFitWidth =  YES;
    [messageView addSubview:nameLabel];
    float labelSize = [ZEUtil widthForString:nameLabel.text font:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(100, 30)];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10.0f);
        make.top.mas_equalTo(0.0f);
        make.size.mas_equalTo(CGSizeMake(labelSize, 30.0f));
    }];
    
    _leaderAssContentView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _leaderAssContentView.dataSource = self;
    _leaderAssContentView.delegate = self;
    _leaderAssContentView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _leaderAssContentView.backgroundColor = MAIN_LINE_COLOR;
    [self addSubview:_leaderAssContentView];
    
    [_leaderAssContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kLeaderAssContentViewMarginLeft);
        make.top.mas_equalTo(kLeaderAssContentViewMarginTop);
        make.size.mas_equalTo(CGSizeMake(kLeaderAssContentViewWidth, kLeaderAssContentViewHeight));
    }];
    
    _memberContentTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _memberContentTableView.dataSource = self;
    _memberContentTableView.delegate = self;
    _memberContentTableView.hidden = YES;
    _memberContentTableView.backgroundColor = MAIN_LINE_COLOR;
    _memberContentTableView.alpha = 0;
    _memberContentTableView.frame = CGRectMake(kMemberTabMarginLeft, kLeaderAssContentViewMarginTop, kMemberTabWidth, 0);
    [self addSubview:_memberContentTableView];
}
#pragma mark - Public Method

-(void)reloadData:(NSArray *)arr
{
    self.leaderAssArr = arr;
    nameLabel.text = @"所有人员";
    self.conditionArr = [NSMutableArray arrayWithArray:arr];
    [_leaderAssContentView reloadData];
}

-(void)showAllTeamMember:(NSArray *)memberArr
{
    self.memberAssArr = memberArr;
    [_memberContentTableView reloadData];
    _memberContentTableView.hidden = NO;
    [UIView animateWithDuration:0.29 animations:^{
        _memberContentTableView.alpha = 1;
        _memberContentTableView.frame = CGRectMake(kMemberTabMarginLeft, kMemberTabMarginTop, kMemberTabWidth, kMemberTabHeight);
        tipsImage.image = [UIImage imageNamed:@"icon_down" color:MAIN_NAV_COLOR];
    }];
    
}

-(void)hiddenTheTeamMember
{
    [UIView animateWithDuration:0.29 animations:^{
        _memberContentTableView.alpha = 0;
        _memberContentTableView.frame = CGRectMake(kMemberTabMarginLeft, kMemberTabMarginTop, kMemberTabWidth, 0);
        tipsImage.image = [UIImage imageNamed:@"icon_up" color:MAIN_NAV_COLOR];
    } completion:^(BOOL finished) {
        _memberContentTableView.hidden = YES;
    }];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:_memberContentTableView]) {
        return self.memberAssArr.count;
    }
    return self.conditionArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_memberContentTableView]) {
        return 40;
    }
    return 55;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    if ([tableView isEqual:_memberContentTableView]) {
        cell.contentView.backgroundColor = MAIN_LINE_COLOR;
        cell.textLabel.text = [self.memberAssArr[indexPath.row] objectForKey:@"userName"];
        return cell;
    }
    
    
    UIView * backgroundView = [[UIView alloc]initWithFrame:CGRectMake(5, 0, SCREEN_WIDTH - 10, 50)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:backgroundView];

    cell.contentView.backgroundColor = MAIN_LINE_COLOR;
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    
    ZELeaderAssessmentModel * leaderAssM = [ZELeaderAssessmentModel getDetailFromDic:self.conditionArr[indexPath.row]];
    
    UILabel * skillNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, SCREEN_WIDTH - 20.0f, 25.0f)];
    skillNameLabel.text = leaderAssM.skill_name;
    skillNameLabel.font = [UIFont systemFontOfSize:14];
    [cell.contentView addSubview:skillNameLabel];
    
    UILabel * staffNameLab = [[UILabel alloc]initWithFrame:CGRectZero];
    staffNameLab.text = leaderAssM.user_name;
    staffNameLab.font = [UIFont systemFontOfSize:12];
    [cell.contentView addSubview:staffNameLab];
    [staffNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10.0);
        make.right.mas_equalTo(-10.0);
        make.top.mas_equalTo(25.0f);
        make.bottom.mas_equalTo(0.0f);
    }];

    UILabel * dateLab = [[UILabel alloc]initWithFrame:CGRectZero];
    dateLab.text = leaderAssM.createdate;
    dateLab.textColor = [UIColor grayColor];
    dateLab.font = [UIFont systemFontOfSize:12];
    dateLab.textAlignment = NSTextAlignmentRight;
    [cell.contentView addSubview:dateLab];
    [dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10.0);
        make.right.mas_equalTo(-10.0);
        make.top.mas_equalTo(25.0f);
        make.bottom.mas_equalTo(0.0f);
    }];
    
    return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self hiddenTheTeamMember];

    if([tableView isEqual:_memberContentTableView]){
        nameLabel.text = [self.memberAssArr[indexPath.row] objectForKey:@"userName"];
        self.conditionArr = [NSMutableArray array];
        for (NSDictionary * dic in self.leaderAssArr) {
            ZELeaderAssessmentModel * leaderAssM = [ZELeaderAssessmentModel getDetailFromDic:dic];
            if ([nameLabel.text isEqualToString:leaderAssM.user_name]) {
                [self.conditionArr addObject:dic];
            }
        }
        [_leaderAssContentView reloadData];
    }else{
        ZELeaderAssessmentModel * leaderAssM = [ZELeaderAssessmentModel getDetailFromDic:self.conditionArr[indexPath.row]];
        if ([self.delegate respondsToSelector:@selector(didSelectLeaderAssess:)]) {
            [self.delegate didSelectLeaderAssess:leaderAssM];
        }
    }
}

-(void)getAllTeamMember
{
    if (_memberContentTableView.hidden) {
        if ([self.delegate respondsToSelector:@selector(showAllTeamMember)]) {
            [self.delegate showAllTeamMember];
        }
    }else{
        [self hiddenTheTeamMember];
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

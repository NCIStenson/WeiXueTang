//
//  ZEDianZanView.m
//  WeiXueTang
//
//  Created by Stenson on 16/3/17.
//  Copyright © 2016年  Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#define kTipsLabelHeight 30.0f

#define kStaffInformationMarginLeft 0.0f
#define kStaffInformationMarginTop  kTipsLabelHeight
#define kStaffInformationWidth      SCREEN_WIDTH
#define kStaffInformationHeight     (IPHONE6P ? 120.0f : (IPHONE6 ? 110.0f : 90.0f))

#import "ZEDianZanView.h"
#import "Masonry.h"
#import "ZEDianZanModel.h"
#import "ZEToolKitModel.h"

@interface ZEDianZanView ()
{
    UITableView * _contentTable;
}
@property (nonatomic,retain) NSArray * skillListArr;
@property (nonatomic,retain) NSMutableArray * staffListArr;

@end

@implementation ZEDianZanView

-(id)initWithFrame:(CGRect)rect
{
    self = [super initWithFrame:rect];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView
{
    [self initTips];
//    [self initStaffInformation];
    [self initContent];
}

#pragma mark - Public Method

-(void)reloadData:(NSDictionary *)dic
{
    ZEDianZanModel * dianZanM = [ZEDianZanModel getDetailWithDic:dic];
    self.skillListArr =dianZanM.teamSkill;
    self.staffListArr = [NSMutableArray arrayWithArray:dianZanM.perSkill];

    [_contentTable reloadData];
}

#pragma mark - 提示信息

-(void)initTips
{
    for (int i = 0; i < 4; i++) {
        UILabel * tipsLable = [[UILabel alloc]initWithFrame:CGRectMake(10 + 70 * i, NAV_HEIGHT, 50.0f, kTipsLabelHeight)];
        tipsLable.backgroundColor= [UIColor clearColor];
        [tipsLable setTextColor:MAIN_COLOR];
        [tipsLable setFont:[UIFont systemFontOfSize:12]];
        tipsLable.text = [NSString stringWithFormat:@"%@:",[ZEUtil getDianZanTypeChineseText:i]];
        [self addSubview:tipsLable];
        
        UIImageView * tipsImage = [[UIImageView alloc]initWithFrame:CGRectMake(55.0f + 70.0f * i,  NAV_HEIGHT + 5.0f, 20.0f, 20.f)];
        tipsImage.backgroundColor = [UIColor clearColor];
        [tipsImage setImage:[UIImage imageNamed:[ZEUtil getDianZanTypeImageName:i]]];
        [self addSubview:tipsImage];
    }
    CALayer * lineLayer = [CALayer layer];
    lineLayer.frame = CGRectMake(0, NAV_HEIGHT + kTipsLabelHeight - 0.5f, SCREEN_WIDTH, 0.5f);
    lineLayer.backgroundColor = MAIN_COLOR.CGColor;
    [self.layer addSublayer:lineLayer];
    
}
#pragma mark - 员工信息
-(nullable UIView *)initStaffInformation
{
    UIView * staffInf             = [[UIView alloc]initWithFrame:CGRectZero];
    staffInf.backgroundColor      = [UIColor whiteColor];

    CALayer * lineLayer           = [CALayer layer];
    lineLayer.frame               = CGRectMake(0, kStaffInformationHeight - 0.5f, SCREEN_WIDTH, 0.5f);
    lineLayer.backgroundColor     = MAIN_COLOR.CGColor;
    [staffInf.layer addSublayer:lineLayer];

    UIButton * previousBtn        = [UIButton buttonWithType:UIButtonTypeCustom];
    previousBtn.frame             = CGRectMake(0, 0, 50.0f, kStaffInformationHeight);
    [previousBtn setBackgroundColor:[UIColor clearColor]];
    [previousBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    [previousBtn setImage:[UIImage imageNamed:@"icon_back" tintColor:MAIN_COLOR] forState:UIControlStateNormal];
    [staffInf addSubview:previousBtn];
    [previousBtn addTarget:self action:@selector(previousBtnClick) forControlEvents:UIControlEventTouchUpInside];

    UIButton * nextBtn            = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame                 = CGRectMake(SCREEN_WIDTH - 30.0f, 0.0f, 30.0f, kStaffInformationHeight);
    [nextBtn setBackgroundColor:[UIColor clearColor]];
    [nextBtn setImage:[UIImage imageNamed:@"icon_back" tintColor:MAIN_COLOR] forState:UIControlStateNormal];
    [staffInf addSubview:nextBtn];
    [nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -20)];
    CGAffineTransform at          = CGAffineTransformMakeRotation(M_PI);
    nextBtn.transform             = CGAffineTransformRotate(at, 0.0f);

    float staffImageBackViewWidth = (SCREEN_WIDTH - 80) / 5;
    
    for (int i = 0 ; i < self.staffListArr.count; i ++ ) {
        
        ZEDianZanModel * dianZanM          = [ZEDianZanModel getDetailWithDic:self.staffListArr[i]];

        UIView * staffImageBackView        = [[UIView alloc]initWithFrame:CGRectMake(50.0f +  staffImageBackViewWidth * i, 0.0f, staffImageBackViewWidth, kStaffInformationHeight)];
        staffImageBackView.backgroundColor = [UIColor clearColor];
        [staffInf addSubview:staffImageBackView];

        CALayer * lineLayer                = [CALayer layer];
        lineLayer.frame                    = CGRectMake(50 + staffImageBackViewWidth * i, 0.0, 0.5, kStaffInformationHeight);
        lineLayer.backgroundColor          = MAIN_COLOR.CGColor;
        [staffInf.layer addSublayer:lineLayer];
        if (i == self.staffListArr.count - 1) {
        CALayer * lastLineLayer            = [CALayer layer];
        lastLineLayer.frame                = CGRectMake(50 + staffImageBackViewWidth * self.staffListArr.count , 0.0, 0.5, kStaffInformationHeight);
        lastLineLayer.backgroundColor      = MAIN_COLOR.CGColor;
            [staffInf.layer addSublayer:lastLineLayer];
        }

        UIImageView * staffImage           = [[UIImageView alloc]initWithFrame:CGRectMake(2.0f, 0.0f,  (staffImageBackViewWidth - 4.0f),  (staffImageBackViewWidth - 4.0f) / 0.7)];
        staffImage.backgroundColor         = [UIColor clearColor];
        [staffImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PRE_PHOTO,dianZanM.photoname]] placeholderImage:[UIImage imageNamed:@"timeline_image_loading"]];
        [staffImageBackView addSubview:staffImage];

        UILabel * staffLabel               = [[UILabel alloc]initWithFrame:CGRectMake(0, staffImage.frame.size.height, staffImage.frame.size.width, kStaffInformationHeight - staffImage.frame.size.height)];
        staffLabel.backgroundColor         = [UIColor clearColor];
        [staffLabel setTextColor:MAIN_COLOR];
        [staffLabel setFont:[UIFont systemFontOfSize:(IPHONE6_MORE ? 10.0f : 8.0f)]];
        staffLabel.numberOfLines           = 0;
        staffLabel.textAlignment           = NSTextAlignmentCenter;
        staffLabel.text                    = [NSString stringWithFormat:@"%@",dianZanM.psnname];
        
        [staffImageBackView addSubview:staffLabel];
    }
    
    return (ZEDianZanView *)staffInf;
}

-(void)previousBtnClick
{
    if ([self.delegate respondsToSelector:@selector(previousPage)]) {
        [self.delegate previousPage];
    }
}
-(void)nextBtnClick
{
    if ([self.delegate respondsToSelector:@selector(nextPage)]) {
        [self.delegate nextPage];
    }
}


#pragma mark - 点赞内容

-(void)initContent
{
    _contentTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _contentTable.backgroundColor = [UIColor clearColor];
    _contentTable.bounces = NO;
    _contentTable.dataSource = self;
    _contentTable.delegate = self;
    _contentTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _contentTable.tableHeaderView = [self initStaffInformation];
    [self addSubview:_contentTable];
    [_contentTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0.0f);
        make.top.mas_equalTo(kTipsLabelHeight + NAV_HEIGHT);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - kTipsLabelHeight - NAV_HEIGHT));
    }];
}

#pragma mark - UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kStaffInformationHeight;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self initStaffInformation];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.skillListArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    ZEDianZanModel * dianZanM = [ZEDianZanModel getDetailWithDic:self.skillListArr[indexPath.row]];
    return [ZEUtil heightForString:dianZanM.skill_name font:[UIFont systemFontOfSize:(IPHONE6_MORE ? 10.0f : 8.0f)] andWidth:44.0f] + 20.0f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    for (UIView * view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self initCellView:cell AtIndexPath:indexPath];
    return cell;
}

-(void)initCellView:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    ZEDianZanModel * dianZanM = [ZEDianZanModel getDetailWithDic:self.skillListArr[indexPath.row]];
    float cellH = [ZEUtil heightForString:dianZanM.skill_name font:[UIFont systemFontOfSize:(IPHONE6_MORE ? 10.0f : 8.0f)] andWidth:44.0f] + 20.0f;

    UIButton * skillNameBtn               = [UIButton buttonWithType:UIButtonTypeSystem];
    skillNameBtn.frame                    = CGRectMake(3.0, 0.0f, 44.0f,cellH);
    skillNameBtn.backgroundColor          = [UIColor clearColor];
    [skillNameBtn setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    [skillNameBtn setTitleColor:MAIN_COLOR forState:UIControlStateHighlighted];
    skillNameBtn.titleLabel.font =[UIFont systemFontOfSize:(IPHONE6_MORE ? 10.0f : 8.0f)];
    skillNameBtn.titleLabel.numberOfLines = 0;
    skillNameBtn.tag                      = indexPath.row;
    skillNameBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [skillNameBtn setTitle:dianZanM.skill_name forState:UIControlStateNormal];
    [cell.contentView addSubview:skillNameBtn];
    [skillNameBtn addTarget:self action:@selector(goToolKitVC:) forControlEvents:UIControlEventTouchUpInside];
    

    float staffImageBackViewWidth = (SCREEN_WIDTH - 80) / 5;
    /**
     * 根据员工数量创建技能列表
     */
    for (int i = 0 ; i < self.staffListArr.count; i ++ ) {
        
        UIView * lineLayer            = [[UIView alloc]init];
        lineLayer.frame               = CGRectMake(50 + staffImageBackViewWidth * i, 0.0, 0.5, cellH);
        lineLayer.backgroundColor     = MAIN_COLOR;
        [cell.contentView addSubview:lineLayer];

        if (i == self.staffListArr.count - 1) {
        UIView * lastLineLayer        = [[UIView alloc]init];
        lastLineLayer.frame           = CGRectMake(50 + staffImageBackViewWidth * self.staffListArr.count, 0.0, 0.5, cellH);
        lastLineLayer.backgroundColor = MAIN_COLOR;
            [cell.contentView addSubview:lastLineLayer];
        }
        
        ZEDianZanModel * model = [ZEDianZanModel getDetailWithDic:self.staffListArr[i]];
        for (int j = 0; j < model.list.count; j ++) {
            ZEDianZanModel * staffSkillModel = [ZEDianZanModel getDetailWithDic:model.list[j]];
            if ([staffSkillModel.skill_name isEqualToString:dianZanM.skill_name]) {
                UIButton * staffImage      = [UIButton buttonWithType:UIButtonTypeCustom];
                staffImage.frame = CGRectMake(50.0f + staffImageBackViewWidth * i, 0.0f,staffImageBackViewWidth,cellH);
                staffImage.backgroundColor    = [UIColor clearColor];
                [cell.contentView addSubview:staffImage];
                staffImage.tag = i * 100 + indexPath.row;
                [staffImage addTarget:self action:@selector(staffImageClick:) forControlEvents:UIControlEventTouchUpInside];
                staffImage.contentMode        = UIViewContentModeCenter;
                
                switch ([staffSkillModel.skill_state integerValue]) {
                    case 0:
                        [staffImage setImage:[UIImage imageNamed:[ZEUtil getDianZanTypeImageName:DIANZAN_TYPE_NO]] forState:UIControlStateNormal];
                        break;
                    case 1:
                        [staffImage setImage:[UIImage imageNamed:[ZEUtil getDianZanTypeImageName:DIANZAN_TYPE_DONE]] forState:UIControlStateNormal];
                        break;
                    case 60:
                        [staffImage setImage:[UIImage imageNamed:[ZEUtil getDianZanTypeImageName:DIANZAN_TYPE_DONE]] forState:UIControlStateNormal];
                        break;
                    default:
                        [staffImage setImage:[UIImage imageNamed:[ZEUtil getDianZanTypeImageName:DIANZAN_TYPE_DOING]] forState:UIControlStateNormal];
                        break;
                }
                break;
            }
        }
    }

    UIView * cellLineLayer        = [UIView new];
    cellLineLayer.frame           = CGRectMake(0.0f, cellH - 0.5, SCREEN_WIDTH, 0.5);
    cellLineLayer.backgroundColor = MAIN_COLOR;
    [cell.contentView addSubview:cellLineLayer];

}


-(void)goToolKitVC:(UIButton *)button
{
    NSLog(@"去技能库  >>>  %d",button.tag);
    ZEDianZanModel * model = [ZEDianZanModel getDetailWithDic:self.skillListArr[button.tag]];
    if ([self.delegate respondsToSelector:@selector(goSkillDetail:)]) {
        [self.delegate goSkillDetail:model.skill_seqkey];
    }
}


-(void)staffImageClick:(UIButton *)button
{
    ZEDianZanModel * model = [ZEDianZanModel getDetailWithDic:self.staffListArr[button.tag / 100]];
    ZEDianZanModel * staffSkillModel = [ZEDianZanModel getDetailWithDic:model.list[button.tag % 100]];
    
    NSArray * arr = [model.psnname componentsSeparatedByString:@"\n"];
    NSLog(@">>>   %@",arr);

    
    
    if([self.delegate respondsToSelector:@selector(goSkillExpertAss:withSkillName:withOrgName:withStaffName:)]){
        [self.delegate goSkillExpertAss:staffSkillModel.instance_key
                          withSkillName:staffSkillModel.skill_name
                            withOrgName:[arr lastObject]
                          withStaffName:model.psnname];
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

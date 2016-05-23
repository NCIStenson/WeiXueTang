//
//  ZEUserCenterView.m
//  NewCentury
//
//  Created by Stenson on 16/4/28.
//  Copyright © 2016年 Zenith Electronic. All rights reserved.
//

#define kUserImageViewMarginLeft    0.0f
#define kUserImageViewMarginTop     0.0f
#define kUserImageViewMarginWidth   SCREEN_WIDTH
#define kUserImageViewMarginHeight  (IPHONE4S_LESS ? 160.0f: 180.0f)

#import "UIImageView+WebCache.h"
#import "ZEUserCenterView.h"
#import "MASonry.h"

@interface ZEUserCenterView()
{
    UIImageView * userImageView;
}

@end

@implementation ZEUserCenterView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUserCenterView];
    }
    return self;
}

-(void)initUserCenterView
{
    userImageView = [[UIImageView alloc]init];
    [self addSubview:userImageView];
    userImageView.contentMode = UIViewContentModeScaleAspectFit;
    [userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leftMargin.mas_equalTo (kUserImageViewMarginLeft);
        make.topMargin.mas_equalTo(kUserImageViewMarginTop);
        make.size.mas_equalTo(CGSizeMake(kUserImageViewMarginWidth, kUserImageViewMarginHeight));
    }];
}

-(void)reloadView:(NSDictionary *)userInfoDic
{
    [userImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://117.149.2.229:8090/nbsj/file/photo/%@.jpg",[ZEUtil getUsername]]] placeholderImage:[UIImage imageNamed:@"timeline_image_loading"]];
    
    for (int i = 0; i < 5; i ++) {
        UILabel * messageLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 200)/2, kUserImageViewMarginHeight + 40 * i, 200, 40)];
        messageLabel.font = [UIFont systemFontOfSize:14];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:messageLabel];
        
        CALayer * lineLayer = [CALayer layer];
        lineLayer.frame = CGRectMake(messageLabel.frame.origin.x - 25, messageLabel.frame.origin.y + 39.5, messageLabel.frame.size.width + 50, 0.5);
        lineLayer.backgroundColor = [[UIColor colorWithWhite:0 alpha:0.5] CGColor];
        [self.layer addSublayer:lineLayer];
        
        switch (i) {
            case 0:
                messageLabel.text = [NSString stringWithFormat:@"姓名：%@",[userInfoDic objectForKey:@"name"]];
                break;
            case 1:
                messageLabel.text = [NSString stringWithFormat:@"工号：%@",[ZEUtil getUsername]];
                break;
            case 2:
                messageLabel.text = [NSString stringWithFormat:@"职位：%@",[userInfoDic objectForKey:@"posname"]];
                break;
            case 3:
                messageLabel.text = [NSString stringWithFormat:@"部门：%@",[ZESetLocalData getUnitName]];
                break;
            case 4:
                messageLabel.text = [NSString stringWithFormat:@"班组：%@",[ZESetLocalData getUserOrgCodeName]];
                break;
                
            default:
                break;
        }
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

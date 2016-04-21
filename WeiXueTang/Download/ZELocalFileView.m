//
//  ZELocalFileView.m
//  WeiXueTang
//
//  Created by Stenson on 16/4/7.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import "ZELocalFileView.h"

@implementation ZELocalFileView

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
    NSDictionary * dic = [ZEUtil getDownloadFileMessage];
    
    NSArray * downloadImageArr = [dic objectForKey:@"image"];
    int localDownLoadImageCount = 0;

    for (int i = 0; i < downloadImageArr.count; i ++) {
        NSDictionary * imageMessageDic = downloadImageArr [i];
        localDownLoadImageCount += [[imageMessageDic objectForKey:kImageCacheArr] count];
    }
    
    for (int i = 0 ; i < 2  ; i ++) {
        for ( int j = 0; j < 2;  j ++) {
            UIButton * localDiffTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            localDiffTypeBtn.frame = CGRectMake(0 + SCREEN_WIDTH / 2 * j, 0 + 150 * i , SCREEN_WIDTH / 2, 150);
            [localDiffTypeBtn setTitleEdgeInsets:UIEdgeInsetsMake(50, 0, 0, 0)];
            localDiffTypeBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//设置button的内容横向居中。。设置content是title和image一起变化
            localDiffTypeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//设置button的内容横向居中。。设置content是title和image一起变化

            localDiffTypeBtn.titleLabel.numberOfLines = 0;
            [self addSubview:localDiffTypeBtn];
            
            UIImageView * iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH / 2, 40)];
            iconImage.image = [UIImage imageNamed:@"good_not"];
            iconImage.userInteractionEnabled = NO;
            iconImage.contentMode = UIViewContentModeScaleAspectFit;
            [localDiffTypeBtn addSubview:iconImage];
            
            if (i == 0) {
                localDiffTypeBtn.tag = j + 100;
                [localDiffTypeBtn addTarget:self action:@selector(goSubView:) forControlEvents:UIControlEventTouchUpInside];
                if (j == 0) {
                    [localDiffTypeBtn setAttributedTitle:[self getAttrStrWithStr:[NSString stringWithFormat:@"视频\n共%d项",[[dic objectForKey:@"video"] count]]] forState:UIControlStateNormal];
                }else{
                    [localDiffTypeBtn setAttributedTitle:[self getAttrStrWithStr:[NSString stringWithFormat:@"图片\n共%d项",localDownLoadImageCount]] forState:UIControlStateNormal];
                }
            }else{
                if (j == 0) {
                    [localDiffTypeBtn setAttributedTitle:[self getAttrStrWithStr:@"文档\n共0项"] forState:UIControlStateNormal];
                }else{
                    [localDiffTypeBtn setAttributedTitle:[self getAttrStrWithStr:@"其他\n共0项"] forState:UIControlStateNormal];
                }
            }
            
        }
    }
    
    for (int i = 0; i < 2; i ++) {
        CALayer * vLineLayer = [CALayer layer];
        vLineLayer.frame = CGRectMake(0, 150 * (i + 1), SCREEN_WIDTH, 0.5f);
        vLineLayer.backgroundColor = [MAIN_LINE_COLOR CGColor];
        [self.layer addSublayer:vLineLayer];
    }
    CALayer * hLineLayer = [CALayer layer];
    hLineLayer.frame = CGRectMake(SCREEN_WIDTH / 2  , 0, 0.5f, 300.0f);
    hLineLayer.backgroundColor = [MAIN_LINE_COLOR CGColor];
    [self.layer addSublayer:hLineLayer];
}

#pragma mark - Publick Method

-(void)reloadView{
    
    NSDictionary * dic = [ZEUtil getDownloadFileMessage];
    NSArray * downloadImageArr = [dic objectForKey:@"image"];
    int localDownLoadImageCount = 0;
    
    for (int i = 0; i < downloadImageArr.count; i ++) {
        NSDictionary * imageMessageDic = downloadImageArr [i];
        localDownLoadImageCount += [[imageMessageDic objectForKey:kImageCacheArr] count];
    }
    
    UIButton * localVideoBtn = (UIButton *)[self viewWithTag:LOCALFILE_TYPE_VIDEO];
    NSAttributedString * videoString = [self getAttrStrWithStr:[NSString stringWithFormat:@"视频\n共%d项",[[dic objectForKey:@"video"] count]]];
    [localVideoBtn setAttributedTitle:videoString forState:UIControlStateNormal];
    
    UIButton * localImageBtn = (UIButton *)[self viewWithTag:LOCALFILE_TYPE_IMAGE];
    [localImageBtn setAttributedTitle:[self getAttrStrWithStr:[NSString stringWithFormat:@"图片\n共%d项",localDownLoadImageCount]] forState:UIControlStateNormal];
}

-(NSMutableAttributedString *)getAttrStrWithStr:(NSString *)str
{
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc]initWithString:str];
    
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, str.length - 1)];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(2,str.length - 2)];
    
    return attrStr;
}

-(void)goSubView:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(goVideoOrImageView:)]) {
        [self.delegate goVideoOrImageView:button.tag];
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

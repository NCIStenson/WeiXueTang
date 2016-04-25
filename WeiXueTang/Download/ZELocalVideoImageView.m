//
//  ZELocalVideoImageView.m
//  WeiXueTang
//
//  Created by Stenson on 16/4/18.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#define kImageCellHeight 120
#define kVideoCellHeight 44

#import "ZELocalVideoImageView.h"
#import "MASonry.h"
@interface ZELocalVideoImageView()
{
    UITableView * _contentTableView;
    LOCALFILE_TYPE _fileType;
    NSDictionary * _downloadMessageDic;
}

@end

@implementation ZELocalVideoImageView

-(id)initWithFrame:(CGRect)frame withFileType:(LOCALFILE_TYPE)fileType
{
    self = [super initWithFrame:frame];
    if (self) {
        _fileType = fileType;
        _downloadMessageDic = [ZEUtil getDownloadFileMessage];
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
    _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_contentTableView];
    [_contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0.0f);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT));
    }];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_fileType == LOCALFILE_TYPE_VIDEO) {
        return [[_downloadMessageDic objectForKey:@"video"] count];
    }
    
    NSArray * downloadImageArr = [_downloadMessageDic objectForKey:@"image"];
    NSDictionary * imageMessageDic = downloadImageArr [section];
    return [[imageMessageDic objectForKey:kImageCacheArr] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_fileType == LOCALFILE_TYPE_VIDEO) {
        return  1;
    }
    NSArray * downloadImageArr = [_downloadMessageDic objectForKey:@"image"];
    return [downloadImageArr count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_fileType == LOCALFILE_TYPE_VIDEO) {
        return 0;
    }
    return 44;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray * downloadImageArr = [_downloadMessageDic objectForKey:@"image"];
    NSDictionary * dic = downloadImageArr[section];
    return [dic objectForKey:kImageCacheName];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_fileType == LOCALFILE_TYPE_IMAGE) {
        return kImageCellHeight;
    }
    return kVideoCellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for (UIView * view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    CALayer * lineLayer = [CALayer layer];
    [cell.contentView.layer addSublayer:lineLayer];
    lineLayer.backgroundColor = [MAIN_LINE_COLOR CGColor];

    
    if (_fileType == LOCALFILE_TYPE_VIDEO) {
        lineLayer.frame = CGRectMake(10, kVideoCellHeight - 0.5f, SCREEN_WIDTH - 10, 0.5f);
        
        NSDictionary * videoMessageDic = [_downloadMessageDic objectForKey:@"video"][indexPath.row];
        cell.textLabel.text = [videoMessageDic objectForKey:kVideoCacheName];
        
        UILabel * playVideoLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 70, 7.0f, 50, 30.0f)];
        playVideoLabel.text = @"播放";
        playVideoLabel.textColor = MAIN_COLOR;
        playVideoLabel.font = [UIFont systemFontOfSize:13];
        playVideoLabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:playVideoLabel];
        playVideoLabel.clipsToBounds = YES;
        playVideoLabel.layer.cornerRadius = 5;
        playVideoLabel.layer.borderColor = [MAIN_COLOR CGColor];
        playVideoLabel.layer.borderWidth = 1;
    }else if (_fileType == LOCALFILE_TYPE_IMAGE){
        NSDictionary * videoMessageDic = [_downloadMessageDic objectForKey:@"image"][indexPath.section];
        
        UILabel * imageNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 0.0f, 170, kImageCellHeight)];
        imageNameLabel.text = [videoMessageDic objectForKey:kImageCacheArr][indexPath.row];
        imageNameLabel.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:imageNameLabel];
        
        lineLayer.frame                = CGRectMake(10, kImageCellHeight - 0.5f, SCREEN_WIDTH - 10, 0.5f);
        
        UIImageView * imageView        = [[UIImageView alloc]initWithFrame:CGRectMake(30, 5, 80, 110)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [cell.contentView addSubview:imageView];
        NSString * imageCachePath = [NSString stringWithFormat:@"%@/%@/%@",NSHomeDirectory(),[videoMessageDic objectForKey:kImageCachePath],imageNameLabel.text];
        imageView.image = [UIImage imageWithContentsOfFile:imageCachePath];
        
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_fileType == LOCALFILE_TYPE_VIDEO) {
        if ([self.delegate respondsToSelector:@selector(playLocalVideoWithPath:)]) {
            NSDictionary * videoMessageDic = [_downloadMessageDic objectForKey:@"video"][indexPath.row];
            NSString * videoCachePath = [NSString stringWithFormat:@"%@/%@/%@",NSHomeDirectory(),[videoMessageDic objectForKey:kVideoCachePath],[videoMessageDic objectForKey:kVideoCacheName]];
            [self.delegate playLocalVideoWithPath:videoCachePath];
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

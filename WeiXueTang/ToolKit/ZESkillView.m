//
//  ZESkillView.m
//  WeiXueTang
//
//  Created by Stenson on 16/3/7.
//  Copyright © 2016年 Stenson. All rights reserved.
//

#define kContentViewMarginLeft  0.0f
#define kContentViewMarginTop   (0.0f)
#define kContentViewWidth       SCREEN_WIDTH
#define kContentViewHeight      (SCREEN_HEIGHT - 64.0f - 44.0f)

#import "ZESkillView.h"
#import "Masonry.h"
#import "ZEToolKitModel.h"

@interface ZESkillView()
{
    UITableView * _contentView;
}
@property (nonatomic,retain) NSArray * toolKitListArr;  //   工具包数据列表

@end

@implementation ZESkillView

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
}

#pragma mark - Public Method

-(void)contentViewReloadData:(NSArray *)arr
{
    self.toolKitListArr = arr;
    [_contentView reloadData];
}

-(void)contentViewReload{
    [_contentView reloadData];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.toolKitListArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellID = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for (UIView * view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    ZEToolKitModel * toolKitM = [ZEToolKitModel getDetailWithDic:self.toolKitListArr[indexPath.row]];
    cell.textLabel.text = toolKitM.filename;
        
    UIButton * downLoadBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    downLoadBtn.frame = CGRectMake(SCREEN_WIDTH - 65, 2, 40, 40);
    downLoadBtn.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:downLoadBtn];
    [downLoadBtn setTitle:@"下载" forState:UIControlStateNormal];
    downLoadBtn.tag = indexPath.row;
    [downLoadBtn addTarget:self action:@selector(downloadFiles:) forControlEvents:UIControlEventTouchUpInside];
    NSArray * arr= [toolKitM.filepath componentsSeparatedByString:@"."];
//    NSString * filePath = [NSString stringWithFormat:@"%@/file/%@",Zenith_Server,toolKitM.filepath];
    NSLog(@">>>  %@",[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),arr[0]]);
    NSString * fileStr = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),arr[0]];
    NSString * filePathStr = [fileStr stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePathStr]) {
        downLoadBtn.enabled = NO;
        [downLoadBtn setTitle:@"已下载" forState:UIControlStateNormal];
        downLoadBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [downLoadBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    
    return cell;
}
#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{    
    ZEToolKitModel * toolKitM = [ZEToolKitModel getDetailWithDic:self.toolKitListArr[indexPath.row]];
    if([ZEUtil isStrNotEmpty:toolKitM.pngtype]){
        if ([self.delegate respondsToSelector:@selector(playCourswareImagePath:withType:withPageNum:)]) {
            NSArray * arr= [toolKitM.filepath componentsSeparatedByString:@"."];
            NSString * filePath = [NSString stringWithFormat:@"%@/file/%@",Zenith_Server,arr[0]];
            [self.delegate playCourswareImagePath:filePath withType:toolKitM.pngtype withPageNum:toolKitM.pngnum];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(playCourswareVideo:)]) {
            NSString * filePath = [NSString stringWithFormat:@"%@/file/%@",Zenith_Server,toolKitM.filepath];
            [self.delegate playCourswareVideo:filePath];
        }
    }
}

-(void)downloadFiles:(UIButton *)button
{
    ZEToolKitModel * toolKitM = [ZEToolKitModel getDetailWithDic:self.toolKitListArr[button.tag]];
    NSArray * arr= [toolKitM.filepath componentsSeparatedByString:@"."];
    NSString * filePath = [NSString stringWithFormat:@"%@/file/%@",Zenith_Server,arr[0]];
    
    button.hidden = YES;
    
    ZEProgressView *waiting = [[ZEProgressView alloc] initWithFrame:CGRectZero];
    waiting.backgroundColor = [UIColor clearColor];
    waiting.bounds = CGRectMake(0, 0, 30, 30);
    [waiting setProgress:0.0];
    waiting.center = button.center;
    [button.superview addSubview:waiting];

    if([ZEUtil isStrNotEmpty:toolKitM.pngtype]){
        if ([self.delegate respondsToSelector:@selector(downloadImagesWithUrlPath:cachePath:progressView:)]) {
            [self.delegate downloadImagesWithUrlPath:filePath cachePath:arr[0] progressView:waiting];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(downloadVideosWithUrlPath:cachePath:fileName:progressView:)]) {
            [self.delegate downloadVideosWithUrlPath:filePath cachePath:arr[0] fileName:toolKitM.filename progressView:waiting];
        }
    }
}


@end

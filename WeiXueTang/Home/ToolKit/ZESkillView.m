//
//  ZESkillView.m
//  WeiXueTang
//
//  Created by Stenson on 16/3/7.
//  Copyright © 2016年  Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#define kContentViewMarginLeft  0.0f
#define kContentViewMarginTop   (0.0f)
#define kContentViewWidth       SCREEN_WIDTH
#define kContentViewHeight      (SCREEN_HEIGHT - 64.0f - 44.0f)

#import "ZESkillView.h"
#import "Masonry.h"
#import "ZEToolKitModel.h"
#import "ZEDownloadCaches.h"
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
    NSString * fileStr = [NSString stringWithFormat:@"%@/%@",CACHEPATH,arr[0]];
    NSString * filePathStr = [fileStr stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePathStr]) {
        downLoadBtn.enabled = NO;
        [downLoadBtn setTitle:@"已下载" forState:UIControlStateNormal];
        downLoadBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [downLoadBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    
    NSArray * downloadCachesArr = [[ZEDownloadCaches instance] getCurrentDownloadTasks];
    for (NSDictionary * dic in downloadCachesArr) {
        if ([[dic objectForKey:@"fileName"] isEqualToString:toolKitM.filename]) {
            downLoadBtn.hidden = YES;
            ZEProgressView *waiting = [dic objectForKey:@"progress"];
            [cell.contentView addSubview:waiting];
            
            break;
        }
    }
    
    
    return cell;
}
#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    ZEToolKitModel * toolKitM = [ZEToolKitModel getDetailWithDic:self.toolKitListArr[indexPath.row]];

    NSArray * arr= [toolKitM.filepath componentsSeparatedByString:@"."];
    NSString * fileStr = [NSString stringWithFormat:@"%@/%@",CACHEPATH,arr[0]];
    NSString * filePathStr = [fileStr stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePathStr]) {
        if([ZEUtil isStrNotEmpty:toolKitM.pngtype]){
            if ([self.delegate respondsToSelector:@selector(loadLocalImageFile:withType:withPageNum:)]) {
                [self.delegate loadLocalImageFile:filePathStr withType:toolKitM.pngtype withPageNum:toolKitM.pngnum];
            }
        }else{            
            if ([self.delegate respondsToSelector:@selector(playLocalVideoFile:)]) {
                NSString * videoPathStr = [NSString stringWithFormat:@"%@/%@",filePathStr,toolKitM.filename];
                [self.delegate playLocalVideoFile:videoPathStr];
            }
        }
    }else{
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
}

-(void)downloadFiles:(UIButton *)button
{
    NSArray * downloadCaches = [[ZEDownloadCaches instance] getCurrentDownloadTasks];
    if (downloadCaches.count > 0) {
        [self showAlertView];
        return;
    }
    
    ZEToolKitModel * toolKitM = [ZEToolKitModel getDetailWithDic:self.toolKitListArr[button.tag]];
    NSString * noSuffixFileName = [toolKitM.filename componentsSeparatedByString:@"."][0];

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
        [[ZEDownloadCaches instance] setCurrentDownloadTasks:toolKitM.filename loadView:waiting];
        if ([self.delegate respondsToSelector:@selector(downloadImagesWithFileName:urlPath:cachePath:progressView:)]) {
            [self.delegate downloadImagesWithFileName:noSuffixFileName urlPath:filePath cachePath:arr[0] progressView:waiting];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(downloadVideosWithUrlPath:cachePath:fileName:progressView:)]) {
            [[ZEDownloadCaches instance] setCurrentDownloadTasks:toolKitM.filename loadView:waiting];
            [self.delegate downloadVideosWithUrlPath:filePath cachePath:arr[0] fileName:toolKitM.filename progressView:waiting];
        }
    }
}
-(void)showAlertView
{
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"当前有正在进行的下载任务，请下载完成后再进行下载" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

@end

//
//  ZEChildTeamFileView.m
//  WeiXueTang
//
//  Created by Stenson on 16/4/19.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import "ZEChildTeamFileView.h"
#import "MASonry.h"
#import "ZEDownloadFileModel.h"
#import "ZEDownloadCaches.h"
@interface ZEChildTeamFileView ()
{
    UITableView * _contentTableView;
}

@property (nonatomic,strong) NSArray * childTeamFileArr;

@end

@implementation ZEChildTeamFileView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initContentView];
    }
    return self;
}

-(void)initContentView
{
    _contentTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _contentTableView.delegate = self;
    _contentTableView.dataSource = self;
    _contentTableView.showsVerticalScrollIndicator = NO;
    _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_contentTableView];
    [_contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0.0f);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT));
    }];
}
#pragma mark - Public Method

-(void)contentViewReloadData:(NSArray *)arr
{
    if(arr.count != 0){
        self.childTeamFileArr = arr;
    }
    [_contentTableView reloadData];
}
-(void)contentViewReload{
    [_contentTableView reloadData];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.childTeamFileArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    for (UIView * view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    ZEDownloadFileModel * downloadfileM = [ZEDownloadFileModel getDetailWithDic:self.childTeamFileArr[indexPath.row]];
    
    UILabel * nameLable = [[UILabel alloc]initWithFrame:CGRectMake(65, 0, SCREEN_WIDTH - 130, 44)];
    [cell.contentView addSubview:nameLable];
    nameLable.text = downloadfileM.filename;
    nameLable.numberOfLines = 0;
    nameLable.font = [UIFont systemFontOfSize:14];
    
    CALayer * cellLineLayer = [CALayer layer];
    cellLineLayer.frame = CGRectMake(0.0, 43.5f, SCREEN_WIDTH,0.5f);
    [cell.contentView.layer addSublayer:cellLineLayer];
    cellLineLayer.backgroundColor = [MAIN_LINE_COLOR CGColor];
    
    UIImageView * imageView        = [[UIImageView alloc]initWithFrame:CGRectMake(20, 7, 40, 30)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [cell.contentView addSubview:imageView];
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"ico_list_%@",downloadfileM.filetype]];
    if([downloadfileM.filetype isEqualToString:@"docx"]){
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"ico_list_doc"]];
    }
    
    if (![downloadfileM.filetype isEqualToString:@"folder"]) {
        UIButton * downLoadBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        downLoadBtn.frame = CGRectMake(SCREEN_WIDTH - 65, 2, 40, 40);
        downLoadBtn.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:downLoadBtn];
        [downLoadBtn setTitle:@"下载" forState:UIControlStateNormal];
        downLoadBtn.tag = indexPath.row;
        [downLoadBtn addTarget:self action:@selector(downloadFiles:) forControlEvents:UIControlEventTouchUpInside];
        NSArray * arr= [downloadfileM.filepath componentsSeparatedByString:@"."];
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
            if ([[dic objectForKey:@"fileName"] isEqualToString:downloadfileM.filename]) {
                downLoadBtn.hidden = YES;
                ZEProgressView *waiting = [dic objectForKey:@"progress"];
                [cell.contentView addSubview:waiting];
                
                break;
            }
        }

    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    ZEDownloadFileModel * downloadfileM = [ZEDownloadFileModel getDetailWithDic:self.childTeamFileArr[indexPath.row]];
    if ([downloadfileM.filetype isEqualToString:@"folder"]) {
        [self loadNextFolder:downloadfileM];
    }else{
        [self loadFile:downloadfileM];
    }
}
/******************  加载下层文件夹  ***************/
-(void)loadNextFolder:(ZEDownloadFileModel *)downloadfileM
{
    NSArray * pathArr = [downloadfileM.filepath componentsSeparatedByString:@"\\"];
    NSString * filePath = [downloadfileM.filepath stringByReplacingOccurrencesOfString:pathArr[0] withString:@""];
    if ([self.delegate respondsToSelector:@selector(goChildTeamWithPath:withFileName:)]) {
        [self.delegate goChildTeamWithPath:filePath withFileName:downloadfileM.filename];
    }
}
/******************  加载文件  ***************/

-(void)loadFile:(ZEDownloadFileModel *)downloadfileM
{
    NSArray * arr= [downloadfileM.filepath componentsSeparatedByString:@"."];
    NSString * fileStr = [NSString stringWithFormat:@"%@/%@",CACHEPATH,arr[0]];
    NSString * filePathStr = [fileStr stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];

    if ([[NSFileManager defaultManager] fileExistsAtPath:filePathStr]) {
        if([ZEUtil isStrNotEmpty:downloadfileM.pngtype]){
            if ([self.delegate respondsToSelector:@selector(loadLocalImageFile:withType:withPageNum:)]) {
                NSLog(@">>>  %@",filePathStr);
                [self.delegate loadLocalImageFile:filePathStr withType:downloadfileM.pngtype withPageNum:downloadfileM.pngnum];
            }
        }else{
            if ([self.delegate respondsToSelector:@selector(playLocalVideoFile:)]) {
                NSString * videoPathStr = [NSString stringWithFormat:@"%@/%@",filePathStr,downloadfileM.filename];
                [self.delegate playLocalVideoFile:videoPathStr];
            }
        }
    }else{
        if([ZEUtil isStrNotEmpty:downloadfileM.pngtype]){
            if ([self.delegate respondsToSelector:@selector(playCourswareImagePath:withType:withPageNum:)]) {
                NSArray * arr= [downloadfileM.filepath componentsSeparatedByString:@"."];
                NSString * filePath = [NSString stringWithFormat:@"%@/file/%@",Zenith_Server,arr[0]];
                [self.delegate playCourswareImagePath:filePath withType:downloadfileM.pngtype withPageNum:downloadfileM.pngnum];
            }
        }else{
            if ([self.delegate respondsToSelector:@selector(playCourswareVideo:)]) {
                NSString * filePath = [NSString stringWithFormat:@"%@/file/%@",Zenith_Server,downloadfileM.filepath];
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
    
    ZEDownloadFileModel * downloadfileM = [ZEDownloadFileModel getDetailWithDic:self.childTeamFileArr[button.tag]];
    NSString * noSuffixFileName = [downloadfileM.filename componentsSeparatedByString:@"."][0];
    NSArray * arr= [downloadfileM.filepath componentsSeparatedByString:@"."];
    NSString * filePath = [NSString stringWithFormat:@"%@/file/%@",Zenith_Server,arr[0]];
    
    button.hidden = YES;
    
    ZEProgressView *waiting = [[ZEProgressView alloc] initWithFrame:CGRectZero];
    waiting.backgroundColor = [UIColor clearColor];
    waiting.bounds = CGRectMake(0, 0, 30, 30);
    [waiting setProgress:0.0];
    waiting.center = button.center;
    [button.superview addSubview:waiting];
    
    if([ZEUtil isStrNotEmpty:downloadfileM.pngtype]){
        [[ZEDownloadCaches instance] setCurrentDownloadTasks:downloadfileM.filename loadView:waiting];
        if ([self.delegate respondsToSelector:@selector(downloadImagesWithFileName:urlPath:cachePath:progressView:)]) {
            [self.delegate downloadImagesWithFileName:noSuffixFileName urlPath:filePath cachePath:arr[0] progressView:waiting];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(downloadVideosWithUrlPath:cachePath:fileName:progressView:)]) {
            [[ZEDownloadCaches instance] setCurrentDownloadTasks:downloadfileM.filename loadView:waiting];
            [self.delegate downloadVideosWithUrlPath:filePath cachePath:arr[0] fileName:downloadfileM.filename progressView:waiting];
        }
    }
}

-(void)showAlertView
{
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"当前有正在进行的下载任务，请下载完成后再进行下载" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}
@end

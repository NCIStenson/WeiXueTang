//
//  ZEImageView.m
//  WeiXueTang
//
//  Created by Stenson on 16/3/8.
//  Copyright © 2016年 Stenson. All rights reserved.
//

#define kCollectionMarginLeft   0.0f
#define kCollectionMarginTop    0.0f
#define kCollectionWidth        SCREEN_WIDTH
#define kCollectionHeight       (SCREEN_HEIGHT - 64.0f)


#import "ZEImageView.h"
#import "Masonry.h"

#import "UIImageView+WebCache.h"

@interface ZEImageView ()
{
    UIImageView *imageView;
    UICollectionView * _collectionView;
}

/************  图片数量  ***************/
@property (nonatomic,copy) NSString * pngPageNum;
/************  图片路径  ***************/
@property (nonatomic,copy) NSString * filePath;
/************  图片类型  ***************/
@property (nonatomic,copy) NSString * pngType;

@end

@implementation ZEImageView


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
    
    UICollectionViewFlowLayout * collLayout = [[UICollectionViewFlowLayout alloc]init];
    [collLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    collLayout.minimumInteritemSpacing = 0.0f;
    collLayout.minimumLineSpacing = 0.0f;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:collLayout];
    _collectionView.pagingEnabled = YES;
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.maximumZoomScale = 2.0f;
    _collectionView.minimumZoomScale = 0.5f;
    [self addSubview:_collectionView];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kCollectionMarginLeft);
        make.top.mas_equalTo(kCollectionMarginTop);
        make.size.mas_equalTo(CGSizeMake(kCollectionWidth, kCollectionHeight));
    }];
    
}
#pragma mark - Publick Method
/**
 *  @author Stenson, 16-03-08 15:03:59
 *
 *  刷新界面
 *
 *  @param pageNum 图片数量
 *  @param path    图片路径
 *  @param type    图片类型
 */
-(void)reloadView:(NSString *)pageNum pngFielPath:(NSString *)path pngType:(NSString *)type
{
    self.pngPageNum = pageNum;
    self.filePath = path;
    self.pngType = type;
    
    [_collectionView reloadData];
}


#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_pngPageNum integerValue];
}

-(UICollectionViewCell * )collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"cell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    for (id subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
//   图片路径  服务器地址 + 1（默认1开始）+ 图片类型 （png，jpg）
    
    NSString *str = [[NSString stringWithFormat:@"%@/\%ld%@",_filePath,(long)indexPath.row + 1,_pngType] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * urlStr = [NSURL URLWithString:str];

    UIImageView * contentImage = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, kCollectionWidth, kCollectionHeight)];
    [contentImage sd_setImageWithURL:urlStr];
    [cell.contentView addSubview:contentImage];
    
    return cell;
    
}
#pragma mark --UICollectionViewDelegateFlowLayout

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kCollectionWidth, kCollectionHeight);
}


#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@">>>>>>>>>");
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>");
    return imageView;
}



@end

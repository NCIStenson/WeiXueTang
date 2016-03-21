//
//  ZEImageView.m
//  WeiXueTang
//
//  Created by Stenson on 16/3/8.
//  Copyright © 2016年  Zenith Electronic Technology Co., Ltd. All rights reserved.
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
    
    NSLog(@">>>  %@",cell.contentView.subviews);
    
    for (id subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
//   图片路径  服务器地址 + 1（默认1开始）+ 图片类型 （png，jpg）
    
    NSString *str                = [[NSString stringWithFormat:@"%@/\%ld%@",_filePath,(long)indexPath.row + 1,_pngType] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSURL * urlStr               = [NSURL URLWithString:str];

    UIImageView * contentImage   = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, kCollectionWidth, kCollectionHeight)];
    [contentImage sd_setImageWithURL:urlStr];
    contentImage.userInteractionEnabled = YES;
    contentImage.backgroundColor = [UIColor redColor];
    contentImage.contentMode     = UIViewContentModeScaleAspectFit;
    [cell.contentView addSubview:contentImage];

    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scale:)];
    [contentImage addGestureRecognizer:pinchRecognizer];
    
    return cell;
}

-(void)scale:(id)sender {
    
    UIPinchGestureRecognizer * pinchGes = (UIPinchGestureRecognizer*)sender;
    float viewX =pinchGes.view.frame.origin.x;
    float viewY =pinchGes.view.frame.origin.y;
    float viewW =pinchGes.view.frame.size.width;
    float viewH =pinchGes.view.frame.size.height;
    
    if (viewW < SCREEN_WIDTH - 1 || viewH < kCollectionHeight - 1) {
        pinchGes.view.frame = CGRectMake(viewX ,viewY,SCREEN_WIDTH ,kCollectionHeight);
        pinchGes.view.center = CGPointMake(SCREEN_WIDTH / 2, kCollectionHeight / 2);
        return;
    }else if (viewW > SCREEN_WIDTH * 2 || viewH > kCollectionHeight * 2){
        pinchGes.view.frame = CGRectMake(viewX , viewY,SCREEN_WIDTH * 2 - 1 ,kCollectionHeight * 2 - 1);
        pinchGes.view.center = CGPointMake(SCREEN_WIDTH / 2, kCollectionHeight / 2);
        return;
    }

    if([pinchGes state] == UIGestureRecognizerStateEnded){
        if (viewW < SCREEN_WIDTH * 2 && viewH < kCollectionHeight * 2) {
            UIPanGestureRecognizer * panGes = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panView:)];
            [pinchGes.view addGestureRecognizer:panGes];
            
            UITapGestureRecognizer *doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap:)];
            [doubleTapGestureRecognizer setNumberOfTapsRequired:2];
            [pinchGes.view addGestureRecognizer:doubleTapGestureRecognizer];
        }else if(viewW == SCREEN_WIDTH ){
            for (id ges in pinchGes.view.gestureRecognizers) {
                if ([ges isKindOfClass:[UIPanGestureRecognizer class]]) {
                    [pinchGes.view removeGestureRecognizer:ges];
                }
            }
        }
    }
    
    CGAffineTransform currentTransform = pinchGes.view.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, pinchGes.scale, pinchGes.scale);
    [pinchGes.view setTransform:newTransform];
    pinchGes.scale = 1;
    
}

// 处理双击手势

-(void)doubleTap:(UITapGestureRecognizer *)tap
{
    tap.view.frame = CGRectMake(0 ,0,SCREEN_WIDTH ,kCollectionHeight);
    tap.view.center = CGPointMake(SCREEN_WIDTH / 2, kCollectionHeight / 2);
    for (id ges in tap.view.gestureRecognizers) {
        if ([ges isKindOfClass:[UIPanGestureRecognizer class]] || [ges isKindOfClass:[UITapGestureRecognizer class]]) {
            [tap.view removeGestureRecognizer:ges];
        }
    }

    
}

// 处理拖拉手势
- (void) panView:(UIPanGestureRecognizer *)panGestureRecognizer
{
    NSLog(@">>>  %@",NSStringFromCGRect(panGestureRecognizer.view.frame));
    
    UIView *view = panGestureRecognizer.view;
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGestureRecognizer translationInView:view.superview];
        [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
        [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
    }
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}

#pragma mark --UICollectionViewDelegateFlowLayout

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kCollectionWidth, kCollectionHeight);
}


#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger num = scrollView.contentOffset.x / kCollectionWidth;
    if ([self.delegate respondsToSelector:@selector(collectionViewDidEndDecelerating:)]) {
        [self.delegate collectionViewDidEndDecelerating:[NSString stringWithFormat:@"%ld",(long)num + 1]];
    }
}



@end

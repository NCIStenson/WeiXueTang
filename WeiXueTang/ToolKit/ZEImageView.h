//
//  ZEImageView.h
//  WeiXueTang
//
//  Created by Stenson on 16/3/8.
//  Copyright © 2016年 Stenson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZEImageView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

-(id)initWithFrame:(CGRect)frame;

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
-(void)reloadView:(NSString *)pageNum pngFielPath:(NSString *)path pngType:(NSString *)type;

@end

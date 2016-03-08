//
//  ZEImageViewController.h
//  WeiXueTang
//
//  Created by Stenson on 16/3/8.
//  Copyright © 2016年 Stenson. All rights reserved.
//

#import "ZESettingRootVC.h"

@interface ZEImageViewController : ZESettingRootVC

/************  图片数量  ***************/
@property (nonatomic,copy) NSString * pngPageNum;
/************  图片路径  ***************/
@property (nonatomic,copy) NSString * filePath;
/************  图片类型  ***************/
@property (nonatomic,copy) NSString * pngType;

@end

//
//  ZEDianZanView.h
//  WeiXueTang
//
//  Created by Stenson on 16/3/17.
//  Copyright © 2016年 Stenson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZEDianZanView.h"
@class ZEDianZanView;

@protocol ZEDianZanViewDelegate <NSObject>

/**
 *  前一页数据
 */
-(void)previousPage;

/**
 *  后一页数据
 */
-(void)nextPage;

@end

@interface ZEDianZanView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) id <ZEDianZanViewDelegate> delegate;

-(id)initWithFrame:(CGRect)rect;

/**
 *  刷新数据
 */

-(void)reloadData:(NSDictionary *)dic;

@end

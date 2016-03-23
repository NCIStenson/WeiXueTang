//
//  ZEDetailProjectView.h
//  WeiXueTang
//
//  Created by Stenson on 16/3/22.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZEExpertAssModel.h"
@interface ZEDetailProjectView : UIView

-(id)initWithFrame:(CGRect)frame withModel:(ZEExpertAssModel *)expert withType:(EXPERTASSESSMENT_TYPE)type;

@end

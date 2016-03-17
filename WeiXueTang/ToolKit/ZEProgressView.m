//
//  ZEProgressView.m
//  WeiXueTang
//
//  Created by Stenson on 16/3/10.
//  Copyright © 2016年 Stenson. All rights reserved.
//

#import "ZEProgressView.h"

@interface ZEProgressView ()

@property (nonatomic,retain) UILabel * progressLabel;

@end

@implementation ZEProgressView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        [self initView];
    }
    return self;
}

-(void)initView
{
    self.progressLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    _progressLabel.font = [UIFont systemFontOfSize:8];
    _progressLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_progressLabel];
    _progressLabel.textColor = MAIN_COLOR;
    _progressLabel.backgroundColor = [UIColor clearColor];
    _progressLabel.text = @"0%";
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    [_progressLabel setText:[NSString stringWithFormat:@"%.2f",progress]];
    [self setNeedsDisplay];
    if (progress >= 1) {
        [self removeFromSuperview];
        [_progressLabel removeFromSuperview];
    }
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat xCenter = rect.size.width * 0.5;
    CGFloat yCenter = rect.size.height * 0.5;
    [[UIColor whiteColor] set];
    CGContextSetLineWidth(ctx, 2);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    [MAIN_COLOR setStroke];
    CGFloat to = - M_PI * 0.5 + self.progress * M_PI * 2 + 0.05; // 初始值0.05
    CGFloat radius = MIN(rect.size.width, rect.size.height) * 0.5 - 5;
    CGContextAddArc(ctx, xCenter, yCenter, radius, - M_PI * 0.5, to, 0);
    CGContextStrokePath(ctx);

//    switch (self.mode) {
//        case SDWaitingViewModePieDiagram:
//        {
//            CGFloat radius = MIN(rect.size.width * 0.5, rect.size.height * 0.5) - SDWaitingViewItemMargin;
//            
//            
//            CGFloat w = radius * 2 + SDWaitingViewItemMargin;
//            CGFloat h = w;
//            CGFloat x = (rect.size.width - w) * 0.5;
//            CGFloat y = (rect.size.height - h) * 0.5;
//            CGContextAddEllipseInRect(ctx, CGRectMake(x, y, w, h));
//            CGContextFillPath(ctx);
//            
//            [SDWaitingViewBackgroundColor set];
//            CGContextMoveToPoint(ctx, xCenter, yCenter);
//            CGContextAddLineToPoint(ctx, xCenter, 0);
//            CGFloat to = - M_PI * 0.5 + self.progress * M_PI * 2 + 0.001; // 初始值
//            CGContextAddArc(ctx, xCenter, yCenter, radius, - M_PI * 0.5, to, 1);
//            CGContextClosePath(ctx);
//            
//            CGContextFillPath(ctx);
//        }
//            break;
//            
//        default:
//        {
//        }
//            break;
//    }
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

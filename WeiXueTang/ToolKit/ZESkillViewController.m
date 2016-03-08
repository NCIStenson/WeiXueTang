//
//  ZESkillViewController.m
//  WeiXueTang
//
//  Created by Stenson on 16/3/7.
//  Copyright © 2016年 Stenson. All rights reserved.
//

#import "ZESkillViewController.h"
#import "JRPlayerViewController.h"
#import "ZEUserServer.h"

@interface ZESkillViewController ()
{
    ZESkillView * _skillView;
}
@end

@implementation ZESkillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"课件";
    [self sendRequest];
    [self initView];
}

-(void)initView
{
    _skillView          = [[ZESkillView alloc]initWithFrame:CGRectMake(0, 64.0f, SCREEN_WIDTH, SCREEN_HEIGHT - 64.0f)];
    [self.view addSubview:_skillView];
    _skillView.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}
-(void)sendRequest
{
    [self progressBegin:nil];
    [ZEUserServer getCoursewareList:_skillID success:^(id data) {
        NSLog(@">>  %@",data);
        if ([ZEUtil isNotNull:[data objectForKey:@"data"]]) {
            [_skillView contentViewReloadData:[data objectForKey:@"data"]];
        }
        [self progressEnd:nil];
    } fail:^(NSError *errorCode) {
        [self progressEnd:nil];
    }];
}

#pragma mark - ZESkillViewDelegate
-(void)playCourswareVideo:(NSString *)filepath
{
    NSLog(@"%@",filepath);
//    NSString *str = [@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *str = [filepath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSURL * urlStr = [NSURL URLWithString:str];
    JRPlayerViewController * playView = [[JRPlayerViewController alloc]initWithHTTPLiveStreamingMediaURL:urlStr];
    [self presentViewController:playView animated:YES completion:^{
                [playView play:nil];
    }];
    
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"mp4"];
//    JRPlayerViewController *playerVC = [[JRPlayerViewController alloc] initWithLocalMediaURL:url];
//    playerVC.mediaTitle = @"老男孩";
//    [self presentViewController:playerVC animated:YES completion:^{
//        [playerVC play:nil];
//    }];
}

#pragma mark - SuperMethod

-(void)leftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end

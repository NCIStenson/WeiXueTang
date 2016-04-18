//
//  ZEDianZanViewController.m
//  WeiXueTang
//
//  Created by Stenson on 16/3/17.
//  Copyright © 2016年  Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import "ZEDianZanViewController.h"
#import "ZEUserServer.h"
#import "ZEDianZanModel.h"
@interface ZEDianZanViewController ()
{
    ZEDianZanView * _dianZanView;
    NSInteger _currentPage;
    
    BOOL _haveNextPage; // 是否有下一页
}
@property (nonatomic,assign) NSInteger currentPage;

@end

@implementation ZEDianZanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"点赞表";
    [self initView];
    _haveNextPage = YES;
    self.currentPage = 0;
}
-(void)sendRequest:(NSString *)pageNum
{
    [MBProgressHUD showHUDAddedTo:_dianZanView animated:YES];
    [ZEUserServer getSkillSelfViewWithPage:pageNum success:^(id data) {
        
        [MBProgressHUD hideAllHUDsForView:_dianZanView animated:YES];
        if ([ZEUtil isNotNull:data]) {
            ZEDianZanModel  *dianZanM = [ZEDianZanModel getDetailWithDic:data];
             if (dianZanM.perSkill.count == 0){
                 _haveNextPage = NO;
                 _currentPage --;
             }else if (dianZanM.perSkill.count % 5 != 0){
                 _haveNextPage = NO;
                 [_dianZanView reloadData:data];
             }else{
                 _haveNextPage = YES;
                 [_dianZanView reloadData:data];
             }
        }
    } fail:^(NSError *errorCode) {
        [MBProgressHUD hideAllHUDsForView:_dianZanView animated:YES];
    }];
}

-(void)initView
{
    _dianZanView = [[ZEDianZanView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _dianZanView.delegate =self;
    [self.view addSubview:_dianZanView];
    [self.view sendSubviewToBack:_dianZanView];
}

-(void)setCurrentPage:(NSInteger)currentPage
{
    _currentPage = currentPage;
    [self sendRequest:[NSString stringWithFormat:@"%ld",(long)_currentPage]];
}

#pragma mark - ZEDianZanViewDelegate

-(void)previousPage
{
    if (_currentPage == 0) {
        [self showAlertView:@"已经是第一页了"];
        return;
    }
    self.currentPage --;
}

-(void)nextPage
{
    if(!_haveNextPage){
        [self showAlertView:@"没有后一页了"];
        return;
    }
    self.currentPage ++ ;

}
-(void)showAlertView:(NSString * )messageStr
{
    if (IS_IOS8) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:messageStr
                                                                                 message:nil
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction            = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }else{
        UIAlertView * alertView            = [[UIAlertView alloc]initWithTitle:messageStr
                                                                       message:nil
                                                                      delegate:nil
                                                             cancelButtonTitle:@"好的"
                                                             otherButtonTitles:nil, nil];
        [alertView show];
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

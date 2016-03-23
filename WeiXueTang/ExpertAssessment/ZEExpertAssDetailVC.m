//
//  ZEExpertAssDetailVC.m
//  WeiXueTang
//
//  Created by Stenson on 16/3/21.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import "ZEExpertAssDetailVC.h"
#import "ZEDetailProjectVC.h"
@interface ZEExpertAssDetailVC ()
{
    ZEExpertAssDetailView * _detailView;
}
@end

@implementation ZEExpertAssDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = _expertAssM.SKILL_NAME;
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    self.titleLabel.numberOfLines = 0;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if (_experAssType == EXPERTASSESSMENT_TYPE_NO) {
        [self setRightBtnTitle:@"评估"];
        [self.rightBtn setImage:[UIImage imageNamed:@"NotificationBackgroundSuccessIcon"] forState:UIControlStateNormal];
    }
 
    [self initView];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@">>>>>>>>>>>>>>>>>>>");
    [self.view endEditing:YES];
}

-(void)initView
{
    _detailView = [[ZEExpertAssDetailView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) withModel:_expertAssM withType:_experAssType];
    _detailView.delegate = self;
    [self.view addSubview:_detailView];
    [self.view sendSubviewToBack:_detailView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ZEExpertAssDetailViewDelegate

-(void)enterDetailProject:(ZEExpertAssModel *)expertAssM
{
    ZEDetailProjectVC * projectVC = [[ZEDetailProjectVC alloc]init];
    projectVC.expertAssM = expertAssM;
    projectVC.experAssType = _experAssType;
    [self.navigationController pushViewController:projectVC animated:YES];
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

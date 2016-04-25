//
//  ZEExpertAssDetailVC.m
//  WeiXueTang
//
//  Created by Stenson on 16/3/21.
//  Copyright © 2016年 Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import "ZEExpertAssDetailVC.h"
#import "ZEDetailProjectVC.h"
#import "ZEUserServer.h"
#import "ZEExpertAssessmentCache.h"
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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadDetailViewRowsAtIndexPaths:) name:KCHANGEEXPERTASSESSMENTSCORESUCCESS object:nil];
    [self initView];
}

-(void)reloadDetailViewRowsAtIndexPaths:(NSNotification *)noti
{
    [_detailView reloadView];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
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

-(void)enterDetailProject:(ZEExpertAssModel *)expertAssM index:(NSInteger)row
{
    ZEDetailProjectVC * projectVC = [[ZEDetailProjectVC alloc]init];
    projectVC.expertAssM = expertAssM;
    projectVC.experAssType = _experAssType;
    projectVC.indexRow = row;
    [self.navigationController pushViewController:projectVC animated:YES];
}

-(void)rightBtnClick
{
    [self.view endEditing:YES];
    
    NSMutableDictionary * dataDic = [NSMutableDictionary dictionary];
    [dataDic setObject:_expertAssM.SKILLID forKey:@"skillid"];
    [dataDic setObject:[ZEUtil getUsername] forKey:@"expert"];
    [dataDic setObject:_expertAssM.SKILL_NAME forKey:@"skillname"];
    [dataDic setObject:_expertAssM.PSNNAME forKey:@"name"];

    NSArray * dateArr = [_expertAssM.UPDATEDATE componentsSeparatedByString:@"-"];
    [dataDic setObject:[dateArr firstObject] forKey:@"time"];
    
    NSMutableArray * detailExpertScoreArr = [NSMutableArray array];
    for (int i = 0; i < _expertAssM.detailarray.count ; i ++) {
        NSString * expertScore = [[ZEExpertAssessmentCache instance] getScoreWithIndex:i];
        NSString * expertRemark = [[ZEExpertAssessmentCache instance] getRemarkWithIndex:i];
        if (![expertScore isEqualToString:@"0"]) {
            NSMutableDictionary * dataDic = [NSMutableDictionary dictionaryWithDictionary:_expertAssM.detailarray[i]];
            ZEExpertAssModel * expertM = [ZEExpertAssModel getDetailModelWithDic:_expertAssM.detailarray[i]];
            [dataDic setObject:expertM.detail_SEQKEY forKey:@"projectId"];
            [dataDic setObject:expertM.detail_PROJECTNAME forKey:@"p_classify"];
            [dataDic setObject:expertM.detail_PROJECTNAME forKey:@"p_name"];
            [dataDic setObject:expertM.detail_QUALITY forKey:@"p_dem_and"];
            [dataDic setObject:expertScore forKey:@"p_leader_score"];// 项目评分
            [dataDic setObject:expertRemark forKey:@"p_leader_explain"];
            [detailExpertScoreArr addObject:dataDic];
        }
    }
    
    [dataDic setObject:detailExpertScoreArr forKey:@"p_list"];
    [dataDic setObject:_expertAssM.LINKKEY forKey:@"LINKKEY"];

    __block ZEExpertAssDetailVC * safeSelf  = self;
    [MBProgressHUD showHUDAddedTo:_detailView animated:YES];
    [ZEUserServer postExpertAssessmentMessage:@"1"
                               assessmentData:dataDic
                                        files:nil
                                      success:^(id data) {
                                          [MBProgressHUD hideAllHUDsForView:_detailView animated:YES];
                                          NSLog(@"postExpertAssessmentMessage >>>   %@",data);
                                          if ([ZEUtil isNotNull:data]) {
                                              [safeSelf showAlertView:@"提交失败，请稍后重试"];
                                          }else{
                                              [safeSelf showAlertView:@"提交成功"];
                                              [[NSNotificationCenter defaultCenter] postNotificationName:KEXPERTSUCCESS object:nil];
                                          }
    }
                                         fail:^(NSError *errorCode) {
                                             [MBProgressHUD hideAllHUDsForView:_detailView animated:YES];
    }];
    
    
}

-(void)showAlertView:(NSString *)message
{
    if (IS_IOS8) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                                 message:nil
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction            = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        //        [self presentViewController:alertController animated:YES completion:nil];
        
    }else{
        UIAlertView * alertView            = [[UIAlertView alloc]initWithTitle:message
                                                                       message:nil
                                                                      delegate:nil
                                                             cancelButtonTitle:@"好的"
                                                             otherButtonTitles:nil, nil];
        [alertView show];
    }
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

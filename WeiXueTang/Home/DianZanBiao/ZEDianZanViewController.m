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
#import "ZESkillViewController.h"
#import "ZEExpertAssDetailVC.h"
#import "ZEExpertAssModel.h"
@interface ZEDianZanViewController ()
{
    ZEDianZanView * _dianZanView;
    NSInteger _currentPage;
    
    BOOL _haveNextPage; // 是否有下一页
}
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,retain) NSMutableArray * evaluatedArr;
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

-(void)goSkillDetail:(NSString *)skillID
{
    ZESkillViewController * skillVC = [[ZESkillViewController alloc]init];
    skillVC.skillID = skillID;
    skillVC.enterType = ENTER_FILELIST_TYPE_TOOLKIT;
    [self.navigationController pushViewController:skillVC animated:YES];
}

-(void)goSkillExpertAss:(NSString *)seqkey
          withSkillName:(NSString *)skillName
            withOrgName:(NSString *)orgname
          withStaffName:(NSString *)staffName
{
    NSLog(@">>>  %@   %@   %@   <%@>",seqkey,skillName,orgname,staffName);
    
    [MBProgressHUD showHUDAddedTo:_dianZanView animated:YES];
    [ZEUserServer clickGoodDetail:seqkey
                          success:^(id data) {
                              [MBProgressHUD hideAllHUDsForView:_dianZanView animated:YES];
                              NSLog(@">>>  %@",data);
                              
                              if ([ZEUtil isNotNull:data]) {
                                  [self goExperAssessmentVC:[data objectForKey:@"data"]
                                              withSkillName:skillName
                                                withOrgName:orgname
                                              withStaffName:staffName];
                              }
                          } fail:^(NSError *errorCode) {
                              [MBProgressHUD hideAllHUDsForView:_dianZanView animated:YES];
                              
                          }];
}


-(void)goExperAssessmentVC:(NSDictionary *)dic
             withSkillName:(NSString *)skillName
               withOrgName:(NSString *)orgname
             withStaffName:(NSString *)staffName
{
    ZEExpertAssModel * expertM = [ZEExpertAssModel getDetailModelWithDic:@{@"detailarray":@{@"data":dic}}];
    expertM.ORGNAME = orgname;
    expertM.SKILL_NAME = skillName;
    expertM.PSNNAME = staffName;
    ZEExpertAssDetailVC * detailVC = [[ZEExpertAssDetailVC alloc]init];
    detailVC.experAssType = EXPERTASSESSMENT_TYPE_DIANZAN;
    detailVC.expertAssM = expertM;
    [self.navigationController pushViewController:detailVC animated:YES];
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

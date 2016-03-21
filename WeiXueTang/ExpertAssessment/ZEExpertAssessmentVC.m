//
//  ZEExpertAssessmentVC.m
//  WeiXueTang
//
//  Created by Stenson on 16/3/21.
//  Copyright © 2016年  Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#define kPendingBtnMarginLeft  0.0f
#define kPendingBtnMarginTop   64.0f
#define kPendingBtnWidth       100.0f
#define kPendingBtnHeight       30.0f

#define kEvaluatedBtnMarginRight 0
#define kEvaluatedBtnMarginTop   64.0f
#define kEvaluatedBtnWidth       kPendingBtnWidth
#define kEvaluatedBtnHeight      kPendingBtnHeight

#import "ZEExpertAssessmentVC.h"
#import "Masonry.h"
#import "ZEUserServer.h"
#import "ZEExpertAssModel.h"

#import "ZEExpertAssDetailVC.h"

@interface ZEExpertAssessmentVC ()
{
    UIButton * pendingBtn;
    UIButton * evaluatedBtn;
    UIButton * _currentBtn;
    
    ZEExpertAssessmentView * _assessView;
}

@property (nonatomic,retain) NSMutableArray * pendingAssArr;
@property (nonatomic,retain) NSMutableArray * evaluatedArr;

@end

@implementation ZEExpertAssessmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"专家评估";
    [self initChildVC];
    [self initView];
    [self sendRequest];
}
#pragma mark - 网络请求

-(void)sendRequest
{
    [MBProgressHUD showHUDAddedTo:_assessView animated:YES];
    [ZEUserServer getExpertAssessmentList:@"33002858" password:[ZEUtil getmd5WithString:@"0"] success:^(id data) {
        [MBProgressHUD hideHUDForView:_assessView animated:YES];
        
        if(![data objectForKey:@"USER_INVALID_PWD"]){
            NSLog(@"账号不存在");
            return;
        }
        if ([data objectForKey:@"USER_INVALID_PWD"]) {
            if ([ZEUtil isNotNull:[data objectForKey:@"data"]]) {
                [self handleData:[data objectForKey:@"data"]];
            }
        }else{
            NSLog(@"密码错误");
        }
    } fail:^(NSError *errorCode) {
        [MBProgressHUD hideHUDForView:_assessView animated:YES];
        
    }];
}
-(void)handleData:(NSArray *)arr
{
    self.pendingAssArr = [NSMutableArray array];
    self.evaluatedArr = [NSMutableArray array];
    
    for (int i = 0; i < arr.count; i ++ ) {
        ZEExpertAssModel * model = [ZEExpertAssModel getDetailModelWithDic:arr[i]];
        if ([model.STATE integerValue] == 60) {
            [self.evaluatedArr addObject:model];
        }else{
            [self.pendingAssArr addObject:model];
        }
    }
    if ([_currentBtn isEqual:evaluatedBtn]) {
        [_assessView expertAssessmentReloadView:self.evaluatedArr];
    }else{
        [_assessView expertAssessmentReloadView:self.pendingAssArr];
    }
}

#pragma mark - 界面

-(void)initChildVC
{
    _assessView = [[ZEExpertAssessmentView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT + 30.0f, SCREEN_WIDTH, (SCREEN_HEIGHT - NAV_HEIGHT - 30.0f))];
    _assessView.delegate = self;
    [self.view addSubview:_assessView];
}

-(void)initView
{
    UIView * backgroundView        = [[UIView alloc]initWithFrame:CGRectMake(0, kPendingBtnMarginTop, SCREEN_WIDTH, kPendingBtnHeight)];
    backgroundView.backgroundColor = MAIN_LINE_COLOR;
    [self.view addSubview:backgroundView];

    pendingBtn                     = [UIButton buttonWithType:UIButtonTypeSystem];
    pendingBtn.titleLabel.font     = [UIFont systemFontOfSize:13];
    [pendingBtn setTitle:@"待评估技能列表" forState:UIControlStateNormal];
    [pendingBtn setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    [pendingBtn addTarget:self action:@selector(showPendingAssView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pendingBtn];
    pendingBtn.enabled = NO;
    _currentBtn = pendingBtn;
    [pendingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kPendingBtnMarginLeft);
        make.top.mas_equalTo(kPendingBtnMarginTop);
        make.size.mas_equalTo(CGSizeMake(kPendingBtnWidth, kPendingBtnHeight));
    }];

    evaluatedBtn                   = [UIButton buttonWithType:UIButtonTypeSystem];
    evaluatedBtn.titleLabel.font   = [UIFont systemFontOfSize:11];
    [evaluatedBtn setTitle:@"已评估技能列表" forState:UIControlStateNormal];
    [evaluatedBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [evaluatedBtn addTarget:self action:@selector(showEvaluatedView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:evaluatedBtn];
    [evaluatedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(kEvaluatedBtnMarginRight);
        make.top.mas_equalTo(kEvaluatedBtnMarginTop);
        make.size.mas_equalTo(CGSizeMake(kEvaluatedBtnWidth, kEvaluatedBtnHeight));
    }];
    
    UISwipeGestureRecognizer * swipeGes = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeTransformChildVC:)];
    swipeGes.numberOfTouchesRequired = 1;
    // 指定该手势处理器只处理1 << i 方向的轻扫手势
    [swipeGes setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:swipeGes];
    
    UISwipeGestureRecognizer *rightRecognizer;
    rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeTransformChildVC:)];
    [rightRecognizer setDirection: UISwipeGestureRecognizerDirectionRight];
    [[self view] addGestureRecognizer:rightRecognizer];
}
-(void)showPendingAssView:(UIButton *)button
{
    button.enabled = NO;
    _currentBtn = button;
    evaluatedBtn.enabled = YES;
    evaluatedBtn.titleLabel.font     = [UIFont systemFontOfSize:11];
    [evaluatedBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.titleLabel.font   = [UIFont systemFontOfSize:13];
    [button setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    [_assessView expertAssessmentReloadView:self.pendingAssArr];
}

-(void)showEvaluatedView:(UIButton *)button
{
    button.enabled = NO;
    _currentBtn = button;
    pendingBtn.enabled = YES;
    pendingBtn.titleLabel.font     = [UIFont systemFontOfSize:11];
    [pendingBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.titleLabel.font   = [UIFont systemFontOfSize:13];
    [button setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    [_assessView expertAssessmentReloadView:self.evaluatedArr];
}

-(void)swipeTransformChildVC:(UISwipeGestureRecognizer *)swipe
{
    if(swipe.direction == UISwipeGestureRecognizerDirectionLeft){
        if ([_currentBtn isEqual:evaluatedBtn]) {
            return;
        }
        [self showEvaluatedView:evaluatedBtn];

    }else if (swipe.direction == UISwipeGestureRecognizerDirectionRight){
        if ([_currentBtn isEqual:pendingBtn]) {
            return;
        }
        [self showPendingAssView:pendingBtn];
    }
}

#pragma mark ZEExpertAssessmentDelegate

-(void)didSelectRow:(NSInteger)row
{
    ZEExpertAssDetailVC * detailVC = [[ZEExpertAssDetailVC alloc]init];
    if ([_currentBtn isEqual:evaluatedBtn]) {
        NSLog(@"已审核列表");
        detailVC.showSubmitBtn = YES;
        detailVC.expertAssM = self.evaluatedArr[row];
    }else{
        detailVC.expertAssM = self.pendingAssArr[row];
    }
    [self.navigationController pushViewController:detailVC animated:YES];
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

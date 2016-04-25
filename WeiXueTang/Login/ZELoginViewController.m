//
//  ZELoginViewController.m
//  NewCentury
//
//  Created by Stenson on 16/1/22.
//  Copyright © 2016年 Zenith Electronic. All rights reserved.
//

#import "ZELoginViewController.h"
#import "MBProgressHUD.h"
#import "ZELoginView.h"

#import "ZEUserServer.h"

#import "ZEMainViewController.h"
#import "ZEDownloadVC.h"


@interface ZELoginViewController ()<ZELoginViewDelegate>

@end

@implementation ZELoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
}

-(void)initView
{
    ZELoginView * loginView = [[ZELoginView alloc]initWithFrame:self.view.frame];
    loginView.delegate = self;
    [self.view addSubview:loginView];
}
-(void)dealloc
{
    
}
#pragma mark - ZELoginViewDelegate

-(void)goLogin:(NSString *)username password:(NSString *)pwd
{
    if ([username isEqualToString:@""]) {
        if (IS_IOS8) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"用户名不能为空" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }else{
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"用户名不能为空" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
        return;
    }else if (![ZEUtil isStrNotEmpty:pwd]){
        if (IS_IOS8) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"密码不能为空"
                                                                                     message:nil
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的"
                                                               style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }else{
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"密码不能为空"
                                                                message:nil
                                                               delegate:nil
                                                      cancelButtonTitle:@"好的"
                                                      otherButtonTitles:nil, nil];
            [alertView show];
        }
        return;
    }
    __block ZELoginViewController * safeSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [ZEUserServer getExpertAssessmentList:username
                                 password:[ZEUtil getmd5WithString:pwd]
                                  success:^(id data) {
                                      [MBProgressHUD hideHUDForView:self.view animated:YES];
                                      if([[data objectForKey:@"USER_EXISTED"] isEqualToString:@"false"]){
                                          [safeSelf showAlertView:@"账号不存在"];
                                      }else{
                                          if ([[data objectForKey:@"USER_INVALID_PWD"] isEqualToString:@"true"]) {
                                              [ZEUtil setUsername:username];
                                              [ZEUtil setPassword:[ZEUtil getmd5WithString:pwd]];
                                              [safeSelf createPlistFile];
                                              [safeSelf goHome];
                                          }else{
                                              [safeSelf showAlertView:@"密码错误"];
                                          }
                                      }
                                  } fail:^(NSError *errorCode) {
                                      [MBProgressHUD hideHUDForView:self.view animated:YES];
                                  }];
}

-(void)createPlistFile
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSString * filePath = [CACHEPATH stringByAppendingPathComponent:@"downloadFile.plist"];
    if (![fileManager fileExistsAtPath:CACHEPATH]) {
        [fileManager createDirectoryAtPath:CACHEPATH withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if (![fileManager fileExistsAtPath:filePath]) {
        [fileManager createFileAtPath:filePath contents:nil attributes:nil];
        NSDictionary * dic =  @{@"video":@[],
                                @"image":@[]};
        [dic writeToFile:filePath atomically:YES];
    }
    
}

-(void)showAlertView:(NSString *)alertMes
{
   
    if (IS_IOS8) {
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:alertMes message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的"
                                                           style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }else{
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:alertMes
                                                            message:nil
                                                           delegate:nil
                                                  cancelButtonTitle:@"好的"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
}

-(void)goHome
{
    ZEMainViewController * mainVC = [[ZEMainViewController alloc]init];
    mainVC.tabBarItem.image = [UIImage imageNamed:@"tab_homepage_normal"];
    mainVC.tabBarItem.title = @"首页";
    UINavigationController * mainNav = [[UINavigationController alloc]initWithRootViewController:mainVC];
    
    ZEDownloadVC * downloadVC = [[ZEDownloadVC alloc]init];
    downloadVC.tabBarItem.image = [UIImage imageNamed:@"tab_homepage_normal"];
    downloadVC.tabBarItem.title = @"下载";
    UINavigationController * downloadNav = [[UINavigationController alloc]initWithRootViewController:downloadVC];
    
    ZEMainViewController * settingVC = [[ZEMainViewController alloc]init];
    settingVC.tabBarItem.image = [UIImage imageNamed:@"tab_setting_normal"];
    settingVC.tabBarItem.title = @"设置";
    UINavigationController * settingNav = [[UINavigationController alloc]initWithRootViewController:settingVC];
    
    UITabBarController * tabBarVC = [[UITabBarController alloc]init];
    tabBarVC.viewControllers = @[mainNav,downloadNav,settingNav];
    
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = tabBarVC;
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

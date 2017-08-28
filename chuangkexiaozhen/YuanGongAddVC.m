//
//  YuanGongAddVC.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/22.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "YuanGongAddVC.h"

@interface YuanGongAddVC ()

@end

@implementation YuanGongAddVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _yuangongxinxi=[[YuanGongXinXi alloc] init];
    _yuangongxinxi.delegate=self;
    self.navigationItem.title=@"添加员工";
    self.rightbutton=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submit:)];
    self.rightbutton.tintColor=[UIColor whiteColor];
    self.rightbutton.enabled=NO;
    self.navigationItem.rightBarButtonItem=self.rightbutton;
   
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _HUD=[[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.mode=MBProgressHUDModeText;
    _HUD.labelText=@"提交成功";
    _HUD.margin=10;
    _HUD.yOffset=self.view.center.y-80;
    [_HUD show:YES];
    [_HUD hide:YES afterDelay:3];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (IBAction)submit:(id)sender {
    NSMutableDictionary* param=[NSMutableDictionary dictionary];
    
    [param setNotNullObject:self.loginName.text forKey:@"loginName"];
    [param setNotNullObject:self.department.text forKey:@"department"];
    [param setNotNullObject:self.email.text forKey:@"email"];
    [param setNotNullObject:self.mobilePhone.text forKey:@"mobilePhone"];
    [param setNotNullObject:self.name.text forKey:@"name"];
    [param setNotNullObject:self.password.text forKey:@"password"];
    [param setNotNullObject:self.rank.text forKey:@"rank"];
    [param setNotNullObject:self.remark.text forKey:@"remark"];
    [_yuangongxinxi YuanGongAdd:param];
}

-(void)afternetwork4:(id)data
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"YuanGongLieBiaoVC" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}


@end

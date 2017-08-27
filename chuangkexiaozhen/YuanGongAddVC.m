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
    UIBarButtonItem* rightbutton=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submit:)];
    rightbutton.tintColor=[UIColor whiteColor];
    rightbutton.enabled=NO;
    self.navigationItem.rightBarButtonItem=rightbutton;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

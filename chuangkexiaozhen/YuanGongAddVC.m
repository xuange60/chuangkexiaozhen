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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submit:(id)sender {
    NSMutableDictionary* param=[NSMutableDictionary dictionary];
    [param setObject:self.loginName.text forKey:@"loginName"];
    [param setObject:self.department.text forKey:@"department"];
    [param setObject:self.email.text forKey:@"email"];
    [param setObject:self.mobilePhone.text forKey:@"mobilePhone"];
    [param setObject:self.name.text forKey:@"name"];
    [param setObject:self.password.text forKey:@"password"];
    [param setObject:self.rank.text forKey:@"rank"];
    [param setObject:self.remark.text forKey:@"remark"];
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

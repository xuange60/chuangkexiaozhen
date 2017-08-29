//
//  YuanGongLieBiaoModifyVC.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/22.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "YuanGongLieBiaoModifyVC.h"

@interface YuanGongLieBiaoModifyVC ()

@end

@implementation YuanGongLieBiaoModifyVC

- (void)viewDidLoad {
    _yuangongxinxi=[[YuanGongXinXi alloc] init];
    _yuangongxinxi.delegate=self;
    self.navigationItem.title=@"修改信息";
    self.rightbutton=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submit:)];
    self.rightbutton.tintColor=[UIColor whiteColor];
    self.rightbutton.enabled=NO;
    self.navigationItem.rightBarButtonItem=self.rightbutton;
    [super viewDidLoad];
    _LoginName.text=[_datas objectNotNullForKey:@"loginName"];
    _department.text=[_datas objectNotNullForKey:@"department"];
    _email.text=[_datas objectNotNullForKey:@"email"];
    _MobilePhone.text=[_datas objectNotNullForKey:@"phone"];
    _rank.text=[_datas objectNotNullForKey:@"rank"];
    _name.text=[_datas objectNotNullForKey:@"name"];
    
    [self receiveCurrentViewController:self];
    // Do any additional setup after loading the view.
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





/*
 
 2.20.5 修改用户
 http://116.228.176.34:9002/chuangke-serve/user/update
 
 mobile	17566562783
 name	ceshigongsi
 rank	21
 remark	1112
 roleIds	5875a66fee19799d1cc83827
 roleIds	589d240277c87dfcad569547
 username	ceshi12222
 */
- (IBAction)submit:(id)sender {
    NSMutableDictionary* param=[NSMutableDictionary dictionary];
    [param setNotNullStrObject:_LoginName.text forKey:@"newLoginName"];
    [param setNotNullStrObject:[_datas objectNotNullForKey:@"loginName"] forKey:@"loginName"];
    [param setNotNullStrObject:_MobilePhone.text forKey:@"newMobilePhone"];
    [param setNotNullStrObject:[_datas objectNotNullForKey:@"mobile"]forKey:@"mobile"];
    [param setNotNullStrObject:_department.text forKey:@"department"];
    [param setNotNullStrObject:_email.text forKey:@"email"];
    [param setNotNullStrObject:[_datas objectNotNullForKey:@"id"] forKey:@"id"];
    [param setNotNullStrObject:_rank.text forKey:@"rank"];
    [param setNotNullStrObject:@"" forKey:@"remark"];
    [param setNotNullStrObject:_name.text forKey:@"name"];
    [_yuangongxinxi YuanGongUpdate:param];
    
}


-(void) afternetwork7:(id)data
{
    [self tiShiKuangDisplay:submitStr viewController:self];
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

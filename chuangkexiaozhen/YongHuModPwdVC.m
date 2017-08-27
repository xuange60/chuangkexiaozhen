//
//  YongHuModPwdVC.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/21.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "YongHuModPwdVC.h"

@interface YongHuModPwdVC ()

@end

@implementation YongHuModPwdVC

- (void)viewDidLoad {
    _yonghuxinxi=[[YongHuXinXi alloc] init];
    _yonghuxinxi.delegate=self;
    self.navigationItem.title=@"重置用户密码";
    UIBarButtonItem* rightbutton=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submit:)];
    rightbutton.tintColor=[UIColor whiteColor];
    rightbutton.enabled=NO;
    self.navigationItem.rightBarButtonItem=rightbutton;
    [super viewDidLoad];
    _username.text=[_datas objectNotNullForKey:@"loginName"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)submit:(id)sender {
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    [dic setNotNullStrObject:[_datas objectNotNullForKey:@"id"] forKey:@"id"];
    [dic setNotNullStrObject:_username.text forKey:@"username"];
    [dic setNotNullStrObject:_newpassword.text forKey:@"newpassword"];
    [dic setNotNullStrObject:_newpassword2.text forKey:@"newpassword2"];
    [_yonghuxinxi YongHuPwdModify:dic];
}

-(void) afternetwork7:(id)data
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"YongHuVC" object:nil];
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

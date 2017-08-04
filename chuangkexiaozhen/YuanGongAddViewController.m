//
//  YuanGongAddViewController.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/4.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "YuanGongAddViewController.h"

@interface YuanGongAddViewController ()

@end

@implementation YuanGongAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _yuangongguanli=[[YuanGongGuanLi alloc] init];
    _yuangongguanli.delegate=self;
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
    [_yuangongguanli YuanGongSubmit:param];
    
}

-(void)addData:(id)data
{
    NSNumber* num=(NSNumber*)data;
    int result=[num intValue];
    if(1==result){
        UIAlertController*alertCon=[UIAlertController alertControllerWithTitle:@"提示" message:@"员工添加成功" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*action2=[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertCon addAction:action2];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"YuanGongViewController" object:nil];
        [self presentViewController:alertCon animated:YES completion:nil];
    }else{
        UIAlertController*alertCon=[UIAlertController alertControllerWithTitle:@"提示" message:@"员工添加失败" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*action2=[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [alertCon addAction:action2];
        [self presentViewController:alertCon animated:YES completion:nil];
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

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
    self.navigationItem.title=@"添加";
    self.rightbutton=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submit:)];
    self.rightbutton.tintColor=[UIColor whiteColor];
    self.rightbutton.enabled=NO;
    self.navigationItem.rightBarButtonItem=self.rightbutton;
    [super viewDidLoad];
    _yuangongguanli=[[YuanGongGuanLi alloc] init];
    _yuangongguanli.delegate=self;
    
    [self receiveCurrentViewController:self];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submit:(id)sender {
    NSMutableDictionary* param=[NSMutableDictionary dictionary];
    [param setNotNullStrObject:self.loginName.text forKey:@"loginName"];
    [param setNotNullStrObject:self.department.text forKey:@"department"];
    [param setNotNullStrObject:self.email.text forKey:@"email"];
    [param setNotNullStrObject:self.mobilePhone.text forKey:@"mobilePhone"];
    [param setNotNullStrObject:self.name.text forKey:@"name"];
    [param setNotNullStrObject:self.password.text forKey:@"password"];
    [param setNotNullStrObject:self.rank.text forKey:@"rank"];
    [param setNotNullStrObject:self.remark.text forKey:@"remark"];
    [_yuangongguanli YuanGongSubmit:param];
    
}

-(void)addData:(id)data
{
    NSNumber* num=(NSNumber*)data;
    int result=[num intValue];
    if (result==1) {
        [self tiShiKuangDisplay:@"提交成功" viewController:self];
        [NSTimer scheduledTimerWithTimeInterval:1.5 repeats:NO block:^(NSTimer * _Nonnull timer) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
    }else{
        [self tiShiKuangDisplay:@"提交失败" viewController:self];
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

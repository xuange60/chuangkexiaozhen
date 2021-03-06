//
//  YuanGongDetailViewController.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/4.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "YuanGongDetailViewController.h"

@interface YuanGongDetailViewController ()

@end

@implementation YuanGongDetailViewController

- (void)viewDidLoad {
    self.navigationItem.title=@"修改";
    self.rightbutton=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(modify:)];
    self.rightbutton.tintColor=[UIColor whiteColor];
    self.rightbutton.enabled=NO;
    self.navigationItem.rightBarButtonItem=self.rightbutton;
    [super viewDidLoad];
    _yuangongguanli=[[YuanGongGuanLi alloc] init];
    _yuangongguanli.delegate=self;
    [self.loginName setText:(NSString*)[self.data objectNotNullForKey:@"loginName"]];
    [self.name setText:(NSString*)[self.data objectNotNullForKey:@"name"]];
    [self.department setText:(NSString*)[self.data objectNotNullForKey:@"department"]];
    [self.rank setText:(NSString*)[self.data objectNotNullForKey:@"rank"]];
    [self.mobilePhone setText:(NSString*)[self.data objectNotNullForKey:@"phone"]];
    [self.email setText:(NSString*)[self.data objectNotNullForKey:@"email"]];
    
    [self receiveCurrentViewController:self];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)modify:(id)sender {
    NSMutableDictionary* param=[NSMutableDictionary dictionary];
    [param setNotNullStrObject:self.department.text forKey:@"department"];
    [param setNotNullStrObject:self.email.text forKey:@"email"];
    [param setNotNullStrObject:[_data objectNotNullForKey:@"id"]  forKey:@"id"];
    [param setNotNullStrObject:[_data objectNotNullForKey:@"loginName"] forKey:@"loginName"];
    [param setNotNullStrObject:[_data objectNotNullForKey:@"phone"] forKey:@"mobile"];
    [param setNotNullStrObject:self.name.text forKey:@"name"];
    [param setNotNullStrObject:self.loginName.text forKey:@"newLoginName"];
    [param setNotNullStrObject:self.mobilePhone.text forKey:@"newMobilePhone"];
    [param setNotNullStrObject:self.rank.text forKey:@"rank"];

    [_yuangongguanli YuanGongUpdate:param];
    
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

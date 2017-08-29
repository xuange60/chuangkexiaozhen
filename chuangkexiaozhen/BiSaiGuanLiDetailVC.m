//
//  BiSaiGuanLiDetailVC.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/12.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BiSaiGuanLiDetailVC.h"

@interface BiSaiGuanLiDetailVC ()

@end

@implementation BiSaiGuanLiDetailVC

- (void)viewDidLoad {
    self.navigationItem.title=@"详情";
    self.rightbutton=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(approvesubmitclick:)];
    self.rightbutton.tintColor=[UIColor whiteColor];
    self.rightbutton.enabled=NO;
    
    [super viewDidLoad];
    _company.text=[_data objectNotNullForKey:@"name"];
    _hornerName.text=[_data objectNotNullForKey:@"hornerName"];
    _orgnizationUnit.text=[_data objectNotNullForKey:@"orgnizationUnit"];
    _competeLevel.text=[_data objectNotNullForKey:@"competeLevel"];
    _prizeAwarded.text=[_data objectNotNullForKey:@"prizeAwarded"];
    
    _jiafencailiaoshenhe=[[JiaFenCaiLiaoShenHe alloc] init];
    _jiafencailiaoshenhe.delegate=self;
    [self shengequery];
    
    [self receiveCurrentViewController:self];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) shengequery
{
    NSString* ids=[_data objectNotNullForKey:@"id"];
    [_jiafencailiaoshenhe biSaiGuanLiShenHeQuery:ids];
}


-(void)afternetwork1:(id)data
{
    NSDictionary* result=(NSDictionary*)data;
    NSString* score=[result objectNotNullForKey:@"score"];
    if(score==nil || [score length]<1){
        score=[result objectNotNullForKey:@"scoreRead"];
    }
    _score.text=score;
    if(score==nil || [score length]<1){
        [_score setHidden:YES];
        [_scorelabel setHidden:YES];
    }
    
    NSString* status1=[result objectNotNullForKey:@"statusRead"];
    _status.text=status1;
    if([status1 isEqualToString:@"审核中"] && [_isadmin  isEqualToString:@"Y"]){
        self.navigationItem.rightBarButtonItem=self.rightbutton;
        [_approveview setHidden:NO];
    }
}

- (IBAction)approvecomboclick:(id)sender {
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComboViewController*vc=[storyboard instantiateViewControllerWithIdentifier:@"ComboViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"审核通过",@"审核不通过", nil];
    [vc setDatas:array withBtn:sender];
    vc.navigationItem.title=@"审核";
    [self.navigationController pushViewController:vc animated:YES];
}

/*2孵化成长管理->日常活跃度管理->比赛管理审核
 http://116.228.176.34:9002/chuangke-serve/competition/status
 请求参数：
 competeLevel 国家级比赛
 hornerName 111
 id 598eaa0722637b17beb30f4b
 memo
 name admin3
 orgnizationUnit 111
 prizeAwarded 一等奖
 score 18
 status fail
 statusRead	审核中
 */
- (IBAction)approvesubmitclick:(id)sender {
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    [dic setNotNullStrObject:_competeLevel.text forKey:@"competeLevel"];
    [dic setNotNullStrObject:_hornerName.text forKey:@"hornerName"];
    [dic setNotNullStrObject:[_data objectNotNullForKey:@"id"] forKey:@"id"];
    [dic setNotNullStrObject:@"" forKey:@"memo"];
    [dic setNotNullStrObject:_company.text forKey:@"name"];
    [dic setNotNullStrObject:[_data objectNotNullForKey:@"orgnizationUnit"] forKey:@"orgnizationUnit"];
    [dic setNotNullStrObject:_prizeAwarded.text forKey:@"prizeAwarded"];
    
    [dic setNotNullStrObject:_score.text forKey:@"score"];
    [dic setNotNullStrObject: _approvecombo.currentTitle forKey:@"status"];
    [dic setNotNullStrObject:_status.text forKey:@"statusRead"];
    [_jiafencailiaoshenhe biSaiGuanLiSubmit:dic];
}


-(void)afternetwork2:(id)data
{
    [self tiShiKuangDisplay:submitStr viewController:self];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ADDBISAISUCCESS" object:nil];
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

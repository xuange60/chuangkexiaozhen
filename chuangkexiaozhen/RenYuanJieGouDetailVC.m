//
//  RenYuanJieGouDetailVC.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/13.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "RenYuanJieGouDetailVC.h"

@interface RenYuanJieGouDetailVC ()

@end

@implementation RenYuanJieGouDetailVC

- (void)viewDidLoad {
    self.navigationItem.title=@"详情";
    self.rightbutton=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(approvesubmitclick:)];
    self.rightbutton.tintColor=[UIColor whiteColor];
    self.rightbutton.enabled=NO;
    
    [super viewDidLoad];
    _jiafencailiaoshenhe=[[JiaFenCaiLiaoShenHe alloc] init];
    _jiafencailiaoshenhe.delegate=self;
    [self shengequery];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) shengequery
{
    NSString* ids=[_data objectNotNullForKey:@"id"];
    //modify
    [_jiafencailiaoshenhe jiaFenCaiLiaoShenHeQuery:ids withType:@"personaldistribution"];
}

-(void) afternetwork1:(id)data
{
    _detaildata=(NSDictionary*)data;
    //modify
    _toltalPerson.text=[_detaildata objectNotNullForKey:@"toltalPerson"];
    _marketPerson.text=[_detaildata objectNotNullForKey:@"marketPerson"];
    _marketPersonPercent.text=[_detaildata objectNotNullForKey:@"marketPersonPercent"];
    _techniquePerson.text=[_detaildata objectNotNullForKey:@"techniquePerson"];
    _techniquePersonPercent.text=[_detaildata objectNotNullForKey:@"techniquePersonPercent"];
    _operatePerson.text=[_detaildata objectNotNullForKey:@"operatePerson"];
    _operatePersonPercent.text=[_detaildata objectNotNullForKey:@"operatePersonPercent"];
    
    NSString* score=[_detaildata objectNotNullForKey:@"score"];
    if(score==nil || [score length]<1){
        score=[_detaildata objectNotNullForKey:@"scoreRead"];
    }
    _score.text=score;
    if(score==nil || [score length]<1){
        [_score setHidden:YES];
        [_scorelabel setHidden:YES];
    }
    
    _status.text=[_detaildata objectNotNullForKey:@"statusRead"];
    NSString* status1=[_detaildata objectNotNullForKey:@"statusRead"];
    if([status1 isEqualToString:@"审核中"] && [_isadmin  isEqualToString:@"Y"]){
        [_approveview setHidden:NO];
        self.navigationItem.rightBarButtonItem=self.rightbutton;        
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


- (IBAction)approvesubmitclick:(id)sender {
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    [dic setNotNullStrObject:[_data objectNotNullForKey:@"id"] forKey:@"id"];
    [dic setNotNullStrObject:[_detaildata objectNotNullForKey:@"toltalPerson"] forKey:@"toltalPerson"];
    [dic setNotNullStrObject:[_detaildata objectNotNullForKey:@"marketPerson"] forKey:@"marketPerson"];
    [dic setNotNullStrObject:[_detaildata objectNotNullForKey:@"marketPersonPercent"] forKey:@"marketPersonPercent"];
    [dic setNotNullStrObject:[_detaildata objectNotNullForKey:@"techniquePerson"] forKey:@"techniquePerson"];
    [dic setNotNullStrObject:[_detaildata objectNotNullForKey:@"techniquePersonPercent"] forKey:@"techniquePersonPercent"];
    [dic setNotNullStrObject:[_detaildata objectNotNullForKey:@"operatePerson"] forKey:@"operatePerson"];
    //modify
    [dic setNotNullStrObject:[_detaildata objectNotNullForKey:@"operatePersonPercent"] forKey:@"operatePersonPercent"];
    
    [dic setNotNullStrObject:_score.text forKey:@"score"];
    [dic setNotNullStrObject:[_detaildata objectNotNullForKey:@"statusRead"] forKey:@"statusRead"];
    [dic setNotNullStrObject: _approvecombo.currentTitle forKey:@"status"];
    
    //modify
    [_jiafencailiaoshenhe jiaFenCaiLiaoShenHeSubmit:dic withType:@"personaldistribution"];
}


-(void)afternetwork2:(id)data
{
    //modify
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ADDRENYUANJIEGOUSUCCESS" object:nil];
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

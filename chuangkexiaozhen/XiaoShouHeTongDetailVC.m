//
//  XiaoShouHeTongDetailVC.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/13.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "XiaoShouHeTongDetailVC.h"

@interface XiaoShouHeTongDetailVC ()

@end

@implementation XiaoShouHeTongDetailVC

- (void)viewDidLoad {
    self.navigationItem.title=@"详情";
    UIBarButtonItem* rightbutton=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(approvesubmitclick:)];
    rightbutton.tintColor=[UIColor whiteColor];
    rightbutton.enabled=NO;
    self.navigationItem.rightBarButtonItem=rightbutton;
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
    [_jiafencailiaoshenhe jiaFenCaiLiaoShenHeQuery:ids withType:@"market/sale"];
}

-(void) afternetwork1:(id)data
{
    _detaildata=(NSDictionary*)data;

    

    
    _pactName.text=[_detaildata objectNotNullForKey:@"pactName"];
    
    //modify
    _partnerLevel.text=[_detaildata objectNotNullForKey:@"partnerLevel"];
    _saleMoney.text=[_detaildata objectNotNullForKey:@"saleMoney"];
    _partnerPrice.text=[_detaildata objectNotNullForKey:@"partnerPrice"];
    _saleBenefit.text=[_detaildata objectNotNullForKey:@"saleBenefit"];
    _societyBenefit.text=[_detaildata objectNotNullForKey:@"societyBenefit"];
    
    
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
    [dic setNotNullStrObject:[_detaildata objectNotNullForKey:@"pactName"] forKey:@"pactName"];
    [dic setNotNullStrObject:[_detaildata objectNotNullForKey:@"partnerLevel"] forKey:@"partnerLevel"];
    [dic setNotNullStrObject:[_detaildata objectNotNullForKey:@"saleMoney"] forKey:@"saleMoney"];
    //modify
    [dic setNotNullStrObject:[_detaildata objectNotNullForKey:@"partnerPrice"] forKey:@"partnerPrice"];
    [dic setNotNullStrObject:[_detaildata objectNotNullForKey:@"saleBenefit"] forKey:@"saleBenefit"];
    [dic setNotNullStrObject:[_detaildata objectNotNullForKey:@"societyBenefit"] forKey:@"societyBenefit"];
    
    
    [dic setNotNullStrObject:_score.text forKey:@"score"];
    [dic setNotNullStrObject:[_detaildata objectNotNullForKey:@"statusRead"] forKey:@"statusRead"];
    [dic setNotNullStrObject: _approvecombo.currentTitle forKey:@"status"];
    
    //modify
    [_jiafencailiaoshenhe jiaFenCaiLiaoShenHeSubmit:dic withType:@"market/sale"];
}


-(void)afternetwork2:(id)data
{
    //modify
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ADDHETONGSUCCESS" object:nil];
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

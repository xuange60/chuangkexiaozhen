//
//  ChanXueYanDetailVC.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/12.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "ChanXueYanDetailVC.h"

@interface ChanXueYanDetailVC ()

@end

@implementation ChanXueYanDetailVC

- (void)viewDidLoad {
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
    [_jiafencailiaoshenhe chanXueYanShenHeQuery:ids];
}

-(void) afternetwork1:(id)data
{
    _detaildata=(NSDictionary*)data;
    _name.text=[_detaildata objectNotNullForKey:@"name"];
    _level.text=[_detaildata objectNotNullForKey:@"level"];
    _moneyLevel.text=[_detaildata objectNotNullForKey:@"moneyLevel"];
    _money.text=[_detaildata objectNotNullForKey:@"money"];
    _effect.text=[_detaildata objectNotNullForKey:@"effect"];
    
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
    [dic setNotNullStrObject:[_detaildata objectNotNullForKey:@"effect"] forKey:@"effect"];
    [dic setNotNullStrObject:[_detaildata objectNotNullForKey:@"level"] forKey:@"level"];
    [dic setNotNullStrObject:[_detaildata objectNotNullForKey:@"memo"] forKey:@"memo"];
    [dic setNotNullStrObject:[_detaildata objectNotNullForKey:@""] forKey:@"money"];
    [dic setNotNullStrObject:[_detaildata objectNotNullForKey:@"moneyLevel"] forKey:@"moneyLevel"];
    [dic setNotNullStrObject:[_detaildata objectNotNullForKey:@"name"] forKey:@"name"];
    [dic setNotNullStrObject:[_detaildata objectNotNullForKey:@"resourceIds"] forKey:@"resourceIds"];
    
    [dic setNotNullStrObject:_score.text forKey:@"score"];
    [dic setNotNullStrObject:[_detaildata objectNotNullForKey:@"statusRead"] forKey:@"statusRead"];
    [dic setNotNullStrObject: _approvecombo.currentTitle forKey:@"status"];
    [_jiafencailiaoshenhe chanXueYanSubmit:dic];
}


-(void)afternetwork2:(id)data
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ADDCHANYEXUESCUUESS" object:nil];
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

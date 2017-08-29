//
//  ShenSuShenQingVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/12.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "ShenSuShenQingVC.h"

@interface ShenSuShenQingVC ()

@end

@implementation ShenSuShenQingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _array=[NSArray array];
    
    self.navigationItem.title=@"申诉申请管理";
    
    _shensu=[[ShenSuShenQingGuanLi alloc]init];
    _shensu.delegate=self;
    
    [_shensu ShenSuShenQingQuery];
    
}

-(void)loadNetworkFinished:(id)data
{
    _array=(NSArray*)data;
    [_tableView reloadData];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*str=@"ShenSuShenQingCell";
    ShenSuShenQingCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell=[[ShenSuShenQingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    cell.MyView.layer.cornerRadius=5;
    cell.MyView.layer.borderWidth=0.5;
    cell.MyView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    
    /*
     2.12.1 申诉申请查询
     http://116.228.176.34:9002/chuangke-serve/stateapply/search?start=0&length=10000
     [{"id":"597f525580ab5e6790d53202","stateType"
     :"周边环境嘈杂","stateContent":"12321","stateReason":"12321321","createDate":"2017-07-31","status":"已处理","tenantTitle"
     :"测试公司zhangxuan3"},{"id":"597f523680ab5e6790d53201","stateType":"周边推销骚扰","stateContent":"23121","stateReason"
     :"2312231","createDate":"2017-07-31","status":"未处理","tenantTitle":"测试公司zhangxuan3"},{"id":"597f521080ab5e6790d531ff"
     ,"stateType":"申诉类型","stateContent":"Ceshi1\t","stateReason":"Ceshiashi1","createDate":"2017-07-31","status"
     :"未处理","tenantTitle":"测试公司zhangxuan3"}
     
     查询到请求状态为未处理的，可以 删除、查看详情、受理
     */
    
    NSDictionary*dic=[_array objectAtIndex:indexPath.row];
    cell.team.text=[dic objectNotNullForKey:@"tenantTitle"];
    cell.type.text=[dic objectNotNullForKey:@"stateType"];
    cell.content.text=[dic objectNotNullForKey:@"stateContent"];
    cell.reason.text=[dic objectNotNullForKey:@"stateReason"];
    cell.time.text=[dic objectNotNullForKey:@"createDate"];
    cell.statue.text=[dic objectNotNullForKey:@"status"];
    
    if ([cell.statue.text isEqualToString:@"未处理"]) {
        
        cell.shouLiBtn.hidden=NO;
        cell.detailBtn.hidden=NO;
        cell.deleteBtn.hidden=NO;
        
    }else{
        cell.shouLiBtn.hidden=YES;
        cell.detailBtn.hidden=NO;
        cell.deleteBtn.hidden=NO;
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
//受理的操作
- (IBAction)shouLiBtnClick:(id)sender forEvent:(UIEvent *)event {
    
    NSSet*touches=[event allTouches];
    UITouch*touch=[touches anyObject];
    CGPoint point=[touch locationInView:_tableView];
    NSIndexPath *path=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_array objectAtIndex:path.row];
    NSString*strID=[dic objectNotNullForKey:@"id"];
    
    [_shensu ShenSuShenQingSucc:strID];
}
-(void)afternetwork2:(id)data
{
    [_shensu ShenSuShenQingQuery];
}


//查看详情的操作
- (IBAction)DetailClick:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches=[event allTouches];
    UITouch*touch=[touches anyObject];
    CGPoint point=[touch locationInView:_tableView];
    NSIndexPath *path=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_array objectAtIndex:path.row];
    
//    {"id":"597f521080ab5e6790d531ff"
//        ,"stateType":"申诉类型","stateContent":"Ceshi1\t","stateReason":"Ceshiashi1","createDate":"2017-07-31","status"
//        :"未处理","tenantTitle":"测试公司zhangxuan3"}

    
    _InfoAry=[NSArray arrayWithObjects:
              [dic objectNotNullForKey:@"stateType"],
              [dic objectNotNullForKey:@"stateContent"],
              [dic objectNotNullForKey:@"stateReason"],
            nil];
    
    NSString*strID=[dic objectForKey:@"id"];
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"ShenSuShenQing" bundle:nil];
    DetailShenSuVC*vc=[board instantiateViewControllerWithIdentifier:@"DetailShenSuVC"];
    [vc setShuJu:strID   infoAry:_InfoAry];
    [self.navigationController pushViewController:vc animated:YES];
    
}

//删除的操作
- (IBAction)DeleteClick:(id)sender forEvent:(UIEvent *)event {
    
    NSSet*touches=[event allTouches];
    UITouch*touch=[touches anyObject];
    CGPoint point=[touch locationInView:_tableView];
    NSIndexPath *path=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_array objectAtIndex:path.row];
    NSString*strID=[dic objectNotNullForKey:@"id"];
    
    [_shensu ShenSuShenQingDelete:strID];
}

-(void)afternetwork1:(id)data
{
    [self tiShiKuangDisplay:deleteStr viewController:self];
    [_shensu ShenSuShenQingQuery];
}

@end

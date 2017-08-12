//
//  XuNiRuZhuVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/11.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "XuNiRuZhuVC.h"

@interface XuNiRuZhuVC ()

@end

@implementation XuNiRuZhuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _array=[NSArray array];
    
    self.navigationItem.title=@"虚拟入驻管理";
    
    _XuNi=[[XuNiRuZhuGuanLi alloc]init];
    _XuNi.delegate=self;
        
    [_XuNi XuNiRuZhuGuanLiQuery];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveInfo) name:@"XIUGAIXUNISUCCESS" object:nil];
    
}
//修改信息后的刷新
-(void)receiveInfo
{
    [_XuNi XuNiRuZhuGuanLiQuery];
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
    static NSString*str=@"XuNiRuZhuCell";
    XuNiRuZhuCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell=[[XuNiRuZhuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    /*
     2.10.1 虚拟入驻管理查询
     http://116.228.176.34:9002/chuangke-serve/apply/search?typeNumber=1&start=0&length=10000
     [{"id":"598880a622637b17beb2f877","contact"
     :"","contactType":"","companyName":null,"applyDate":"2017-08-07","applyStatus":"未处理","businessLine":null
     ,"coopCategories":"信息技术需求,制造加工及场地需求,农艺新品种需求","branchName":"","desc":"","applyintype":null,"totalScore"
     :0.0,"inplace":"未报道","description":null}
     
     查询到的状态为未处理时，可以修改，审批通过，审批不通过，删除
     查询到的状态为通过或失败时，可以修改，删除
     */
    
    NSDictionary*dic=[_array objectAtIndex:indexPath.row];
    cell.lianxiren.text=[dic objectNotNullForKey:@"contact"];
    cell.lianxifangshi.text=[dic objectNotNullForKey:@"contactType"];
    cell.jigouName.text=[dic objectNotNullForKey:@"companyName"];
    cell.shenqingTime.text=[dic objectNotNullForKey:@"applyDate"];
    cell.shenqingType.text=[dic objectNotNullForKey:@"applyStatus"];
    cell.beizhu.text=[dic objectNotNullForKey:@"desc"];
   
    if ([cell.shenqingType.text isEqualToString:@"通过"]||[cell.shenqingType.text isEqualToString:@"失败"]) {
        
        cell.succBtn.hidden=YES;
        cell.errorBtn.hidden=YES;
    }else{
        cell.succBtn.hidden=NO;
        cell.errorBtn.hidden=NO;
        cell.deleteBtn.hidden=NO;
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
//编辑的操作
- (IBAction)EditClick:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches=[event allTouches];
    UITouch*touch=[touches anyObject];
    CGPoint point=[touch locationInView:_tableView];
    NSIndexPath *path=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_array objectAtIndex:path.row];
    
    _InfoAry=[NSArray arrayWithObjects:
              [dic objectNotNullForKey:@"contact"],
              [dic objectNotNullForKey:@"contactType"],
              [dic objectNotNullForKey:@"companyName"],
              [dic objectNotNullForKey:@"coopCategories"],
              [dic objectNotNullForKey:@"desc"],
              nil];
    
    NSString*strID=[dic objectForKey:@"id"];
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"XuNiRuZhu" bundle:nil];
    AddXuNiVC*vc=[board instantiateViewControllerWithIdentifier:@"AddXuNiVC"];
    [vc setShuJu:strID   infoAry:_InfoAry];
    [self.navigationController pushViewController:vc animated:YES];
    
}


//审核通过的操作
- (IBAction)SuccClick:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches=[event allTouches];
    UITouch*touch=[touches anyObject];
    CGPoint point=[touch locationInView:_tableView];
    NSIndexPath *path=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_array objectAtIndex:path.row];
    NSString*strID=[dic objectForKey:@"id"];
    
    [_XuNi XuNiRuZhuGuanLiYes:strID];
}
-(void)afternetwork4:(id)data
{
    [_XuNi XuNiRuZhuGuanLiQuery];
}

//审核不通过的操作
- (IBAction)ErrorClick:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches=[event allTouches];
    UITouch*touch=[touches anyObject];
    CGPoint point=[touch locationInView:_tableView];
    NSIndexPath *path=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_array objectAtIndex:path.row];
    NSString*strID=[dic objectForKey:@"id"];
    
    [_XuNi XuNiRuZhuGuanLiNo:strID];
}
-(void)afternetwork1:(id)data
{
    [_XuNi XuNiRuZhuGuanLiQuery];
}

//删除的操作
- (IBAction)DeleteClick:(id)sender forEvent:(UIEvent *)event {
    
    NSSet*touches=[event allTouches];
    UITouch*touch=[touches anyObject];
    CGPoint point=[touch locationInView:_tableView];
    NSIndexPath *path=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_array objectAtIndex:path.row];
    NSString*strID=[dic objectForKey:@"id"];
    
    [_XuNi XuNiRuZhuGuanLiDelete:strID];
}

-(void)afternetwork3:(id)data
{
    [_XuNi XuNiRuZhuGuanLiQuery];
}


@end

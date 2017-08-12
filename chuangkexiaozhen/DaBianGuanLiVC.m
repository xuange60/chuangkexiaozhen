//
//  DaBianGuanLiVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/8.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "DaBianGuanLiVC.h"
#import "DaBianGuanLiCell.h"
#import "DaBianGuanLi.h"
@interface DaBianGuanLiVC ()

@end

@implementation DaBianGuanLiVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _array=[NSArray array];
    
    _dabian=[[DaBianGuanLi alloc]init];
    _dabian.delegate=self;
    
    [_dabian DaBianGuanLiQuery ];//查询的网络请求
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveInfo) name:@"ADDDABIANSUCCESS" object:nil];
}

-(void)receiveInfo
{
    [_dabian DaBianGuanLiQuery];
}


//查询委托代理的刷新
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
    static NSString*str=@"DaBianGuanLiCell";
    DaBianGuanLiCell*cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell=[[DaBianGuanLiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    /*
     1.1 答辩管理查询
     请求 get  http://116.228.176.34:9002/chuangke-serve/applytreat/search?start=0&length=10000
     响应： [{"id":"58e5c76a19eb26b288dc975b","companyName"
     :"上海匠睿智能科技有限公司","defenceDate":"2017-04-06","addr":"科创小镇1楼会议室","usernames":"王俊","isspcial":1,"iftreated"
     :"true"},{"id":"58f5884519eb8cbffbb87a9e","companyName":"清基(上海）农业发展有限公司","defenceDate":"2017-04-18","addr"
     :"一楼小会议室","usernames":"王俊","isspcial":1,"iftreated":"true"}]
     "iftreated":"true" 表示已经打分
     "iftreated":"false" 表示未打分
     */

    NSDictionary*dic=[_array objectAtIndex:indexPath.row];
    
     cell.name.text=[dic objectNotNullForKey:@"companyName"];
     cell.shijian.text=[dic objectNotNullForKey:@"defenceDate"];
     cell.didian.text=[dic objectNotNullForKey:@"addr"];
     cell.renyuan.text=[dic objectNotNullForKey:@"usernames"];
    
      NSString*ornot=[dic objectNotNullForKey:@"iftreated"];
      if ([ornot isEqualToString:@"true"])
        {
            cell.scoreBtn.hidden=YES;
        }else{
             cell.scoreBtn.hidden=NO;
        }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}






- (IBAction)DeleteBtnClick:(id)sender forEvent:(UIEvent *)event {
    
    NSSet*touches=[event allTouches];
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableView];
    
    NSIndexPath *path=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_array objectAtIndex:path.row];
    
    NSString*strID=[dic objectForKey:@"id"];
    
    [_dabian DaBianDelete:strID];//删除的网络请求
}
//删除后的代理
-(void)deleteData:(id)data
{
    int result=[(NSNumber*)data  intValue];
    
    if (result==1)
    {
        [_dabian DaBianGuanLiQuery];
    }
}


- (IBAction)DaScoreBtnClick:(id)sender forEvent:(UIEvent *)event {
    
    NSSet*touches=[event allTouches];
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableView];
    
    NSIndexPath *path=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_array objectAtIndex:path.row];
    
    NSString*strID=[dic objectForKey:@"id"];


    UIStoryboard*board=[UIStoryboard storyboardWithName:@"DaBianGuanLi" bundle:nil];
    MarkScoreVC*vc=[board instantiateViewControllerWithIdentifier:@"MarkScoreVC"];
    [vc setShuJu:strID];
    [self.navigationController pushViewController:vc animated:YES];
    
}








@end

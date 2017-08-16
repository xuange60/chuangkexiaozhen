//
//  ShiTiRuZhuGuanLivc.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/8.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "ShiTiRuZhuGuanLivc.h"

@interface ShiTiRuZhuGuanLivc ()

@end

@implementation ShiTiRuZhuGuanLivc

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _array=[NSArray array];
    
    self.navigationItem.title=@"实体入驻管理";
    
    _shiti=[[ShiTiRuZhuGuanLi alloc]init];
    _shiti.delegate=self;
    
    [_shiti ShiTiRuZhuGuanLiQuery];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveInfo) name:@"XIUGAIXINXISUCCESS" object:nil];

}
//修改信息后的刷新
-(void)receiveInfo
{
    [_shiti ShiTiRuZhuGuanLiQuery];
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
    static NSString*str=@"ShiTiRuZhuGuanLiCell";
   ShiTiRuZhuGuanLiCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell=[[ShiTiRuZhuGuanLiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        
          }
//    cell.myView.layer.borderWidth=1;
//    cell.myView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    cell.myView.layer.cornerRadius=10;

    /*
     2.1 实体入驻管理查询
     请求 get  http://116.228.176.34:9002/chuangke-serve/apply/search?typeNumber=1&start=0&length=10000
     响应 
     [{"id":"597db10980ab5e6790d52d67",
     "contact":"小灰灰",
     "contactType":"18554353465",
     "companyName":"新时代",
     "applyDate":"2017-07-30",
     "applyStatus":"未处理",
     "businessLine":"互联网和移动互联网",
     "coopCategories":null,
     "branchName":null,
     "desc":null,
     "applyintype":null,
     "totalScore":0.0
     ,"inplace":"已报道",
     "description":"加速企业"},
     
     {"id":"597dbedb80ab5e6790d52d78","contact":"xiaogao1","contactType"
     :"18576672852","companyName":"craggily","applyDate":"2017-07-30","applyStatus":"通过","businessLine":"
     新材料","coopCategories":null,"branchName":null,"desc":null,"applyintype":null,"totalScore":400.0,"inplace"
     :"未报道","description":"加速企业"}
     
     申请状态有：未处理，处理中，通过，失败
     当申请状态为：未处理或处理中时，可以编辑、添加答辩、审批通过，审批不通过，删除，下载文档
     */

     NSDictionary*dic=[_array objectAtIndex:indexPath.row];
     cell.lianxiren.text=[dic objectNotNullForKey:@"contact"];
     cell.lianxifangshi.text=[dic objectNotNullForKey:@"contactType"];
     cell.jigouName.text=[dic objectNotNullForKey:@"companyName"];
     cell.hangye.text=[dic objectNotNullForKey:@"businessLine"];
     cell.shenqingTime.text=[dic objectNotNullForKey:@"applyDate"];
     cell.shenqingType.text=[dic objectNotNullForKey:@"applyStatus"];
     cell.baodaoType.text=[dic objectNotNullForKey:@"inplace"];
     cell.totalScore.text=[dic objectNotNullForKey:@"totalScore"];
    
    if ([cell.shenqingType.text isEqualToString:@"通过"]) {
        cell.addBtn.hidden=YES;
        cell.succBtn.hidden=YES;
        cell.errorBtn.hidden=YES;
        cell.deleteBtn.hidden=YES;
        cell.refreshBtn.hidden=YES;
    }else if([cell.shenqingType.text isEqualToString:@"失败"]){
        cell.addBtn.hidden=YES;
        cell.succBtn.hidden=YES;
        cell.deleteBtn.hidden=YES;
        cell.refreshBtn.hidden=NO;
        
    }else{
        cell.addBtn.hidden=NO;
        cell.succBtn.hidden=NO;
        cell.errorBtn.hidden=NO;
        cell.deleteBtn.hidden=NO;
        cell.refreshBtn.hidden=YES;
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
              [dic objectNotNullForKey:@"businessLine"],
              [dic objectNotNullForKey:@"description"],
              nil];
    
    NSString*strID=[dic objectForKey:@"id"];

    UIStoryboard*board=[UIStoryboard storyboardWithName:@"ShiTiRuZhuGuanLi" bundle:nil];
    EditShiTiVC*vc=[board instantiateViewControllerWithIdentifier:@"EditShiTiVC"];
    [vc setShuJu:strID   infoAry:_InfoAry];
    [self.navigationController pushViewController:vc animated:YES];
    
  }

//添加答辩的操作
- (IBAction)AddClick:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches=[event allTouches];
    UITouch*touch=[touches anyObject];
    CGPoint point=[touch locationInView:_tableView];
    NSIndexPath *path=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_array objectAtIndex:path.row];
    NSString*strID=[dic objectForKey:@"id"];
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"ShiTiRuZhuGuanLi" bundle:nil];
    AddShiTiVC*vc=[board instantiateViewControllerWithIdentifier:@"AddShiTiVC"];
    [vc setData:strID];
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
    
    [_shiti ShiTiRuZhuGuanLiTongGuo:strID];
}
-(void)afternetwork5:(id)data
{
    [_shiti ShiTiRuZhuGuanLiQuery];
}

//撤销的操作
- (IBAction)RefreshBtnClick:(id)sender forEvent:(UIEvent *)event {
    
    NSSet*touches=[event allTouches];
    UITouch*touch=[touches anyObject];
    CGPoint point=[touch locationInView:_tableView];
    NSIndexPath *path=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_array objectAtIndex:path.row];
    NSString*strID=[dic objectForKey:@"id"];
    [_shiti ShiTiRuZhuGuanLiJuJueCancle:strID];

}

//撤销恢复原样
-(void)afternetwork2:(id)data
{
    [_shiti ShiTiRuZhuGuanLiQuery];
}

//审核不通过的操作
- (IBAction)ErrorClick:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches=[event allTouches];
    UITouch*touch=[touches anyObject];
    CGPoint point=[touch locationInView:_tableView];
    NSIndexPath *path=[_tableView indexPathForRowAtPoint:point];
   
    NSDictionary*dic=[_array objectAtIndex:path.row];
    NSString*strID=[dic objectForKey:@"id"];
     [_shiti ShiTiRuZhuGuanLiJuJue:strID];
    
}
//拒绝按钮变样
-(void)afternetwork1:(id)data
{
     [_shiti ShiTiRuZhuGuanLiQuery];
}


//删除的操作
- (IBAction)DeleteClick:(id)sender forEvent:(UIEvent *)event {
    
    NSSet*touches=[event allTouches];
    UITouch*touch=[touches anyObject];
    CGPoint point=[touch locationInView:_tableView];
    NSIndexPath *path=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_array objectAtIndex:path.row];
    NSString*strID=[dic objectForKey:@"id"];
    
    [_shiti ShiTiRuZhuDelete:strID];
}

-(void)afternetwork6:(id)data
{
    [_shiti ShiTiRuZhuGuanLiQuery];
}


//下载文档的操作
- (IBAction)DownloadClick:(id)sender forEvent:(UIEvent *)event {
    
    NSSet*touches=[event allTouches];
    UITouch*touch=[touches anyObject];
    CGPoint point=[touch locationInView:_tableView];
    NSIndexPath *path=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_array objectAtIndex:path.row];
    NSString*strID=[dic objectForKey:@"id"];
    
    FilelistViewController*vc=[[FilelistViewController alloc]initView:strID withType:@"26"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end

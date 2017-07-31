//
//  BiSaiGuanLiVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/30.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BiSaiGuanLiVC.h"
#import "BiSaiCell.h"
#import "BussinessApi.h"
#import "AddBiSaiVC.h"
@interface BiSaiGuanLiVC ()

@end

@implementation BiSaiGuanLiVC


//提前加载数据方法
-(void)ReceiveShuJu
{
    _array=[NSArray array];
    
    [self biSaiGuanLiQuery];
}
// 网络请求，查询数据方法
-(void)biSaiGuanLiQuery
{
    
    //7.1.1孵化成长管理->日常活跃度管理->比赛管理查询
    /*
     响应 	响应数据为array；如下格式
     [{"id":"5937dbe5075910c2d60d07c6","name"
     :"上海市创新创业大赛","competeLevel":"省部级比赛","prizeAwarded":"一等奖","hornerName":"********","orgnizationUnit":""
     ,"date":"2017-06-07 10:56:37","ownerCompetition":"是","score":14,"company":"云创智能科技有限公司"}]
     */
    
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/competition/search?start=0&length=1000"];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSLog(@"%@",data);
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            NSArray* result=[jsondata objectForKey:@"obj"];
            NSLog(@"%@",result);
            //result: 保存查询到的结果
            
            
            _array=result;
            
            [_tableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"比赛管理";
    
    UIBarButtonItem*RightBarItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(RightBarItemClick:)];
    
    [self.navigationItem setRightBarButtonItem:RightBarItem];

}

//左边添加比赛事件
-(void)RightBarItemClick:(UIBarButtonItem*)item
{
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"RiChangHuoYue" bundle:nil];
    AddBiSaiVC*vc=[board instantiateViewControllerWithIdentifier:@"AddBiSaiVC"];
    [self.navigationController pushViewController:vc animated:YES];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveInfo) name:@"ADDSUCCESS" object:nil];
}
-(void)receiveInfo
{
    [self biSaiGuanLiQuery];
    [_tableView reloadData];
}

#pragma mark-
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*str=@"BiSaiCell";
    BiSaiCell*cell=[tableView dequeueReusableCellWithIdentifier:str];
    
    if (!cell) {
        cell=[[BiSaiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    //7.1.1孵化成长管理->日常活跃度管理->比赛管理查询
    /*
     响应 	响应数据为array；如下格式
     [{"id":"5937dbe5075910c2d60d07c6","name"
     :"上海市创新创业大赛","competeLevel":"省部级比赛","prizeAwarded":"一等奖","hornerName":"********","orgnizationUnit":""
     ,"date":"2017-06-07 10:56:37","ownerCompetition":"是","score":14,"company":"云创智能科技有限公司"}]
     */

    
    NSDictionary*dic=[_array objectAtIndex:indexPath.row];
    
    cell.bisaiName.text= [dic objectForKey:@"name"];
    cell.bisaiLevel.text=[dic objectForKey:@"competeLevel"];
    cell.mingCi.text=[dic objectForKey:@"prizeAwarded"];
    cell.rongyuMingCheng.text=[dic objectForKey:@"hornerName"];
    cell.zuzhiDanWei.text=[dic objectForKey:@"orgnizationUnit"];
    cell.faqiDate.text=[dic objectForKey:@"date"];
    cell.benYuanQuzuzhi.text=[dic objectForKey:@"ownerCompetition"];
    cell.suoShuCompany.text=[dic objectForKey:@"company"];
   
    
    return cell;
}

//删除比赛事件处理
- (IBAction)deleteBtnClicked:(id)sender forEvent:(UIEvent *)event {
    
   NSSet*touches= [event allTouches];
    
   UITouch*touch=[touches anyObject];
    
   CGPoint point=[touch locationInView:_tableView];
    
   NSIndexPath *indexPath=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_array objectAtIndex:indexPath.row];
    NSString*strID=[dic objectForKey:@"id"];
    
    [self biSaiGuanLiDelete:strID];
    

}

//7.1.3孵化成长管理->日常活跃度管理->比赛管理删除
-(void)biSaiGuanLiDelete:(NSString*)ids
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@?ids=%@",baseurl,@"/competition/batchdelete",ids];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* headers=[(NSHTTPURLResponse*)task.response allHeaderFields];
        NSString* contenttype=[headers objectForKey:@"Content-Type"];
        NSString* data= [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSLog(@"%@",data);
        if([contenttype containsString:@"json"]){//返回json格式数据
            NSDictionary* jsondata=(NSDictionary*) [data objectFromJSONString];
            int result=[((NSNumber*)[jsondata objectForKey:@"result"]) intValue];
            NSLog(@"%d",result);
            //result: 1,删除成功 不等于1,失败
            
            [self biSaiGuanLiQuery];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


//下载比赛事件的处理，进入当前比赛事件的凭证图片
- (IBAction)DownloadBtnClicked:(id)sender forEvent:(UIEvent *)event {
    
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableView];
    
    NSIndexPath *indexPath=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_array objectAtIndex:indexPath.row];
    NSString*strID=[dic objectForKey:@"id"];
    
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"RiChangHuoYue" bundle:nil];
    bisaiPhotoVC*vc=[board instantiateViewControllerWithIdentifier:@"bisaiPhotoVC"];
    [vc ReceiveShuJuPhoto:strID];
    [self.navigationController pushViewController:vc animated:YES];

}


@end

//
//  ChanXueYanGuanLiVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/31.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "ChanXueYanGuanLiVC.h"
#import "ChanXueYanGuanLiCell.h"
#import "AddChanXueYanVC.h"
#import "BussinessApi.h"
@interface ChanXueYanGuanLiVC ()

@end

@implementation ChanXueYanGuanLiVC

-(void)ReceiveShuJu
{
    _array=[NSArray array];
    
    [self chanXueYanQuery];
}
// 网络请求，查询数据方法

-(void) chanXueYanQuery
{
    NSString* baseurl=@"http://116.228.176.34:9002/chuangke-serve";
    AFHTTPSessionManager* manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    NSString* url=[NSString stringWithFormat:@"%@%@",baseurl,@"/cooperatorunitInfo/search?start=0&length=1000"];
    
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
            
            _array=[NSArray arrayWithArray:result];
            [_tableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}





- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title=@"产学研管理";
    
    UIBarButtonItem*RightBarItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(RightBarItemClick:)];
    
    [self.navigationItem setRightBarButtonItem:RightBarItem];
    
}

//左边添加比赛事件
-(void)RightBarItemClick:(UIBarButtonItem*)item
{
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"RiChangHuoYue" bundle:nil];
    AddChanXueYanVC*vc=[board instantiateViewControllerWithIdentifier:@"AddChanXueYanVC"];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveInfomation) name:@"ADDCHANYEXUESCUUESS" object:nil];
}

-(void)receiveInfomation
{
    
    [self chanXueYanQuery];
    [_tableView reloadData];
}

#pragma mark-
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*str=@"ChanXueYanGuanLiCell";
    ChanXueYanGuanLiCell*cell=[tableView dequeueReusableCellWithIdentifier:str];
    
    if (!cell) {
        cell=[[ChanXueYanGuanLiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    //7.2.1 产学研管理查询
    /*
     响应 [{"id":"5938cb27075910c2d60d07dd","name"
     :"111","money":3000.0,"effect":"","date":"2017-06-08 03:57:27","company":"云创智能科技有限公司"},{"id":"5938cb08075910c2d60d07db"
     ,"name":"*****","money":2.0,"effect":"","date":"2017-06-08 03:56:56","company":"云创智能科技有限公司"}]
     */
    
    
    NSDictionary*dic=[_array objectAtIndex:indexPath.row];
        
    cell.hezuoJiGouName.text=[dic objectForKey:@"name"];
    
    NSNumber* money= [dic objectForKey:@"money"];

    cell.hezuoJine.text=[NSString stringWithFormat:@"%@",money];
    
              cell.hezuoXiaoGuo.text=[dic objectForKey:@"effect"];
    cell.suoshuGongSi.text=[dic objectForKey:@"company"];
    
    
    return cell;
}





- (IBAction)DeleteChanXueBtn:(id)sender forEvent:(UIEvent *)event {
    
    
}

- (IBAction)DownloadChanXueBtn:(id)sender forEvent:(UIEvent *)event {
    
    
}









@end

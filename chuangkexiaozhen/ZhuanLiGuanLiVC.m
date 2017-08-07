//
//  ZhuanLiGuanLiVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/3.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "ZhuanLiGuanLiVC.h"
#import "ZhuanLiGuanLiCell.h"
#import "ZhuanLiPhotoVC.h"
#import "AddZhuanLiVC.h"
@interface ZhuanLiGuanLiVC ()

@end

@implementation ZhuanLiGuanLiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _api=[[BussinessApi alloc]init];
    _api.delegate=self;
    [_api zhuanYeZhiShiQuery];//查询数据
    
    _ary=[NSArray array];
    
    self.navigationItem.title=@"专利知识管理";
    
    UIBarButtonItem*RightBarItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(RightBarItemClick:)];
    
    [self.navigationItem setRightBarButtonItem:RightBarItem];
}

//查询数据里面的委托代理
-(void)loadNetworkFinished:(id)data
{
    
    if ( data !=nil)
    {
        _ary=(NSArray*)data;
    }
    
    [_tableView reloadData];
}



//左边添加比赛事件
-(void)RightBarItemClick:(UIBarButtonItem*)item
{
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"KeJiChuanXin" bundle:nil];
    AddZhuanLiVC*vc=[board instantiateViewControllerWithIdentifier:@"AddZhuanLiVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"%s",__func__);
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveInfomation) name:@"ADDZHUANLISCUUESS" object:nil];
    NSLog(@"%s",__func__);
}

-(void)receiveInfomation
{
    NSLog(@"%s",__func__);
    [_api zhuanYeZhiShiQuery];//查询数据
    NSLog(@"%s",__func__);
}

#pragma mark
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_ary.count==0) {
        return 0;
    }
    return _ary.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*str=@"ZhuanLiGuanLiCell";
    
    ZhuanLiGuanLiCell*cell=[tableView dequeueReusableCellWithIdentifier:str];
    
    if (!cell) {
        cell=[[ZhuanLiGuanLiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    /*
     7.4.1 专业知识产权查询
     请求 get http://116.228.176.34:9002/chuangke-serve/knowledge/search?start=0&length=1000
     响应 [{"id":"5937e243075910c2d60d07c8","name"
     :"********","code":"********","type":"软件著作权","date":"2017-06-07 19:23:47","company":"云创智能科技有限公司"}]
     */
    
    NSDictionary*dic= [_ary objectAtIndex:indexPath.row];
    
    cell.name.text=[dic objectForKey:@"name"];
    cell.bianMa.text=[dic objectForKey:@"code"];
    cell.leiXing.text=[dic objectForKey:@"type"];
    cell.shiJian.text=[dic objectForKey:@"date"];
    cell.gongSi.text=[dic objectForKey:@"company"];
    
    return cell;
}

- (IBAction)FirstPageDelect:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableView];
    
    NSIndexPath *indexPath=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_ary objectAtIndex:indexPath.row];
    NSString*strID=[dic objectForKey:@"id"];
    
    
    [_api zhuanYeZhiShiDelete:strID];
    
    
}
//api的第一页删除的代理
-(void)deleteData:(id)data
{
    NSNumber*num=(id)data;
    
    int result=[num intValue];
    
    if (result==1) {
        
        [_api zhuanYeZhiShiQuery];
    }
}

- (IBAction)FirstPageDownload:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableView];
    
    NSIndexPath *indexPath=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_ary objectAtIndex:indexPath.row];
    NSString*strID=[dic objectForKey:@"id"];
    
    
//    UIStoryboard*board=[UIStoryboard storyboardWithName:@"KeJiChuanXin" bundle:nil];
//    ZhuanLiPhotoVC*vc=[board instantiateViewControllerWithIdentifier:@"ZhuanLiPhotoVC"];
//    [vc ReceiveShuJuPhoto:strID];
//    [self.navigationController pushViewController:vc animated:YES];

    FilelistViewController*vc=[[FilelistViewController alloc]initView:strID withType:@"8"];
    [self.navigationController pushViewController:vc animated:YES];


}



@end

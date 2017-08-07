//
//  JiangLiGuanLiVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/3.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "JiangLiGuanLiVC.h"

@interface JiangLiGuanLiVC ()

@end

@implementation JiangLiGuanLiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _api=[[BussinessApi alloc]init];
    _api.delegate=self;
    [_api jiangLiQuery];//查询数据
    
    _ary=[NSArray array];
    
    self.navigationItem.title=@"奖励管理";
    
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
    AddJiangLiVC*vc=[board instantiateViewControllerWithIdentifier:@"AddJiangLiVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveInfomation) name:@"ADDJIANGLISCUUESS" object:nil];
}

-(void)receiveInfomation
{
    [_api jiangLiQuery];//查询数据
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
    static NSString*str=@"JiangLiGuanLiCell";
    
    JiangLiGuanLiCell*cell=[tableView dequeueReusableCellWithIdentifier:str];
    
    if (!cell) {
        cell=[[JiangLiGuanLiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    /*
     
     7.6.1 奖励管理查询
     请求 get http://116.228.176.34:9002/chuangke-serve/award/search?start=0&length=1000
     响应 [{"id":"5938e5ec075910c2d60d07e2","name"
     :"******","awardLevel":"一级奖励","awardunit":"******","code":"******","date":"2017-06-08 13:51:40","company"
     :"云创智能科技有限公司"}]
     */
    
    NSDictionary*dic= [_ary objectAtIndex:indexPath.row];
    
    cell.name.text=[dic objectForKey:@"name"];
    cell.level.text=[dic objectForKey:@"awardLevel"];
    cell.danWei.text=[dic objectForKey:@"awardunit"];
    cell.biHao.text=[dic objectForKey:@"code"];
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
    
    
    [_api jiangLiDelete:strID];
    
    
}
//api的第一页删除的代理
-(void)deleteData:(id)data
{
    NSNumber*num=(id)data;
    
    int result=[num intValue];
    
    if (result==1) {
        
        [_api jiangLiQuery];
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
//    JiangLiPhotoVC*vc=[board instantiateViewControllerWithIdentifier:@"JiangLiPhotoVC"];
//    [vc ReceiveShuJuPhoto:strID];
//    [self.navigationController pushViewController:vc animated:YES];
    
    
    FilelistViewController*vc=[[FilelistViewController alloc]initView:strID withType:@"10"];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end

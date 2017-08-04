//
//  NaShuiGuanLiVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/4.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "NaShuiGuanLiVC.h"

@interface NaShuiGuanLiVC ()

@end

@implementation NaShuiGuanLiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     _ary=[NSArray array];
    _FuHua=[[FuHusChengZhangGuanLi alloc]init];
    _FuHua.delegate=self;
    
    [_FuHua NaShuiGuanLiQuery];//查询数据
    
    self.navigationItem.title=@"纳税管理";
    
    UIBarButtonItem*RightBarItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(RightBarItemClick:)];
    
    [self.navigationItem setRightBarButtonItem:RightBarItem];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveInfomation) name:@"ADDNASHUISCUUESS" object:nil];
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
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"ShiChangXiaoShou" bundle:nil];
    AddNaShuiVC*vc=[board instantiateViewControllerWithIdentifier:@"AddNaShuiVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

}

-(void)receiveInfomation
{
    [_FuHua NaShuiGuanLiQuery];//查询数据
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
    static NSString*str=@"NaShuiGuanLiCell";
    
    NaShuiGuanLiCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    
    if (!cell) {
        cell=[[NaShuiGuanLiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    /*
     纳税管理
     7.8.1 纳税管理查询
     请求 get http://116.228.176.34:9002/chuangke-serve/market/tax/search?start=0&length=1000
     响应： [{"id":"5938ee2e075910c2d60d07e7","dateType"
     :"纳税年度级别","taxPrice":4000.0,"taxType":"国税","taxResourceIds":[],"taxTarget":"金山区枫泾镇国税局","tenantName":"
     云创智能科技有限公司"}]
     */
    
    NSDictionary*dic= [_ary objectAtIndex:indexPath.row];
    
    cell.gongSi.text=[dic objectNotNullForKey:@"tenantName"];
    cell.shiJianFangshi.text=[dic objectNotNullForKey:@"dateType"];
    cell.jinE.text=[dic objectNotNullForKey:@"taxPrice"];
    cell.leiBie.text=[dic objectNotNullForKey:@"taxType"];
    cell.duiXiang.text=[dic objectNotNullForKey:@"taxTarget"];
    
    
    return cell;
}

- (IBAction)FirstPageDelect:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableView];
    
    NSIndexPath *indexPath=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_ary objectAtIndex:indexPath.row];
    NSString*strID=[dic objectForKey:@"id"];
    
    
    [_FuHua NaShuiGuanLiDelete:strID];
    
    
}
//api的第一页删除的代理
-(void)deleteData:(id)data
{
    NSNumber*num=(id)data;
    
    int result=[num intValue];
    
    if (result==1) {
        
        [_FuHua NaShuiGuanLiQuery];
    }
}

- (IBAction)FirstPageDownload:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableView];
    
    NSIndexPath *indexPath=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_ary objectAtIndex:indexPath.row];
    NSString*strID=[dic objectForKey:@"id"];
    
    
    FilelistViewController* filelist=[[FilelistViewController alloc] initView:strID withType:@"12"];
    [self.navigationController pushViewController:filelist animated:YES];
    
}

@end

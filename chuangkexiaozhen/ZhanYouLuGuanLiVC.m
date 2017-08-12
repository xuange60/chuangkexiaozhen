//
//  ZhanYouLuGuanLiVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/4.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "ZhanYouLuGuanLiVC.h"

@interface ZhanYouLuGuanLiVC ()

@end

@implementation ZhanYouLuGuanLiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _ary=[NSArray array];
    _FuHua=[[FuHusChengZhangGuanLi alloc]init];
    _FuHua.delegate=self;
    _jiafencailiaoshenhe=[[JiaFenCaiLiaoShenHe alloc] init];
    _jiafencailiaoshenhe.delegate=self;
    [self query];//查询数据
    
    self.navigationItem.title=@"市场占有率管理";
    UIImage *rightButtonIcon = [[UIImage imageNamed:@"add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *RightBarItem = [[UIBarButtonItem alloc] initWithImage:rightButtonIcon
                                                                     style:UIBarButtonItemStylePlain target:self action:@selector(RightBarItemClick:)];
    /*
    UIBarButtonItem*RightBarItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(RightBarItemClick:)];
    */
    [self.navigationItem setRightBarButtonItem:RightBarItem];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveInfomation) name:@"ADDSHICHANGZHANYOUSCUUESS" object:nil];
}


-(void)query
{
    if([_isadmin isEqualToString:@"Y"])
    {
        [_jiafencailiaoshenhe jiaFenCaiLiaoQuerywithAdmin:@"market/market"];
    }else{
        [_FuHua ShiChangZhanYouQuery];
    }
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
    AddZhanYouLuVC*vc=[board instantiateViewControllerWithIdentifier:@"AddZhanYouLuVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

-(void)receiveInfomation
{
   [self query];//查询数据
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
    static NSString*str=@"ZhanYouLuGuanLiCell";
    
    ZhanYouLuGuanLiCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    
    if (!cell) {
        cell=[[ZhanYouLuGuanLiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    /*
     市场占有率
     7.9.1 市场占有率查询
     请求 get http://116.228.176.34:9002/chuangke-serve/market/market/search?start=0&length=1000
     响应 [{"id":"5938edcc075910c2d60d07e6","marketPercent"
     :"5.0%","marketDetail":"共享经济-单车出租","organizationName":"零点咨询","investigateResourceIds":[],"tenantName"
     :"云创智能科技有限公司"}]*/
    
    NSDictionary*dic= [_ary objectAtIndex:indexPath.row];
    
    cell.gongSi.text=[dic objectNotNullForKey:@"tenantName"];
    cell.zhanYouLu.text=[dic objectNotNullForKey:@"marketPercent"];
    cell.shiChang.text=[dic objectNotNullForKey:@"marketDetail"];
    cell.jiGou.text=[dic objectNotNullForKey:@"organizationName"];
    
    return cell;
}

- (IBAction)FirstPageDelect:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableView];
    
    NSIndexPath *indexPath=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_ary objectAtIndex:indexPath.row];
    NSString*strID=[dic objectForKey:@"id"];
    
    
    [_FuHua ShiChangZhanYouDelete:strID];
    
    
}
//api的第一页删除的代理
-(void)deleteData:(id)data
{
    NSNumber*num=(id)data;
    
    int result=[num intValue];
    
    if (result==1) {
        
        [self query];
    }
}

- (IBAction)FirstPageDownload:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableView];
    
    NSIndexPath *indexPath=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_ary objectAtIndex:indexPath.row];
    NSString*strID=[dic objectForKey:@"id"];
    
    
    FilelistViewController* filelist=[[FilelistViewController alloc] initView:strID withType:@"13"];
    [self.navigationController pushViewController:filelist animated:YES];
    
}


- (IBAction)detailquery:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableView];
    
    NSIndexPath *indexPath=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_ary objectAtIndex:indexPath.row];
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"jiafencailiaoshenhe" bundle:nil];
    ShiChangZhanYouLvDetailVC*vc=[board instantiateViewControllerWithIdentifier:@"ShiChangZhanYouLvDetailVC"];
    vc.isadmin=_isadmin;
    vc.data=dic;
    vc.navigationItem.title=@"详情";
    [self.navigationController pushViewController:vc animated:YES];
    
}





@end

//
//  HeTongGuanLiVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/4.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "HeTongGuanLiVC.h"
#import "FuHusChengZhangGuanLi.h"
#import "HeTongGuanLiCell.h"
@interface HeTongGuanLiVC ()

@end

@implementation HeTongGuanLiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _ary=[NSArray array];
    _FuHua=[[FuHusChengZhangGuanLi alloc]init];
    _FuHua.delegate=self;
    _jiafencailiaoshenhe=[[JiaFenCaiLiaoShenHe alloc] init];
    _jiafencailiaoshenhe.delegate=self;
    [self query];//查询数据
    

    
    self.navigationItem.title=@"销售合同管理";
    UIImage *rightButtonIcon = [[UIImage imageNamed:@"add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *RightBarItem = [[UIBarButtonItem alloc] initWithImage:rightButtonIcon
                                                                     style:UIBarButtonItemStylePlain target:self action:@selector(RightBarItemClick:)];
    /*
    UIBarButtonItem*RightBarItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(RightBarItemClick:)];
    */
    [self.navigationItem setRightBarButtonItem:RightBarItem];
}

-(void)query
{
    if([_isadmin isEqualToString:@"Y"])
    {
        [_jiafencailiaoshenhe jiaFenCaiLiaoQuerywithAdmin:@"market/sale"];
    }else{
        [_FuHua XiaoShouHeTongQuery];
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
    AddHeTongVC*vc=[board instantiateViewControllerWithIdentifier:@"AddHeTongVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"%s",__func__);
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveInfomation) name:@"ADDHETONGSUCCESS" object:nil];
    NSLog(@"%s",__func__);
}

-(void)receiveInfomation
{
    NSLog(@"%s",__func__);
    [self query];
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
    static NSString*str=@"HeTongGuanLiCell";
    
     HeTongGuanLiCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    
    if (!cell) {
        cell=[[HeTongGuanLiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    /*
     销售合同管理
     7.7.1 销售合同查询
     请求 get http://116.228.176.34:9002/chuangke-serve/market/sale/search?start=0&length=1000
     响应：
     [{"id":"59807c6880ab5e6790d536bf","pactName"
     :"32112","partnerLevel":"一级合作方","partnerPrice":2000.0,"benefitPrice":1.2321312E7,"tenantName":"云创智能科
     技有限公司"},{"id":"594b6f3a075910c2d60d08e6","pactName":"******","partnerLevel":"一级合作方","partnerPrice":5
     .0,"benefitPrice":1.0,"tenantName":"云创智能科技有限公司"}]
     */
    
    NSDictionary*dic= [_ary objectAtIndex:indexPath.row];
    
     cell.gongSi.text=[dic objectNotNullForKey:@"tenantName"];
     cell.name.text=[dic objectNotNullForKey:@"pactName"];
     cell.level.text=[dic objectNotNullForKey:@"partnerLevel"];
    
     cell.JinE.text=[dic objectNotNullForKey:@"partnerPrice"];
     cell.XiaoYi.text=[dic objectNotNullForKey:@"benefitPrice"];
    return cell;
}

- (IBAction)FirstPageDelect:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableView];
    
    NSIndexPath *indexPath=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_ary objectAtIndex:indexPath.row];
    NSString*strID=[dic objectNotNullForKey:@"id"];
    
    
    [_FuHua XiaoShouHeTongDelete:strID];
    
    
}
//api的第一页删除的代理
-(void)deleteData:(id)data
{
    NSNumber*num=(id)data;
    
    int result=[num intValue];
    
    if (result==1) {
        [self tiShiKuangDisplay:deleteStr viewController:self];
        [self query];
    }
}

- (IBAction)FirstPageDownload:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableView];
    
    NSIndexPath *indexPath=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_ary objectAtIndex:indexPath.row];
    NSString*strID=[dic objectNotNullForKey:@"id"];
    
    
    FilelistViewController* filelist=[[FilelistViewController alloc] initView:strID withType:@"11"];
    [self.navigationController pushViewController:filelist animated:YES];

}


- (IBAction)detailquery:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableView];
    
    NSIndexPath *indexPath=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_ary objectAtIndex:indexPath.row];
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"jiafencailiaoshenhe" bundle:nil];
    XiaoShouHeTongDetailVC*vc=[board instantiateViewControllerWithIdentifier:@"XiaoShouHeTongDetailVC"];
    vc.isadmin=_isadmin;
    vc.data=dic;
    vc.navigationItem.title=@"详情";
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end

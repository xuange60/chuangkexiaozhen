//
//  XiangMuGuanLiVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/3.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "XiangMuGuanLiVC.h"
#import "AddXiangMuVC.h"
#import "XiangMuGuanLiCell.h"

@interface XiangMuGuanLiVC ()

@end

@implementation XiangMuGuanLiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _api=[[BussinessApi alloc]init];
    _api.delegate=self;
    
    //modify
    _jiafencailiaoshenhe=[[JiaFenCaiLiaoShenHe alloc] init];
    _jiafencailiaoshenhe.delegate=self;
    
    
    [self query];//查询数据
    
    _ary=[NSArray array];
    
    self.navigationItem.title=@"项目管理";
    
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
        [_jiafencailiaoshenhe jiaFenCaiLiaoQuerywithAdmin:@"project"];
    }else{
        [_api xiangMuQuery];
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
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"KeJiChuanXin" bundle:nil];
    AddXiangMuVC*vc=[board instantiateViewControllerWithIdentifier:@"AddXiangMuVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveInfomation) name:@"ADDXIANGMUSCUUESS" object:nil];
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
    static NSString*str=@"XiangMuGuanLiCell";
    
    XiangMuGuanLiCell*cell=[tableView dequeueReusableCellWithIdentifier:str];
    
    if (!cell) {
        cell=[[XiangMuGuanLiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    /*
     7.5.1 项目管理查询
     请求 get http://116.228.176.34:9002/chuangke-serve/project/search?start=0&length=1000
     响应 [{"id":"5938e5d9075910c2d60d07e1","name"
     :"******","projectLevel":"国家级","competentunit":"******","code":"******","company":"云创智能科技有限公司","date"
     :"2017-06-08 13:51:21"}]
     */
    
    NSDictionary*dic= [_ary objectAtIndex:indexPath.row];
    
    cell.name.text=[dic objectNotNullForKey:@"name"];
    cell.level.text=[dic objectNotNullForKey:@"projectLevel"];
    cell.danWei.text=[dic objectNotNullForKey:@"competentunit"];
    cell.biHao.text=[dic objectNotNullForKey:@"code"];
    cell.shiJian.text=[dic objectNotNullForKey:@"date"];
    cell.gongSi.text=[dic objectNotNullForKey:@"company"];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

- (IBAction)FirstPageDelect:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableView];
    
    NSIndexPath *indexPath=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_ary objectAtIndex:indexPath.row];
    NSString*strID=[dic objectNotNullForKey:@"id"];
    
    
    [_api xiangMuDelete:strID];
    
    
}
//api的第一页删除的代理
-(void)deleteData:(id)data
{
    NSNumber*num=(id)data;
    
    int result=[num intValue];
    
    if (result==1) {
        
        [self query];//查询数据

    }
}

- (IBAction)FirstPageDownload:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableView];
    
    NSIndexPath *indexPath=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_ary objectAtIndex:indexPath.row];
    NSString*strID=[dic objectNotNullForKey:@"id"];
    
    
//    UIStoryboard*board=[UIStoryboard storyboardWithName:@"KeJiChuanXin" bundle:nil];
//    XiangMuPhotoVC*vc=[board instantiateViewControllerWithIdentifier:@"XiangMuPhotoVC"];
//    [vc ReceiveShuJuPhoto:strID];
//    [self.navigationController pushViewController:vc animated:YES];
    
    FilelistViewController*vc=[[FilelistViewController alloc]initView:strID withType:@"9"];
    [self.navigationController pushViewController:vc animated:YES];
    
}



- (IBAction)detailquery:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableView];
    
    NSIndexPath *indexPath=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_ary objectAtIndex:indexPath.row];
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"jiafencailiaoshenhe" bundle:nil];
    XiangMuGuanLiDetailVC*vc=[board instantiateViewControllerWithIdentifier:@"XiangMuGuanLiDetailVC"];
    vc.isadmin=_isadmin;
    vc.data=dic;
    vc.navigationItem.title=@"详情";
    [self.navigationController pushViewController:vc animated:YES];
    
    
}






@end

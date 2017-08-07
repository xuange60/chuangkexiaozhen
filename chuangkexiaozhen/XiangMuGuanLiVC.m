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
    [_api xiangMuQuery];//查询数据
    
    _ary=[NSArray array];
    
    self.navigationItem.title=@"项目管理";
    
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
    [_api xiangMuQuery];//查询数据
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
    
    cell.name.text=[dic objectForKey:@"name"];
    cell.level.text=[dic objectForKey:@"projectLevel"];
    cell.danWei.text=[dic objectForKey:@"competentunit"];
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
    
    
    [_api xiangMuDelete:strID];
    
    
}
//api的第一页删除的代理
-(void)deleteData:(id)data
{
    NSNumber*num=(id)data;
    
    int result=[num intValue];
    
    if (result==1) {
        
        [_api xiangMuQuery];
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
//    XiangMuPhotoVC*vc=[board instantiateViewControllerWithIdentifier:@"XiangMuPhotoVC"];
//    [vc ReceiveShuJuPhoto:strID];
//    [self.navigationController pushViewController:vc animated:YES];
    
    FilelistViewController*vc=[[FilelistViewController alloc]initView:strID withType:@"9"];
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end

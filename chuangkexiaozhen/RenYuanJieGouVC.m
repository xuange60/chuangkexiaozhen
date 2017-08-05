//
//  RenYuanJieGouVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/5.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "RenYuanJieGouVC.h"

@interface RenYuanJieGouVC ()

@end

@implementation RenYuanJieGouVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _ary=[NSArray array];
    _FuHua=[[FuHusChengZhangGuanLi alloc]init];
    _FuHua.delegate=self;
    
    [_FuHua RenYuanJieGouQuery];//查询数据
    
    self.navigationItem.title=@"人员结构管理";
    
    UIBarButtonItem*RightBarItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(RightBarItemClick:)];
    
    [self.navigationItem setRightBarButtonItem:RightBarItem];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveInfomation) name:@"ADDRENYUANJIEGOUSCUUESS" object:nil];
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
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"TuanDuiYunYing" bundle:nil];
    AddRenYuanVC*vc=[board instantiateViewControllerWithIdentifier:@"AddRenYuanVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

-(void)receiveInfomation
{
    [_FuHua RenYuanJieGouQuery];//查询数据
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
    static NSString*str=@"RenYuanJieGouCell";
    
    RenYuanJieGouCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    
    if (!cell) {
        cell=[[RenYuanJieGouCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    /*
     7.10.1 人员结构查询
     请求 get http://116.228.176.34:9002/chuangke-serve/personaldistribution/search?start=0&length=1000
     响应 [{"id":"5938f21c075910c2d60d07ed","toltalPerson"
     :3,"marketPerson":1,"marketPersonPercent":"33.33%","techniquePerson":1,"techniquePersonPercent":"33.33
     %","operatePerson":1,"operatePersonPercent":"33.33%","company":"云创智能科技有限公司"}]*/
    
    NSDictionary*dic= [_ary objectAtIndex:indexPath.row];
    
    cell.totalNum.text=[dic objectNotNullForKey:@"toltalPerson"];
    cell.ShiChangNum.text=[dic objectNotNullForKey:@"marketPerson"];
    cell.ShiChangPercent.text=[dic objectNotNullForKey:@"marketPersonPercent"];
    cell.JiShuNum.text=[dic objectNotNullForKey:@"techniquePerson"];
    cell.JiShuPercent.text=[dic objectNotNullForKey:@"techniquePersonPercent"];
    cell.YunYingNum.text=[dic objectNotNullForKey:@"operatePerson"];
    cell.YunYingPercent.text=[dic objectNotNullForKey:@"operatePersonPercent"];
    cell.SuoShuCompany.text=[dic objectNotNullForKey:@"company"];
    

    return cell;
}

- (IBAction)FirstPageDelect:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableView];
    
    NSIndexPath *indexPath=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_ary objectAtIndex:indexPath.row];
    NSString*strID=[dic objectForKey:@"id"];
    
    
    [_FuHua RenYuanJieGouDelete:strID];
    
    
}
//api的第一页删除的代理
-(void)deleteData:(id)data
{
    NSNumber*num=(id)data;
    
    int result=[num intValue];
    
    if (result==1) {
        
        [_FuHua RenYuanJieGouQuery];
    }
}

- (IBAction)FirstPageDownload:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableView];
    
    NSIndexPath *indexPath=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_ary objectAtIndex:indexPath.row];
    NSString*strID=[dic objectForKey:@"id"];
    
    
    FilelistViewController* filelist=[[FilelistViewController alloc] initView:strID withType:@"21"];
    [self.navigationController pushViewController:filelist animated:YES];
    
}

@end

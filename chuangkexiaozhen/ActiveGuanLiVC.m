//
//  ActiveGuanLiVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/1.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "ActiveGuanLiVC.h"

@interface ActiveGuanLiVC ()

@end

@implementation ActiveGuanLiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
      _ary=[NSArray array];
    
    
    _api=[[BussinessApi alloc]init];
    _api.delegate=self;
    [_api huoDongQueryNew];//查询数据
   

    self.navigationItem.title=@"活动管理";
    
    UIBarButtonItem*RightBarItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(RightBarItemClick:)];
    [self.navigationItem setRightBarButtonItem:RightBarItem];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveInfomation) name:@"ADDACTIVESCUUESS" object:nil];
}

-(void)receiveInfomation
{
    [_api huoDongQueryNew];//查询数据
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
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"RiChangHuoYue" bundle:nil];
    AddActiveVC*vc=[board instantiateViewControllerWithIdentifier:@"AddActiveVC"];
    [self.navigationController pushViewController:vc animated:YES];
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
    static NSString*str=@"ActiveGuanLiCell";
    
    ActiveGuanLiCell*cell=[tableView dequeueReusableCellWithIdentifier:str];
    
    if (!cell) {
        cell=[[ActiveGuanLiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    /*
     7.3.1 活动查询
     请求：get http://116.228.176.34:9002/chuangke-serve/activity/search?start=0&length=1000
     响应： [{"id":"5938cd4b075910c2d60d07de","name"
     :"******","activityLevel":"省市级活动","sponsor":"科创小镇","participant":3,"ownerActivity":"否","company":"云创
     智能科技有限公司","date":"2017-06-08 04:06:35"}]
     */

    
    NSDictionary*dic= [_ary objectAtIndex:indexPath.row];
    
    cell.activeName.text=[dic objectForKey:@"name"];
    cell.activeLevel.text=[dic objectForKey:@"activityLevel"];
    cell.danWei.text=[dic objectForKey:@"sponsor"];
    
    NSNumber*num=[dic objectForKey:@"participant"];
    cell.renShu.text=[NSString stringWithFormat:@"%@",num];
    cell.benYuanQu.text=[dic objectForKey:@"ownerActivity"];
    cell.company.text=[dic objectForKey:@"company"];
    
    return cell;
}


- (IBAction)ActiveDeleteCkick:(id)sender forEvent:(UIEvent *)event {
    
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableView];
    
    NSIndexPath *indexPath=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_ary objectAtIndex:indexPath.row];
    NSString*strID=[dic objectForKey:@"id"];
    
    
    [_api huoDongDeleteNew:strID];

}
//api的第一页删除的代理
-(void)deleteData:(id)data
{
    NSNumber*num=(id)data;
    
    int result=[num intValue];
    
    if (result==1) {
        
        [_api huoDongQueryNew];
    }
}


- (IBAction)ActiveDownloadClick:(id)sender forEvent:(UIEvent *)event {
    
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableView];
    
    NSIndexPath *indexPath=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_ary objectAtIndex:indexPath.row];
    NSString*strID=[dic objectForKey:@"id"];
    
    
    FilelistViewController*vc=[[FilelistViewController alloc]initView:strID withType:@"7"];
    [self.navigationController pushViewController:vc animated:YES];
}







@end

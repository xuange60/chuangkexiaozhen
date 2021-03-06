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
    
    _jiafencailiaoshenhe=[[JiaFenCaiLiaoShenHe alloc] init];
    _jiafencailiaoshenhe.delegate=self;
    [self query];//查询数据
   
    
    self.navigationItem.title=@"活动管理";
    UIImage *rightButtonIcon = [[UIImage imageNamed:@"add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *RightBarItem = [[UIBarButtonItem alloc] initWithImage:rightButtonIcon
                                                                     style:UIBarButtonItemStylePlain target:self action:@selector(RightBarItemClick:)];
    /*
    UIBarButtonItem*RightBarItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(RightBarItemClick:)];
    */
     [self.navigationItem setRightBarButtonItem:RightBarItem];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveInfomation) name:@"ADDACTIVESCUUESS" object:nil];
}

-(void)receiveInfomation
{
    [self query];//查询数据
}

-(void) query
{
    if([_isadmin isEqualToString:@"Y"])
    {
        [_jiafencailiaoshenhe jiaFenCaiLiaoQuerywithAdmin:@"activity"];
    }else{
        [_api huoDongQueryNew];
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
    
    cell.activeName.text=[dic objectNotNullForKey:@"name"];
    cell.activeLevel.text=[dic objectNotNullForKey:@"activityLevel"];
    cell.danWei.text=[dic objectNotNullForKey:@"sponsor"];
    

    cell.renShu.text=[dic objectNotNullForKey:@"participant"];
    cell.benYuanQu.text=[dic objectNotNullForKey:@"ownerActivity"];
    cell.company.text=[dic objectNotNullForKey:@"company"];
    
     [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}


- (IBAction)ActiveDeleteCkick:(id)sender forEvent:(UIEvent *)event {
    
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableView];
    
    NSIndexPath *indexPath=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_ary objectAtIndex:indexPath.row];
    NSString*strID=[dic objectNotNullForKey:@"id"];
    
    UIAlertController*alertCon=[UIAlertController alertControllerWithTitle:nil message:@"请确认是否删除？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction*action1=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction*action2=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [_api huoDongDeleteNew:strID];
    }];
    
    [alertCon addAction:action1];
    [alertCon addAction:action2];
    
    [self presentViewController:alertCon animated:YES completion:nil];
    
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




- (IBAction)detail:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableView];
    
    NSIndexPath *indexPath=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_ary objectAtIndex:indexPath.row];
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"jiafencailiaoshenhe" bundle:nil];
    HuoDongGuanLiDetailVC*vc=[board instantiateViewControllerWithIdentifier:@"HuoDongGuanLiDetailVC"];
    vc.isadmin=_isadmin;
    vc.data=dic;
    vc.navigationItem.title=@"详情";
    [self.navigationController pushViewController:vc animated:YES];
    
}






@end

//
//  ChanXueYanGuanLiVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/31.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "ChanXueYanGuanLiVC.h"
#import "ChanXueYanGuanLiCell.h"
#import "AddChanXueYanVC.h"
#import "BussinessApi.h"
@interface ChanXueYanGuanLiVC ()

@end

@implementation ChanXueYanGuanLiVC

-(void)ReceiveShuJu
{
    _array=[NSArray array];
    
    _api=[[BussinessApi alloc]init];
    _api.delegate=self;
    
    _jiafencailiaoshenhe=[[JiaFenCaiLiaoShenHe alloc] init];
    _jiafencailiaoshenhe.delegate=self;
    
    [self query];
}

-(void)loadNetworkFinished:(id)data
{
    _array=[NSArray arrayWithArray:(NSArray*)data];
    [_tableView reloadData];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title=@"产学研管理";
    
    UIImage *rightButtonIcon = [[UIImage imageNamed:@"add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *RightBarItem = [[UIBarButtonItem alloc] initWithImage:rightButtonIcon
                                                                     style:UIBarButtonItemStylePlain target:self action:@selector(RightBarItemClick:)];
    /*
    UIBarButtonItem*RightBarItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(RightBarItemClick:)];
   */
     [self.navigationItem setRightBarButtonItem:RightBarItem];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveInfomation) name:@"ADDCHANYEXUESCUUESS" object:nil];
}

-(void)receiveInfomation
{
    [self query];
}

-(void) query
{
    if([_isadmin isEqualToString:@"Y"])
    {
        [_jiafencailiaoshenhe chanXueYanQueryWithAdmin];
    }else{
        [_api chanXueYanQuery];
    }
}

//左边添加比赛事件
-(void)RightBarItemClick:(UIBarButtonItem*)item
{
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"RiChangHuoYue" bundle:nil];
    AddChanXueYanVC*vc=[board instantiateViewControllerWithIdentifier:@"AddChanXueYanVC"];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark-
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*str=@"ChanXueYanGuanLiCell";
    ChanXueYanGuanLiCell*cell=[tableView dequeueReusableCellWithIdentifier:str];
    
    if (!cell) {
        cell=[[ChanXueYanGuanLiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    //7.2.1 产学研管理查询
    /*
     响应 [{"id":"5938cb27075910c2d60d07dd","name"
     :"111","money":3000.0,"effect":"","date":"2017-06-08 03:57:27","company":"云创智能科技有限公司"},{"id":"5938cb08075910c2d60d07db"
     ,"name":"*****","money":2.0,"effect":"","date":"2017-06-08 03:56:56","company":"云创智能科技有限公司"}]
     */
    
    
    NSDictionary*dic=[_array objectAtIndex:indexPath.row];
        
    cell.hezuoJiGouName.text=[dic objectNotNullForKey:@"name"];
    
    NSNumber* money= [dic objectForKey:@"money"];

    cell.hezuoJine.text=[NSString stringWithFormat:@"%@",money];
    
    cell.hezuoXiaoGuo.text=[dic objectNotNullForKey:@"effect"];
    cell.suoshuGongSi.text=[dic objectNotNullForKey:@"company"];
    
     [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}





- (IBAction)DeleteChanXueBtn:(id)sender forEvent:(UIEvent *)event {
    
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableView];
    
    NSIndexPath *indexPath=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_array objectAtIndex:indexPath.row];
    NSString*strID=[dic objectNotNullForKey:@"id"];
    

    UIAlertController*alertCon=[UIAlertController alertControllerWithTitle:nil message:@"请确认是否删除？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction*action1=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction*action2=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [_api chanXueYanDelete:strID];
    }];
    
    [alertCon addAction:action1];
    [alertCon addAction:action2];
    
    [self presentViewController:alertCon animated:YES completion:nil];
    
    

}

-(void)deleteData:(id)data
{
    NSNumber*num=(NSNumber*)data;
    int result=[num intValue];
    if (result==1)
    {
        [self tiShiKuangDisplay:deleteStr viewController:self];
        [self query];
    }
}



- (IBAction)DownloadChanXueBtn:(id)sender forEvent:(UIEvent *)event {
    
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableView];
    
    NSIndexPath *indexPath=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_array objectAtIndex:indexPath.row];
    NSString*strID=[dic objectNotNullForKey:@"id"];
    
    
    FilelistViewController*vc=[[FilelistViewController alloc]initView:strID withType:@"6"];
     [self.navigationController pushViewController:vc animated:YES];

}



- (IBAction)chanxueyandetailquery:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableView];
    
    NSIndexPath *indexPath=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_array objectAtIndex:indexPath.row];
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"jiafencailiaoshenhe" bundle:nil];
    ChanXueYanDetailVC*vc=[board instantiateViewControllerWithIdentifier:@"ChanXueYanDetailVC"];
    vc.isadmin=_isadmin;
    vc.data=dic;
    vc.navigationItem.title=@"详情";
    [self.navigationController pushViewController:vc animated:YES];
}






@end

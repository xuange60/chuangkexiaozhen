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
    
    [_api chanXueYanQuery];
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
    
    UIBarButtonItem*RightBarItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(RightBarItemClick:)];
    
    [self.navigationItem setRightBarButtonItem:RightBarItem];
    
}

//左边添加比赛事件
-(void)RightBarItemClick:(UIBarButtonItem*)item
{
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"RiChangHuoYue" bundle:nil];
    AddChanXueYanVC*vc=[board instantiateViewControllerWithIdentifier:@"AddChanXueYanVC"];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveInfomation) name:@"ADDCHANYEXUESCUUESS" object:nil];
}

-(void)receiveInfomation
{
    [_api chanXueYanQuery];
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
        
    cell.hezuoJiGouName.text=[dic objectForKey:@"name"];
    
    NSNumber* money= [dic objectForKey:@"money"];

    cell.hezuoJine.text=[NSString stringWithFormat:@"%@",money];
    
              cell.hezuoXiaoGuo.text=[dic objectForKey:@"effect"];
    cell.suoshuGongSi.text=[dic objectForKey:@"company"];
    
    
    return cell;
}





- (IBAction)DeleteChanXueBtn:(id)sender forEvent:(UIEvent *)event {
    
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableView];
    
    NSIndexPath *indexPath=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_array objectAtIndex:indexPath.row];
    NSString*strID=[dic objectForKey:@"id"];
    
    [_api chanXueYanDelete:strID];

}

-(void)deleteData:(id)data
{
    NSNumber*num=(NSNumber*)data;
    int result=[num intValue];
    if (result==1)
    {
        [_api chanXueYanQuery];
    }
}



- (IBAction)DownloadChanXueBtn:(id)sender forEvent:(UIEvent *)event {
    
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableView];
    
    NSIndexPath *indexPath=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_array objectAtIndex:indexPath.row];
    NSString*strID=[dic objectForKey:@"id"];
    
    
//    UIStoryboard*board=[UIStoryboard storyboardWithName:@"RiChangHuoYue" bundle:nil];
//    ChanXueYanPhotoVC*vc=[board instantiateViewControllerWithIdentifier:@"ChanXueYanPhotoVC"];
//    [vc ReceiveShuJuPhoto:strID];
//    [self.navigationController pushViewController:vc animated:YES];
    
    
    FilelistViewController*vc=[[FilelistViewController alloc]initView:strID withType:@"6"];
     [self.navigationController pushViewController:vc animated:YES];

}









@end

//
//  BiSaiGuanLiVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/30.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BiSaiGuanLiVC.h"
#import "BiSaiCell.h"
#import "BussinessApi.h"
#import "AddBiSaiVC.h"
@interface BiSaiGuanLiVC ()

@end

@implementation BiSaiGuanLiVC


//提前加载数据方法
-(void)ReceiveShuJu
{
    _array=[NSArray array];
    
    _api=[[BussinessApi alloc]init];
    _api.delegate=self;
    _jiafencailiaoshenhe=[[JiaFenCaiLiaoShenHe alloc] init];
    _jiafencailiaoshenhe.delegate=self;
    [self query];
}

//查询的委托代理
-(void)loadNetworkFinished:(id)data
{
    _array=(NSArray*)data;
    
    [_tableView reloadData];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"比赛管理";
    UIImage *rightButtonIcon = [[UIImage imageNamed:@"add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *RightBarItem = [[UIBarButtonItem alloc] initWithImage:rightButtonIcon
                                                                     style:UIBarButtonItemStylePlain target:self action:@selector(RightBarItemClick:)];
    /*
    UIBarButtonItem*RightBarItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(RightBarItemClick:)];
    */
    [self.navigationItem setRightBarButtonItem:RightBarItem];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveInfo) name:@"ADDBISAISUCCESS" object:nil];
}

//左边添加后再次查询，刷新数据
-(void)receiveInfo
{
    [self query];
}


//左边添加比赛事件
-(void)RightBarItemClick:(UIBarButtonItem*)item
{
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"RiChangHuoYue" bundle:nil];
    AddBiSaiVC*vc=[board instantiateViewControllerWithIdentifier:@"AddBiSaiVC"];
    [self.navigationController pushViewController:vc animated:YES];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
#pragma mark-
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*str=@"BiSaiCell";
    BiSaiCell*cell=[tableView dequeueReusableCellWithIdentifier:str];
    
    if (!cell) {
        cell=[[BiSaiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    //7.1.1孵化成长管理->日常活跃度管理->比赛管理查询
    /*
     响应 	响应数据为array；如下格式
     [{"id":"5937dbe5075910c2d60d07c6","name"
     :"上海市创新创业大赛","competeLevel":"省部级比赛","prizeAwarded":"一等奖","hornerName":"********","orgnizationUnit":""
     ,"date":"2017-06-07 10:56:37","ownerCompetition":"是","score":14,"company":"云创智能科技有限公司"}]
     */

    
    NSDictionary*dic=[_array objectAtIndex:indexPath.row];
    
    cell.bisaiName.text= [dic objectNotNullForKey:@"name"];
    cell.bisaiLevel.text=[dic objectNotNullForKey:@"competeLevel"];
    cell.mingCi.text=[dic objectNotNullForKey:@"prizeAwarded"];
    cell.rongyuMingCheng.text=[dic objectNotNullForKey:@"hornerName"];
    cell.zuzhiDanWei.text=[dic objectNotNullForKey:@"orgnizationUnit"];
    cell.faqiDate.text=[dic objectNotNullForKey:@"ownerCompetition"];
    cell.benYuanQuzuzhi.text=[dic objectNotNullForKey:@"date"];
    cell.suoShuCompany.text=[dic objectNotNullForKey:@"company"];
   
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

//删除比赛事件处理
- (IBAction)deleteBtnClicked:(id)sender forEvent:(UIEvent *)event {
    
   NSSet*touches= [event allTouches];
    
   UITouch*touch=[touches anyObject];
    
   CGPoint point=[touch locationInView:_tableView];
    
   NSIndexPath *indexPath=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_array objectAtIndex:indexPath.row];
    NSString*strID=[dic objectNotNullForKey:@"id"];
    
    [_api biSaiGuanLiDelete:strID];
    
}
//删除数据委托代理，刷新
-(void)deleteData:(id)data
{
    NSNumber*num=(NSNumber*)data;
    int result=[num intValue];
    if (result==1)//删除成功
    {
        [self query];
    }
    
}


-(void) query
{
    if([@"Y" isEqualToString:_isadmin]){
        [_jiafencailiaoshenhe biSaiGuanLiQueryWithAdmin];
    }else{
        [_api biSaiGuanLiQuery];

    }
}

//下载比赛事件的处理，进入
- (IBAction)DownloadBtnClicked:(id)sender forEvent:(UIEvent *)event {
    
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableView];
    
    NSIndexPath *indexPath=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_array objectAtIndex:indexPath.row];
    NSString*strID=[dic objectNotNullForKey:@"id"];
    

    FilelistViewController* filelist=[[FilelistViewController alloc] initView:strID withType:@"5"];
    [self.navigationController pushViewController:filelist animated:YES];

    
}





- (IBAction)detailclick:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableView];
    
    NSIndexPath *indexPath=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_array objectAtIndex:indexPath.row];
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"jiafencailiaoshenhe" bundle:nil];
    BiSaiGuanLiDetailVC*vc=[board instantiateViewControllerWithIdentifier:@"BiSaiGuanLiDetailVC"];
    vc.isadmin=_isadmin;
    vc.data=dic;
    vc.navigationItem.title=@"详情";
    [self.navigationController pushViewController:vc animated:YES];
}



@end

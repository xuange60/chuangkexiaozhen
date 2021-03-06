//
//  QianDaoTongJiVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/15.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "QianDaoTongJiVC.h"

@interface QianDaoTongJiVC ()

@end

@implementation QianDaoTongJiVC

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.navigationItem.title=@"签到统计管理";
    
    _qiandao=[[QianDaoTongJi alloc]init];
    _qiandao.delegate=self;
    
    [_qiandao QianDaoTongJiQuery];
    
    UIImage *rightButtonIcon = [[UIImage imageNamed:@"add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *RightBarItem = [[UIBarButtonItem alloc] initWithImage:rightButtonIcon  style:UIBarButtonItemStylePlain target:self action:@selector(RightBarItemClick:)];
    [self.navigationItem setRightBarButtonItem:RightBarItem];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveInfomation) name:@"ADDQIANDAOSCUUESS" object:nil];
}

-(void)loadNetworkFinished:(id)data
{
    _aryM=(NSMutableArray*)data;
    [_tableView reloadData];
}

-(void)receiveInfomation
{
    [_qiandao QianDaoTongJiQuery];
}

//左边添加比赛事件
-(void)RightBarItemClick:(UIBarButtonItem*)item
{
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"QianDaoTongJi" bundle:nil];
    AddQianDaoTongJiVC*vc=[board instantiateViewControllerWithIdentifier:@"AddQianDaoTongJiVC"];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark-
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _aryM.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*str=@"QianDaoTongJiCell";
    QianDaoTongJiCell*cell=[tableView dequeueReusableCellWithIdentifier:str];
    
    if (!cell) {
        cell=[[QianDaoTongJiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }

    /**
     1.查询签到统计列表
     
     http://116.228.176.34:9002/chuangke-serve/sign/search
     
     响应：
     [{"id":"5949ec5f075910c2d60d08c7","actualNum"
     :30,"shouldNum":40,"percent":"75.00%","remark":"","roadshowName":"123"}]
     
     路演活动：roadshowName
     实到人数: actualNum
     应到人数 shouldNum
     出勤率 percent
     备注 remark
     */

    NSDictionary*dic=[_aryM objectAtIndex:indexPath.row];
    
    cell.huodong.text=[dic objectNotNullForKey:@"roadshowName"];
    cell.shidaoNum.text=[dic objectNotNullForKey:@"actualNum"];
    cell.yingdaoNum.text=[dic objectNotNullForKey:@"shouldNum"];
    cell.chuxilv.text=[dic objectNotNullForKey:@"percent"];
    cell.beizhu.text=[dic objectNotNullForKey:@"remark"];
    

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}


- (IBAction)deleteBtnClick:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableView];
    
    NSIndexPath *indexPath=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_aryM objectAtIndex:indexPath.row];
    NSString*strID=[dic objectNotNullForKey:@"id"];
    
    UIAlertController*alertCon=[UIAlertController alertControllerWithTitle:nil message:@"请确认是否删除？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction*action1=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction*action2=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [_qiandao QianDaoTongJiDelete:strID];
    }];
    
    [alertCon addAction:action1];
    [alertCon addAction:action2];
    
    [self presentViewController:alertCon animated:YES completion:nil];
    
}
-(void)afternetwork2:(id)data{
    
    [self tiShiKuangDisplay:deleteStr viewController:self];
    [_qiandao QianDaoTongJiQuery];
}


- (IBAction)downloadBtnClick:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableView];
    
    NSIndexPath *indexPath=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_aryM objectAtIndex:indexPath.row];
    NSString*strID=[dic objectNotNullForKey:@"id"];
    
    FilelistViewController*vc=[[FilelistViewController alloc]initView:strID withType:@"2"];
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end

//
//  YuanQuRenWuVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/14.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "YuanQuRenWuVC.h"

@interface YuanQuRenWuVC ()

@end

@implementation YuanQuRenWuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"园区任务通告";
    
    _tonggao=[[YuanQuRenWuTongGao alloc]init];
    _tonggao.delegate=self;
    
    [_tonggao YuanQuRenWuQuery];
    
    UIImage *rightButtonIcon = [[UIImage imageNamed:@"add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *RightBarItem = [[UIBarButtonItem alloc] initWithImage:rightButtonIcon  style:UIBarButtonItemStylePlain target:self action:@selector(RightBarItemClick:)];
    [self.navigationItem setRightBarButtonItem:RightBarItem];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveInfomation) name:@"ADDTONGGAOSCUUESS" object:nil];
}

-(void)loadNetworkFinished:(id)data
{
    _aryM=(NSMutableArray*)data;
    [_tableView reloadData];
}

-(void)receiveInfomation
{
    [_tonggao YuanQuRenWuQuery];
}

//左边添加比赛事件
-(void)RightBarItemClick:(UIBarButtonItem*)item
{
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"YuanQuRenWuTongGao" bundle:nil];
    AddYuanQuRenWuVC*vc=[board instantiateViewControllerWithIdentifier:@"AddYuanQuRenWuVC"];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark-
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _aryM.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*str=@"YuanQuRenWuCell";
    YuanQuRenWuCell*cell=[tableView dequeueReusableCellWithIdentifier:str];
    
    if (!cell) {
        cell=[[YuanQuRenWuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    NSDictionary*dic=[_aryM objectAtIndex:indexPath.row];
    cell.zhuti.text=[dic objectForKey:@"name"];
    cell.neirong.text=[dic objectForKey:@"content"];
    cell.shijian.text=[dic objectNotNullForKey:@"endDate"];
    cell.zhuangtai.text=[dic objectNotNullForKey:@"status"];
    
    if ([cell.zhuangtai.text isEqualToString:@"完成"]) {
        cell.succBtn.hidden=YES;
    }else{
         cell.succBtn.hidden=NO;
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

- (IBAction)succBtnClick:(id)sender forEvent:(UIEvent *)event {
    
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableView];
    
    NSIndexPath *indexPath=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_aryM objectAtIndex:indexPath.row];
    NSString*strID=[dic objectForKey:@"id"];

    [_tonggao YuanQuRenWuSucc:strID];
}
-(void)afternetwork3:(id)data
{
    [_tonggao YuanQuRenWuQuery];
}

- (IBAction)deleteBtnClick:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableView];
    
    NSIndexPath *indexPath=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_aryM objectAtIndex:indexPath.row];
    NSString*strID=[dic objectForKey:@"id"];
    [_tonggao YuanQuRenWuDelete:strID];
}
-(void)afternetwork2:(id)data{
    
    [_tonggao YuanQuRenWuQuery];
}

- (IBAction)detailBtnClick:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableView];
    
    NSIndexPath *indexPath=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_aryM objectAtIndex:indexPath.row];
    NSString*strID=[dic objectForKey:@"id"];
    
    [_tonggao YuanQuRenWuDetail:strID];
    
    
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"YuanQuRenWuTongGao" bundle:nil];
    DetailYuanQuRenWuVC*vc=[board instantiateViewControllerWithIdentifier:@"DetailYuanQuRenWuVC"];
    [vc setStrId:strID dict:dic];
    [self.navigationController pushViewController:vc animated:YES];

    
    
}
-(void)afternetwork1:(id)data{
    
    
}

- (IBAction)downloadBtnClick:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableView];
    
    NSIndexPath *indexPath=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_aryM objectAtIndex:indexPath.row];
    NSString*strID=[dic objectForKey:@"id"];
   
    FilelistViewController*vc=[[FilelistViewController alloc]initView:strID withType:@"24"];
    [self.navigationController pushViewController:vc animated:YES];

}










@end

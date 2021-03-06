//
//  GenZongVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/21.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "GenZongVC.h"

@interface GenZongVC ()

@end

@implementation GenZongVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationItem.title=@"成功跟踪管理";
     _genzong =[[ChengGuoGenZong alloc]init];
     _genzong.delegate=self;

     [_genzong ChengGuoGenZongQuery];

UIImage *rightButtonIcon = [[UIImage imageNamed:@"add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
UIBarButtonItem *RightBarItem = [[UIBarButtonItem alloc] initWithImage:rightButtonIcon  style:UIBarButtonItemStylePlain target:self action:@selector(RightBarItemClick:)];
[self.navigationItem setRightBarButtonItem:RightBarItem];


[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveInfomation) name:@"ADDGENZONGSUCCESS" object:nil];
}
//右边栏按钮添加事件
-(void)RightBarItemClick:(UIBarButtonItem*)item
{
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"ChengGuoGenZong" bundle:nil];
    AddGenZong*vc=[board instantiateViewControllerWithIdentifier:@"AddGenZong"];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)receiveInfomation
{
    [_genzong ChengGuoGenZongQuery];
}

-(void)loadNetworkFinished:(id)data
{
    _array=(NSMutableArray*)data;
    [_tableView reloadData];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _array.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*str=@"ChengGuoGenZongCell";
    ChengGuoGenZongCell*cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell=[[ChengGuoGenZongCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    /*
     2.19.1 成果跟踪查询
     [{
     createDate = "2017-08-20 10:07:00";
     id = 59995f44a92b0b6e2c92fb6d;
     name = 1111;
     }]
     http://116.228.176.34:9002/chuangke-serve/report/search?start=0&length=1000
     */
    
    NSDictionary*dic=[_array objectAtIndex:indexPath.row];
    
    cell.baogaoName.text=[dic objectNotNullForKey:@"name"];
    cell.createDate.text=[dic objectNotNullForKey:@"createDate"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}



- (IBAction)deleteBtnClicked:(id)sender forEvent:(UIEvent *)event {
    
    NSSet*touches=[event allTouches];
    UITouch*touch=[touches anyObject];
    CGPoint point=[touch locationInView:_tableView];
    NSIndexPath *path=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_array objectAtIndex:path.row];
    
    NSString*strId=[dic objectNotNullForKey:@"id"];
    
    UIAlertController*alertCon=[UIAlertController alertControllerWithTitle:nil message:@"请确认是否删除？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction*action1=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction*action2=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_genzong ChengGuoGenZongDelete:strId];
    }];
    
    [alertCon addAction:action1];
    [alertCon addAction:action2];
    
    [self presentViewController:alertCon animated:YES completion:nil];

}
    
    -(void)afternetwork2:(id)data
    {
        [self tiShiKuangDisplay:deleteStr viewController:self];
        [_genzong ChengGuoGenZongQuery];
    }

- (IBAction)downloadBtnClicked:(id)sender forEvent:(UIEvent *)event {
    
    NSSet*touches=[event allTouches];
    UITouch*touch=[touches anyObject];
    CGPoint point=[touch locationInView:_tableView];
    NSIndexPath *path=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_array objectAtIndex:path.row];
    
    NSString*strId=[dic objectNotNullForKey:@"id"];
    
    
    FilelistViewController*vc=[[FilelistViewController alloc]initView:strId withType:@"4"];
    [self.navigationController pushViewController:vc animated:YES];

}








@end

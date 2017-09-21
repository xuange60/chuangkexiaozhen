//
//  HuoDongLuYanViewController.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/6.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "HuoDongLuYanViewController.h"

@interface HuoDongLuYanViewController ()

@end

@implementation HuoDongLuYanViewController

- (void)viewDidLoad {
    self.datas=[NSArray array];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    [super viewDidLoad];
    
    //modify
    self.navigationItem.title=@"活动路演";

    UIImage *rightButtonIcon = [[UIImage imageNamed:@"add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *RightBarItem = [[UIBarButtonItem alloc] initWithImage:rightButtonIcon  style:UIBarButtonItemStylePlain target:self action:@selector(RightBarItemClick:)];
    if([_isadmin isEqualToString:@"Y"]){
        [self.navigationItem setRightBarButtonItem:RightBarItem];    
    }

    
    self.huodong=[[HuoDong alloc] init];
    self.huodong.delegate=self;
    [self query];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveInfomation) name:@"ADDHUODONGGUANLI" object:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)receiveInfomation
{
    [self query];
}

//左边添加比赛事件
-(void)RightBarItemClick:(UIBarButtonItem*)item
{
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"huodongluyan" bundle:nil];
    HuoDongLuYanAddVC*vc=[board instantiateViewControllerWithIdentifier:@"HuoDongLuYanAddVC"];
    [self.navigationController pushViewController:vc animated:YES];
}


//modify 查询数据，显示在tableview上时使用
-(void)query
{
    [self.huodong HuoDongLuYanQuery];
}


- (void)loadNetworkFinished:(id)data
{
    self.datas=(NSArray*)data;
    [self.tableview reloadData];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger num=[self.datas count];
    return num;
}

//modify 加载单元格数据时使用 注意设置单元格的Identifier
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* str1=@"HuoDongLuYanCell";
    
    HuoDongLuYanCell* cell=[tableView dequeueReusableCellWithIdentifier:str1];
    if(!cell){
        cell=[[HuoDongLuYanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str1];
    }
    NSDictionary* dic=[self.datas objectAtIndex:indexPath.row];
    cell.name.text=[dic objectNotNullForKey:@"name"];
    cell.address.text=[dic objectNotNullForKey:@"address"];
    cell.time.text=[dic objectNotNullForKey:@"time"];
    cell.url.text=[dic objectNotNullForKey:@"url"];
    if(![_isadmin isEqualToString:@"Y"]){
        cell.deletebtn.hidden=YES;
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (IBAction)deleteBtnClick:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableview];
    
    NSIndexPath *indexPath=[_tableview indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_datas objectAtIndex:indexPath.row];
    NSString*strID=[dic objectNotNullForKey:@"id"];
    
    UIAlertController*alertCon=[UIAlertController alertControllerWithTitle:nil message:@"请确认是否删除？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction*action1=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction*action2=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_huodong HuoDongLuYanDelete:strID];
    }];
    
    [alertCon addAction:action1];
    [alertCon addAction:action2];
    
    [self presentViewController:alertCon animated:YES completion:nil];
}



- (IBAction)HuoDongDetail:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableview];
    
    NSIndexPath *indexPath=[_tableview indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_datas objectAtIndex:indexPath.row];
    NSString* ids=[dic objectNotNullForKey:@"id"];

    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"huodongluyan" bundle:nil];
    HuoDongLuYanDetailViewController* detail=[storyboard instantiateViewControllerWithIdentifier:@"HuoDongLuYanDetailViewController"];
    detail.huodongid=ids;
    
    [self.navigationController pushViewController:detail animated:YES];

 
   NSLog(@"%@",@"detail");
}


-(void)afternetwork2:(id)data
{
    [self query];
}



- (IBAction)fileList:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableview];
    
    NSIndexPath *indexPath=[_tableview indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_datas objectAtIndex:indexPath.row];
    
    NSString* ids=(NSString*)[dic objectNotNullForKey:@"id"];
    
    FilelistViewController* filelist=[[FilelistViewController alloc] initView:ids withType:@"1"];
    [self.navigationController pushViewController:filelist animated:YES];
    
}







/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

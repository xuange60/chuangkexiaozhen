//
//  YuanGongLieBiaoVC.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/22.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "YuanGongLieBiaoVC.h"

@interface YuanGongLieBiaoVC ()

@end

@implementation YuanGongLieBiaoVC

- (void)viewDidLoad {
    self.datas=[NSArray array];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    [super viewDidLoad];
    
    //modify
    self.navigationItem.title=@"员工列表";
    
    UIImage *rightButtonIcon = [[UIImage imageNamed:@"add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:rightButtonIcon style:UIBarButtonItemStylePlain target:self action:@selector(add)];;
    
    
    _yuangongxinxi=[[YuanGongXinXi alloc] init];
    _yuangongxinxi.delegate=self;
    [self query];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(query) name:@"YuanGongLieBiaoVC" object:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)add
{
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"xitongpeizhi" bundle:nil];
    YuanGongAddVC* add=[storyboard instantiateViewControllerWithIdentifier:@"YuanGongAddVC"];
    [self.navigationController pushViewController:add animated:YES];
}

//modify 查询数据，显示在tableview上时使用
-(void)query
{
    [_yuangongxinxi YuanGongQuery];
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
    static NSString* str1=@"YuanGongLieBiaoCell";
    
    YuanGongLieBiaoCell* cell=[tableView dequeueReusableCellWithIdentifier:str1];
    if(!cell){
        cell=[[YuanGongLieBiaoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str1];
    }
    
    NSDictionary* dic=[self.datas objectAtIndex:indexPath.row];
    cell.loginName.text=[dic objectNotNullForKey:@"name"];
    cell.phone.text=[dic objectNotNullForKey:@"phone"];
    cell.email.text=[dic objectNotNullForKey:@"email"];
    cell.createDate.text=[dic objectNotNullForKey:@"createDate"];
    NSString* flag=[dic objectNotNullForKey:@"manager"];
    if([flag isEqualToString:@"1"]){
        cell.manager.text=@"管理员";
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}








- (IBAction)Delete:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableview];
    
    NSIndexPath *indexPath=[_tableview indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_datas objectAtIndex:indexPath.row];
    
    NSString* ids=(NSString*)[dic objectNotNullForKey:@"id"];
    
    UIAlertController*alertCon=[UIAlertController alertControllerWithTitle:nil message:@"请确认是否删除？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction*action1=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction*action2=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [_yuangongxinxi YuanGongDelete:ids];
    }];
    
    [alertCon addAction:action1];
    [alertCon addAction:action2];
    
    [self presentViewController:alertCon animated:YES completion:nil];
    
}

-(void)afternetwork2:(id)data
{
    [self tiShiKuangDisplay:deleteStr viewController:self];
    [self query];
}




- (IBAction)Modify:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableview];
    
    NSIndexPath *indexPath=[_tableview indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_datas objectAtIndex:indexPath.row];
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"xitongpeizhi" bundle:nil];
    YuanGongLieBiaoModifyVC* add=[storyboard instantiateViewControllerWithIdentifier:@"YuanGongLieBiaoModifyVC"];
    add.datas=dic;
    [self.navigationController pushViewController:add animated:YES];
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

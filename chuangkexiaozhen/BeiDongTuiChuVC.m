//
//  BeiDongTuiChuVC.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/20.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BeiDongTuiChuVC.h"

@interface BeiDongTuiChuVC ()

@end

@implementation BeiDongTuiChuVC

- (void)viewDidLoad {
    self.datas=[NSArray array];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    [super viewDidLoad];
    
    //modify
    self.navigationItem.title=@"被动退出管理";
    UIImage *rightButtonIcon = [[UIImage imageNamed:@"add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _rightBtnItem = [[UIBarButtonItem alloc] initWithImage:rightButtonIcon
                                                     style:UIBarButtonItemStylePlain target:self action:@selector(add)];
    if(_isadmin!=nil && [_isadmin isEqualToString:@"Y"]){
        self.navigationItem.rightBarButtonItem=_rightBtnItem;
    }
    
    
    _beidongtuichu=[[BeiDongTuiChu alloc] init];
    _beidongtuichu.delegate=self;
    [self query];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(query) name:@"BeiDongTuiChuVC" object:nil];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//点击右上角+号时，添加申请时重写
-(void)add
{
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"tuichujizhi" bundle:nil];
    BeiDongTuiChuAdd* add=[storyboard instantiateViewControllerWithIdentifier:@"BeiDongTuiChuAdd"];
    [self.navigationController pushViewController:add animated:YES];
    NSLog(@"%@",@"add");
}

//modify 查询数据，显示在tableview上时使用
-(void)query
{
    [_beidongtuichu BeiDongTuiChuQuery];
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
    static NSString* str1=@"BeiDongTuiChuCell";
    
    BeiDongTuiChuCell* cell=[tableView dequeueReusableCellWithIdentifier:str1];
    if(!cell){
        cell=[[BeiDongTuiChuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str1];
    }
    
    NSDictionary* dic=[self.datas objectAtIndex:indexPath.row];
    cell.quitCompany.text=[dic objectNotNullForKey:@"quitCompany"];
    cell.quitCause.text=[dic objectNotNullForKey:@"quitCause"];
    cell.quitDate.text=[dic objectNotNullForKey:@"quitDate"];
    cell.quitType.text=[dic objectNotNullForKey:@"quitType"];
    
    NSString* status=[dic objectNotNullForKey:@"status"];
    
    if([status isEqualToString:@"untreated"]){
        status=@"未处理";
    }else if([status isEqualToString:@"success"]){
        status=@"通过";
    }else if([status isEqualToString:@"fail"]){
        status=@"失败";
    }
    cell.status.text=status;
    if([_isadmin isEqualToString:@"Y"]){
        if([status isEqualToString:@"未处理"]){
            [cell.download setHidden:NO];
            [cell.succ setHidden:NO];
            [cell.nobtn setHidden:NO];
        }else{
            [cell.download setHidden:NO];
            [cell.succ setHidden:YES];
            [cell.nobtn setHidden:YES];
        }
    }else{
        [cell.download setHidden:YES];
        [cell.succ setHidden:YES];
        [cell.nobtn setHidden:YES];
        [cell.deletebtn setHidden:YES];
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
    
    NSString* ids=(NSString*)[dic objectForKey:@"id"];
    
    [_beidongtuichu BeiDongTuiChuDelete:ids];
    
}


- (IBAction)Succ:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableview];
    
    NSIndexPath *indexPath=[_tableview indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_datas objectAtIndex:indexPath.row];
    
    NSString* ids=(NSString*)[dic objectForKey:@"id"];
    
    [_beidongtuichu BeiDongTuiChuSucc:ids];
    
}


- (IBAction)No:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableview];
    
    NSIndexPath *indexPath=[_tableview indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_datas objectAtIndex:indexPath.row];
    
    NSString* ids=(NSString*)[dic objectForKey:@"id"];
    
    [_beidongtuichu BeiDongTuiChuNo:ids];
    
}



-(void)afternetwork2:(id)data
{
    [self query];
}


-(void)afternetwork3:(id)data
{
    [self query];
}


- (IBAction)Download:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableview];
    
    NSIndexPath *indexPath=[_tableview indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_datas objectAtIndex:indexPath.row];
    
    NSString* ids=(NSString*)[dic objectForKey:@"id"];
    
    FilelistViewController*vc=[[FilelistViewController alloc]initView:ids withType:@"36"];
    [self.navigationController pushViewController:vc animated:YES];
    
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

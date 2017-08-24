//
//  YongHuVC.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/21.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "YongHuVC.h"

@interface YongHuVC ()

@end

@implementation YongHuVC

- (void)viewDidLoad {
    self.datas=[NSArray array];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    [super viewDidLoad];
    
    //modify
    self.navigationItem.title=@"用户列表";

    
    _yonghuxinxi=[[YongHuXinXi alloc] init];
    _yonghuxinxi.delegate=self;
    [self query];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(query) name:@"YongHuVC" object:nil];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




//modify 查询数据，显示在tableview上时使用
-(void)query
{
    [_yonghuxinxi YongHuQuery];
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
    static NSString* str1=@"YongHuCell";
    
    YongHuCell* cell=[tableView dequeueReusableCellWithIdentifier:str1];
    if(!cell){
        cell=[[YongHuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str1];
    }
    
    NSDictionary* dic=[self.datas objectAtIndex:indexPath.row];
    cell.loginName.text=[dic objectNotNullForKey:@"loginName"];
    cell.phone.text=[dic objectNotNullForKey:@"phone"];
    cell.email.text=[dic objectNotNullForKey:@"email"];
    cell.companyName.text=[dic objectNotNullForKey:@"companyName"];
    cell.createDate.text=[dic objectNotNullForKey:@"createDate"];
    cell.companyType.text=[dic objectNotNullForKey:@"companyType"];
    cell.name.text=[dic objectNotNullForKey:@"name"];
    cell.department.text=[dic objectNotNullForKey:@"department"];
    cell.rank.text=[dic objectNotNullForKey:@"rank"];
    NSString* flag=[dic objectNotNullForKey:@"stopflag"];
    if([flag isEqualToString:@"1"]){
        cell.stopflag.text=@"已停用";
        UIImage* img=[UIImage imageNamed:@"newsucc1"];
        [cell.stopbutton setImage:img forState:UIControlStateNormal];
    }else{
        cell.stopflag.text=@"已启用";
        UIImage* img=[UIImage imageNamed:@"newerror1"];
        [cell.stopbutton setImage:img forState:UIControlStateNormal];
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
    
    [_yonghuxinxi YongHuDelete:ids];
    
}


- (IBAction)ModifyPwd:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableview];
    
    NSIndexPath *indexPath=[_tableview indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_datas objectAtIndex:indexPath.row];
    
    
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"xitongpeizhi" bundle:nil];
    
    YongHuModPwdVC* add=[storyboard instantiateViewControllerWithIdentifier:@"YongHuModPwdVC"];
    add.datas=dic;
    [self.navigationController pushViewController:add animated:YES];

}


- (IBAction)Modify:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableview];
    
    NSIndexPath *indexPath=[_tableview indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_datas objectAtIndex:indexPath.row];
    
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"xitongpeizhi" bundle:nil];
    YongHuModifyVC* add=[storyboard instantiateViewControllerWithIdentifier:@"YongHuModifyVC"];
    add.datas=dic;
    [self.navigationController pushViewController:add animated:YES];
    
}



-(void)afternetwork2:(id)data
{
    [self query];
}


-(void)afternetwork3:(id)data
{
    [self query];
}

-(void)afternetwork4:(id)data
{
    [self query];
}


-(void)afternetwork7:(id)data
{
    [self query];
}

- (IBAction)Stop:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableview];
    
    NSIndexPath *indexPath=[_tableview indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_datas objectAtIndex:indexPath.row];
    
    NSString* ids=(NSString*)[dic objectForKey:@"id"];
    NSString* flag=[dic objectNotNullForKey:@"stopflag"];
    if([flag isEqualToString:@"1"]){
        [_yonghuxinxi YongHuStart:ids];
    }else{
        [_yonghuxinxi YongHuStop:ids];
    }
    
    
    
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

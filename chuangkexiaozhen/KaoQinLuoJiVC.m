//
//  KaoQinLuoJiVC.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/16.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "KaoQinLuoJiVC.h"

@interface KaoQinLuoJiVC ()

@end

@implementation KaoQinLuoJiVC

- (void)viewDidLoad {
    self.datas=[NSArray array];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    [super viewDidLoad];
    
    //modify
    self.navigationItem.title=@"考勤逻辑管理";
    UIImage *rightButtonIcon = [[UIImage imageNamed:@"add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithImage:rightButtonIcon
                                                                     style:UIBarButtonItemStylePlain target:self action:@selector(add)];
    self.navigationItem.rightBarButtonItem=rightBtnItem;
    
    _kaoqinluoji=[[KaoQinLuoJi alloc] init];
    _kaoqinluoji.delegate=self;
    [self query];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(query) name:@"KaoQinLuoJiVC" object:nil];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//点击右上角+号时，添加申请时重写
-(void)add
{
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"KaoQinGuanLi" bundle:nil];
    KaoQinLuoJiUpdateVC* add=[storyboard instantiateViewControllerWithIdentifier:@"KaoQinLuoJiUpdateVC"];
    [self.navigationController pushViewController:add animated:YES];
    NSLog(@"%@",@"add");
}

//modify 查询数据，显示在tableview上时使用
-(void)query
{
    [_kaoqinluoji KaoQinLuoJiQuery];
    
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
    static NSString* str1=@"KaoQinLuoJiCell";
    
    KaoQinLuoJiCell* cell=[tableView dequeueReusableCellWithIdentifier:str1];
    if(!cell){
        cell=[[KaoQinLuoJiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str1];
    }
    NSDictionary* dic=[self.datas objectAtIndex:indexPath.row];
    cell.companyname.text=[dic objectNotNullForKey:@"companyName"];
    cell.starttime.text=[dic objectNotNullForKey:@"startTime"];
    cell.endtime.text=[dic objectNotNullForKey:@"endTime"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}



- (IBAction)Modify:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableview];
    
    NSIndexPath *indexPath=[_tableview indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_datas objectAtIndex:indexPath.row];
    
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"KaoQinGuanLi" bundle:nil];
    KaoQinLuoJiUpdateVC* add=[storyboard instantiateViewControllerWithIdentifier:@"KaoQinLuoJiUpdateVC"];
    add.isModify=@"Y";
    add.curdata=dic;
    [self.navigationController pushViewController:add animated:YES];

    
}




- (IBAction)Delete:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableview];
    
    NSIndexPath *indexPath=[_tableview indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_datas objectAtIndex:indexPath.row];
    
    NSString* ids=(NSString*)[dic objectForKey:@"id"];
    
    [_kaoqinluoji KaoQinLuoJiDelete:ids];
    
}



-(void)afternetwork2:(id)data
{
    [self query];
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

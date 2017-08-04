//
//  YuanGongViewController.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/4.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "YuanGongViewController.h"
#import "YuanGongAddViewController.h"

@interface YuanGongViewController ()

@end

@implementation YuanGongViewController

- (void)viewDidLoad {
    self.datas=[NSArray array];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    [super viewDidLoad];
    
    //modify
    self.navigationItem.title=@"员工管理";
    UIImage *rightButtonIcon = [[UIImage imageNamed:@"add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithImage:rightButtonIcon
                                                                     style:UIBarButtonItemStylePlain target:self action:@selector(add)];
    self.navigationItem.rightBarButtonItem=rightBtnItem;
    
    self.yuangongguanli=[[YuanGongGuanLi alloc] init];
    self.yuangongguanli.delegate=self;
    [self query];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(query) name:@"YuanGongViewController" object:nil];
    
    // Do any additional setup after loading the view.
}

-(void)add
{
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"yuangongguanli" bundle:nil];
    YuanGongAddViewController* add=[storyboard instantiateViewControllerWithIdentifier:@"YuanGongAddViewController"];
    [self.navigationController pushViewController:add animated:YES];
    NSLog(@"%@",@"add");
}


//modify 查询数据，显示在tableview上时使用
-(void)query
{
    [self.yuangongguanli YuanGongQuery];
}

- (void)loadNetworkFinished:(id)data
{
    self.datas=(NSArray*)data;
    [self.tableview reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger num=[self.datas count];
    return num;
}

//modify 加载单元格数据时使用 注意设置单元格的Identifier
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* str1=@"YuanGongCell";
    
    YuanGongCell* cell=[tableView dequeueReusableCellWithIdentifier:str1];
    if(!cell){
        cell=[[YuanGongCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str1];
    }
    NSDictionary* dic=[self.datas objectAtIndex:indexPath.row];
    cell.name.text=[dic objectNotNullForKey:@"name"];
    cell.mobile.text=[dic objectNotNullForKey:@"phone"];
    cell.email.text=[dic objectNotNullForKey:@"email"];
    cell.date.text=[dic objectNotNullForKey:@"joinDate"];
    return cell;
}


- (IBAction)delete:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableview];
    
    NSIndexPath *indexPath=[_tableview indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_datas objectAtIndex:indexPath.row];
    
    NSString* ids=(NSString*)[dic objectForKey:@"id"];
    
    [self.yuangongguanli YuanGongDelete:ids];
    
}

-(void)deleteData:(id)data
{
    [self query];
}


- (IBAction)detail:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableview];
    
    NSIndexPath *indexPath=[_tableview indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_datas objectAtIndex:indexPath.row];
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"yuangongguanli" bundle:nil];
    YuanGongDetailViewController* modify=[storyboard instantiateViewControllerWithIdentifier:@"YuanGongDetailViewController"];
    modify.data=dic;
    [self.navigationController pushViewController:modify animated:YES];
    NSLog(@"%@",@"modify");
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

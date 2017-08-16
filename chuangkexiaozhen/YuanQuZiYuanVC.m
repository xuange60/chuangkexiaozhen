//
//  YuanQuZiYuanVC.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/16.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "YuanQuZiYuanVC.h"

@interface YuanQuZiYuanVC ()

@end

@implementation YuanQuZiYuanVC

- (void)viewDidLoad {
    self.datas=[NSArray array];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    [super viewDidLoad];
    
    //modify
    self.navigationItem.title=@"园区资源管理";
    UIImage *rightButtonIcon = [[UIImage imageNamed:@"add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithImage:rightButtonIcon
                                                                     style:UIBarButtonItemStylePlain target:self action:@selector(add)];
    self.navigationItem.rightBarButtonItem=rightBtnItem;
    
    _yuanquziyuanguanli=[[YuanQuZiYuanGuanLi alloc] init];
    _yuanquziyuanguanli.delegate=self;
    [self query];
    [_yuanquziyuanguanli YuanQuZiYuanCategoryQuery];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(query) name:@"YuanQuZiYuanVC" object:nil];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//点击右上角+号时，添加申请时重写
-(void)add
{
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"yuanquziyuanguanli" bundle:nil];
    YuanQuZiYuanUpdateVC* add=[storyboard instantiateViewControllerWithIdentifier:@"YuanQuZiYuanUpdateVC"];
    add.categorys=_categorys;
    [self.navigationController pushViewController:add animated:YES];
    NSLog(@"%@",@"add");
}


- (IBAction)categoryclick:(id)sender {
    DuoXuanVC* add=[[DuoXuanVC alloc] init];
    NSArray* keys=[_categorys allKeys];
    [add setArray:keys btn:sender];
    [add setNavTitle:@"选择资产类型"];
    [add setDanXuan];
    NSString* curtitle=[_category currentTitle];
    if(curtitle!=nil){
        [add setSelectedData:[NSMutableArray arrayWithObject:curtitle]];
    }
    
    [self.navigationController pushViewController:add animated:YES];
    
}


-(void)afternetwork6:(id)data
{
    NSMutableDictionary* temp=[(NSDictionary*)data objectForKey:@"categorys"];
    if(temp==nil){
        _categorys=[NSDictionary dictionary];
        return;
    }
    [temp removeObjectForKey:@"选择资源类型"];
    _categorys=temp;
}


//modify 查询数据，显示在tableview上时使用
-(void)query
{
    NSString* categorys=[_category currentTitle];
    if(categorys==nil || [categorys length]<1){
        [_yuanquziyuanguanli YuanQuZiYuanQuery];
    }else{
        [_yuanquziyuanguanli YuanQuZiYuanQueryWithCategory:categorys];
    }

    
}
- (IBAction)queryziyuan:(id)sender {
    [self query];
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
    static NSString* str1=@"YuanQuZiYuanCell";
    
    YuanQuZiYuanCell* cell=[tableView dequeueReusableCellWithIdentifier:str1];
    if(!cell){
        cell=[[YuanQuZiYuanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str1];
    }
    NSDictionary* dic=[self.datas objectAtIndex:indexPath.row];
    cell.category.text=[dic objectNotNullForKey:@"category"];
    cell.code.text=[dic objectNotNullForKey:@"code"];
    cell.content.text=[dic objectNotNullForKey:@"content"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}



- (IBAction)Modify:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableview];
    
    NSIndexPath *indexPath=[_tableview indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_datas objectAtIndex:indexPath.row];
    
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"yuanquziyuanguanli" bundle:nil];
    YuanQuZiYuanUpdateVC* add=[storyboard instantiateViewControllerWithIdentifier:@"YuanQuZiYuanUpdateVC"];
    add.isModify=@"Y";
    add.curdata=dic;
    add.categorys=_categorys;
    [self.navigationController pushViewController:add animated:YES];
    
    
}




- (IBAction)Delete:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableview];
    
    NSIndexPath *indexPath=[_tableview indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_datas objectAtIndex:indexPath.row];
    
    NSString* ids=(NSString*)[dic objectForKey:@"id"];
    
    [_yuanquziyuanguanli YuanQuZiYuanDelete:ids];
    
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

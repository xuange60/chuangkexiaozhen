//
//  FaKaGuanLiVC.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/14.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "FaKaGuanLiVC.h"

@interface FaKaGuanLiVC ()

@end

@implementation FaKaGuanLiVC

- (void)viewDidLoad {
    self.datas=[NSArray array];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    [super viewDidLoad];
    
    //modify
    self.navigationItem.title=@"发卡管理";
    UIImage *rightButtonIcon = [[UIImage imageNamed:@"add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithImage:rightButtonIcon
                                                                     style:UIBarButtonItemStylePlain target:self action:@selector(add)];
    self.navigationItem.rightBarButtonItem=rightBtnItem;
    
    self.fakaguanli=[[FaKaGuanli alloc] init];
    self.fakaguanli.delegate=self;
    [self query];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(query) name:@"FuWuViewController" object:nil];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//点击右上角+号时，添加申请时重写
-(void)add
{
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"YuanQuFuWu" bundle:nil];
  //  FuWuShenQingAddViewController* add=[storyboard instantiateViewControllerWithIdentifier:@"FuWuShenQingAddViewController"];
  //  [self.navigationController pushViewController:add animated:YES];
    NSLog(@"%@",@"add");
}

//modify 查询数据，显示在tableview上时使用
-(void)query
{
    [_fakaguanli FaKaQuery];
    
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
    static NSString* str1=@"FaKaGuanLiCell";
    
    FaKaGuanLiCell* cell=[tableView dequeueReusableCellWithIdentifier:str1];
    if(!cell){
        cell=[[FaKaGuanLiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str1];
    }
    NSDictionary* dic=[self.datas objectAtIndex:indexPath.row];
    cell.companyName.text=[dic objectNotNullForKey:@"companyName"];
    cell.name.text=[dic objectNotNullForKey:@"name"];
    cell.bindName.text=[dic objectNotNullForKey:@"bindName"];
    cell.cardNumber.text=[dic objectNotNullForKey:@"cardNumber"];

    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}







- (IBAction)FuWuDelete:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableview];
    
    NSIndexPath *indexPath=[_tableview indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_datas objectAtIndex:indexPath.row];
    
    NSString* ids=(NSString*)[dic objectForKey:@"id"];
    
    [_fakaguanli FaKaDelete:ids];
    
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

//
//  PingFenDetailViewController.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/6.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "PingFenDetailViewController.h"

@interface PingFenDetailViewController ()

@end

@implementation PingFenDetailViewController

- (void)viewDidLoad {
    self.datas=[NSArray array];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    [super viewDidLoad];
    
    //modify
    self.navigationItem.title=@"评分详情";
    if([self.paihangbangtype isEqualToString:@"ZongHeNengLi"]){
        self.navigationItem.title=@"评分详情";
    }else if([self.paihangbangtype isEqualToString:@"RiHuoYue"]){
        self.navigationItem.title=@"评分详情";
    }else if([self.paihangbangtype isEqualToString:@"KeJiChuangXin"]){
        self.navigationItem.title=@"评分详情";
    }else if([self.paihangbangtype isEqualToString:@"ShiChangPaiHang"]){
        self.navigationItem.title=@"评分详情";
    }else if([self.paihangbangtype isEqualToString:@"XingZhengYunYing"]){
        self.navigationItem.title=@"评分详情";
    }
    
    
    
    self.paihangbang=[[PaiHangBang alloc] init];
    self.paihangbang.delegate=self;
    [self query];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//modify 查询数据，显示在tableview上时使用
-(void)query
{
    if([self.paihangbangtype isEqualToString:@"ZongHeNengLi"]){
        [self.paihangbang ZongHeNengLiDetailQuery:_ids];
    }else if([self.paihangbangtype isEqualToString:@"RiHuoYue"]){
        [_paihangbang RiHuoYueDelatiQuery:_ids];
    }else if([self.paihangbangtype isEqualToString:@"KeJiChuangXin"]){
        [_paihangbang KeJiChuangXinDetailQuery:_ids];
    }else if([self.paihangbangtype isEqualToString:@"ShiChangPaiHang"]){
        [_paihangbang ShiChangPaiHangDetailQuery:_ids];
    }else if([self.paihangbangtype isEqualToString:@"XingZhengYunYing"]){
        [_paihangbang XingZhengYunYingDetailQuery:_ids];
    }
    
    
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
    static NSString* str1=@"PingFenDetailCell";
    
    PingFenDetailCell* cell=[tableView dequeueReusableCellWithIdentifier:str1];
    if(!cell){
        cell=[[PingFenDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str1];
    }
    NSDictionary* dic=[self.datas objectAtIndex:indexPath.row];
    cell.name.text=[dic objectNotNullForKey:@"name"];
    cell.score.text=[dic objectNotNullForKey:@"score"];
    cell.materialType.text=[dic objectNotNullForKey:@"materialType"];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
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

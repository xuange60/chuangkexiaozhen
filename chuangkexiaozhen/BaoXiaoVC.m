//
//  BaoXiaoVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/20.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaoXiaoVC.h"

@interface BaoXiaoVC ()

@end

@implementation BaoXiaoVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _baoxiao=[[HuoDongBaoXiao alloc]init];
    _baoxiao.delegate=self;
    
    [_baoxiao HuoDongBaoXiaoQuery];
    
    UIImage *rightButtonIcon = [[UIImage imageNamed:@"add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *RightBarItem = [[UIBarButtonItem alloc] initWithImage:rightButtonIcon  style:UIBarButtonItemStylePlain target:self action:@selector(RightBarItemClick:)];
    [self.navigationItem setRightBarButtonItem:RightBarItem];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveInfomation) name:@"ADDBAOXIAOSUCCESS" object:nil];
}
//右边栏按钮添加事件
-(void)RightBarItemClick:(UIBarButtonItem*)item
{
    UIStoryboard*board=[UIStoryboard storyboardWithName:@"HuoDongBaoXiao" bundle:nil];
    AddBaoXiaoVC*vc=[board instantiateViewControllerWithIdentifier:@"AddBaoXiaoVC"];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)receiveInfomation
{
    [_baoxiao HuoDongBaoXiaoQuery];
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
    static NSString*str=@"BaoXiaoCell";
    BaoXiaoCell*cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell=[[BaoXiaoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    /*
     2.18.1 报销申请管理查询
     http://116.228.176.34:9002/chuangke-serve/expense/search?start=0&length=1000
     [{"id":"596b82d180ab5e6790d4f05b","totalPrice"
     :100.0,"approver":"王俊","proposer":"王俊","agree":"未同意","category":"餐饮","remark":null,"roadshowName":"123"
     ,"content":"餐饮"},{"id":"5949f1c9075910c2d60d08c8","totalPrice":10000.0,"approver":"王俊","proposer":null
     ,"agree":"未同意","category":"餐饮","remark":null,"roadshowName":"123","content":"***\r\n***\r\n***"}]
     */

    NSDictionary*dic=[_array objectAtIndex:indexPath.row];
    cell.luyan.text=[dic objectNotNullForKey:@"roadshowName"];
    cell.shenpiPerson.text=[dic objectNotNullForKey:@"approver"];
    cell.shenqingPerson.text=[dic objectNotNullForKey:@"proposer"];
    cell.statue.text=[dic objectNotNullForKey:@"agree"];
    cell.totalMoney.text=[dic objectNotNullForKey:@"totalPrice"];

    return cell;
}









@end

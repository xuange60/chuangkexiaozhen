//
//  DianZiHeTongVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/10.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "DianZiHeTongVC.h"

@interface DianZiHeTongVC ()

@end

@implementation DianZiHeTongVC

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.navigationItem.title=@"电子合同管理";
    _aryM=[NSMutableArray array];
   
    _hetong=[[DianZiHeTongGuanLi alloc]init];
    _hetong.delegate=self;
    
    [_hetong DianZiHeTongQuery];
}

-(void)loadNetworkFinished:(id)data
{
    NSArray*ary=(NSArray*)data;
    
    _aryM=[NSMutableArray arrayWithArray:ary];
    
 //   [_aryM addObjectsFromArray:ary];
 //   [_aryM addObject:data];
    [_tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _aryM.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*str=@"DianZiHeTongCell";
    DianZiHeTongCell*cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell=[[DianZiHeTongCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    cell.MyView.layer.cornerRadius=5;
    cell.MyView.layer.borderWidth=0.5;
    cell.MyView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    
    /*
     2.9.1 电子合同管理查询
     http://116.228.176.34:9002/chuangke-serve/electroniccontract/search?start=0&length=10
     [{"id":"5988838922637b17beb2f879","creator"
     :"cash","tenantTitle":"云创智能科技有限公司","createDate":"2017-08-07"},{"id":"5980815d80ab5e6790d536cb","creator"
     :"cash","tenantTitle":"云创智能科技有限公司","createDate":"2017-08-01"},{"id":"597fd8c780ab5e6790d53694","creator"
     :"cash","tenantTitle":"云创智能科技有限公司","createDate":"2017-08-01"}]
     */
    
    
    if ( _aryM && indexPath.row<_aryM.count)
    {
        NSDictionary*dic=[_aryM objectAtIndex:indexPath.row];
        cell.teamName.text=[dic objectNotNullForKey:@"tenantTitle"];
        cell.creatPerson.text=[dic objectNotNullForKey:@"creator"];
        cell.createDate.text=[dic objectNotNullForKey:@"createDate"];
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}


- (IBAction)detailBtnClicked:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches=[event allTouches];
    UITouch*touch=[touches anyObject];
    CGPoint point=[touch locationInView:_tableView];
    NSIndexPath*path=[_tableView indexPathForRowAtPoint:point];
    NSDictionary*dic=[_aryM objectAtIndex:path.row];
    
    NSString*strId=[dic objectForKey:@"id"];
    
    FilelistViewController*vc=[[FilelistViewController alloc]initView:strId withType:@"29"];
    [self.navigationController pushViewController:vc animated:YES];
    
}









@end

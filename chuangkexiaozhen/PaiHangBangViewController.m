//
//  ZongHeNengLiViewController.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/5.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "PaiHangBangViewController.h"

@interface PaiHangBangViewController ()

@end

@implementation PaiHangBangViewController

- (void)viewDidLoad {
    self.datas=[NSArray array];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    [super viewDidLoad];
    
    //modify
    if([self.paihangbangtype isEqualToString:@"ZongHeNengLi"]){
        self.navigationItem.title=@"综合能力排行";
    }else if([self.paihangbangtype isEqualToString:@"RiHuoYue"]){
        self.navigationItem.title=@"日活跃排行";
    }else if([self.paihangbangtype isEqualToString:@"KeJiChuangXin"]){
        self.navigationItem.title=@"科技创新能力排行";
    }else if([self.paihangbangtype isEqualToString:@"ShiChangPaiHang"]){
        self.navigationItem.title=@"市场业务能力排行";
    }else if([self.paihangbangtype isEqualToString:@"XingZhengYunYing"]){
        self.navigationItem.title=@"行政运营能力排行";
    }else{
        self.paihangbangtype=@"ZongHeNengLi";
        self.navigationItem.title=@"综合能力排行";
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
        [self.paihangbang ZongHeNengLiQuery];
    }else if([self.paihangbangtype isEqualToString:@"RiHuoYue"]){
        [_paihangbang RiHuoYueQuery];
    }else if([self.paihangbangtype isEqualToString:@"KeJiChuangXin"]){
        [_paihangbang KeJiChuangXinQuery];
    }else if([self.paihangbangtype isEqualToString:@"ShiChangPaiHang"]){
        [_paihangbang ShiChangPaiHangQuery];
    }else if([self.paihangbangtype isEqualToString:@"XingZhengYunYing"]){
        [_paihangbang XingZhengYunYingQuery];
    }else{
        self.paihangbangtype=@"ZongHeNengLi";
        [_paihangbang ZongHeNengLiQuery];
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
    static NSString* str1=@"PaiHangBangCell";
    
    PaiHangBangCell* cell=[tableView dequeueReusableCellWithIdentifier:str1];
    if(!cell){
        cell=[[PaiHangBangCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str1];
    }
    NSDictionary* dic=[self.datas objectAtIndex:indexPath.row];
    cell.name.text=[dic objectNotNullForKey:@"name"];
    cell.score.text=[dic objectNotNullForKey:@"score"];
    cell.descriptions.text=[dic objectNotNullForKey:@"description"];

    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}



- (IBAction)PingFenDetail:(id)sender forEvent:(UIEvent *)event {
    NSSet*touches= [event allTouches];
    
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableview];
    
    NSIndexPath *indexPath=[_tableview indexPathForRowAtPoint:point];
    
    NSDictionary*dic=[_datas objectAtIndex:indexPath.row];
    
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"paihangbang" bundle:nil];
    PingFenDetailViewController* detail=[storyboard instantiateViewControllerWithIdentifier:@"PingFenDetailViewController"];
    
    NSString* ids=[dic objectNotNullForKey:@"id"];
    detail.ids=ids;
    detail.paihangbangtype=_paihangbangtype;
    
    
    [self.navigationController pushViewController:detail animated:YES];
    NSLog(@"%@",@"detail");
    
}


@end

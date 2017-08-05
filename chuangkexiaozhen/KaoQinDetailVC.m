//
//  KaoQinDetailVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/5.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "KaoQinDetailVC.h"
#import "KaoQinDetailCell.h"
@interface KaoQinDetailVC ()

@end

@implementation KaoQinDetailVC

-(void)receiveArray:(NSArray*)array
{
    KaoQinGuanLi*kaoqin=[[KaoQinGuanLi alloc]init];
    kaoqin.delegate=self;
    
    [kaoqin KaoQinDetailQuery:[array objectAtIndex:0] date:[array objectAtIndex:1]];
    _array=[NSArray array];
    
}

-(void)loadNetworkFinished:(id)data
{
    _array=(NSArray*)data;
    [_tableView reloadData];
}





- (void)viewDidLoad {
    [super viewDidLoad];
   self.navigationItem.title=@"考勤详情";
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*str=@"KaoQinDetailCell";
    KaoQinDetailCell*cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell=[[KaoQinDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    /*
     10.2 查询考勤详情
     请求 get  http://116.228.176.34:9002/chuangke-serve/userattendance/user/search?start=0&length=1000
     响应 [{"id":"58f9d27d19eb8cbffbb87b1f","date"
     :"2017-08-04","username":"都步（上海）智能科技有限公司","status":null,"absence":"未出勤","startTime":null,"endTime":null
     }]
     */
    NSDictionary*dic=[_array objectAtIndex:indexPath.row];
    
    cell.name.text=[dic objectNotNullForKey:@"username"];
    cell.riqi.text=[dic objectNotNullForKey:@"date"];
    cell.ornochuqin.text=[dic objectNotNullForKey:@"absence"];
    cell.workTime.text=[dic objectNotNullForKey:@"startTime"];
    cell.homeTime.text=[dic objectNotNullForKey:@"endTime"];
    cell.kaoqinzhuangtai.text=[dic objectNotNullForKey:@"status"];
    return cell;
}















@end

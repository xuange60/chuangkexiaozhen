//
//  liugeCommonVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/21.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "liugeCommonVC.h"

@interface liugeCommonVC ()

@end

@implementation liugeCommonVC

-(void)setStr:(NSString*)str array:(NSArray*)ary shujuAry:(NSArray*)array
{
    _strTitle=str;
    _ary=ary;
//    _array=array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _yunying=[[TuanDuiYunYing alloc]init];
    _yunying.delegate=self;

    [_yunying queryData:_strTitle];
    
    
    
    
    
    
    
}

-(void)loadNetworkFinished:(id)data
{
    _array=(NSArray*)data;
    [_tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*str=@"liugeCommonCell";
    liugeCommonCell*cell=[tableView dequeueReusableCellWithIdentifier:str];
    
    cell.lab1.text=[_ary objectAtIndex:0];
    cell.lab2.text=[_ary objectAtIndex:1];
    cell.lab3.text=[_ary objectAtIndex:2];
    cell.lab4.text=[_ary objectAtIndex:3];
    cell.lab5.text=[_ary objectAtIndex:4];
    cell.lab6.text=[_ary objectAtIndex:5];

    NSDictionary*dic=[_array objectAtIndex:indexPath.row];
    
    if ([_strTitle isEqualToString:@"高学历人才"]) {
        cell.lab7.text=[dic objectForKey:@"name"];
        cell.lab8.text=dic[@"graduateSchool"];
        cell.lab9.text=dic[@"schoolLevel"];
        cell.lab10.text=dic[@"degreeLevel"];
        cell.lab11.text=dic[@"date"];
        cell.lab12.text=dic[@"company"];
    }
    
    if ([_strTitle isEqualToString:@"社保缴纳"]) {
        cell.lab7.text= [NSString stringWithFormat:@"%@", dic[@"employeeNumber"]];
        cell.lab8.text= [ NSString stringWithFormat:@"%@",dic[@"insureNumber"]];
        cell.lab9.text=dic[@"companyAccount"];
        cell.lab10.text=dic[@"newEmployeeNames"];
        cell.lab11.text=dic[@"idCards"];
        cell.lab12.text=dic[@"company"];
    }
    
    if ([_strTitle isEqualToString:@"社会责任履行"]) {
        cell.lab7.text= dic[@"name"];
        cell.lab8.text=dic[@"type"];
        cell.lab9.text= [ NSString stringWithFormat:@"%@",dic[@"employeeNumber"]];
        cell.lab10.text=dic[@"date"];
        cell.lab11.text=dic[@"company"];
        cell.lab12.hidden=YES;
    }
    
    
    if ([_strTitle isEqualToString:@"税务正规化"]) {
        cell.lab7.text= dic[@"taxNo"];
        cell.lab8.text=dic[@"accountName"];
        cell.lab9.text= dic[@"accountIdentityUS"];
        cell.lab10.text=dic[@"date"];
        cell.lab11.text=dic[@"company"];
        cell.lab12.hidden=YES;
    }

    if ([_strTitle isEqualToString:@"员工福利"]) {
        cell.lab7.text= dic[@"name"];
        cell.lab8.text= [ NSString stringWithFormat:@"%@",dic[@"totalBenefitMoney"]];
        cell.lab9.text=dic[@"benefitPercent"];
        cell.lab10.text=[ NSString stringWithFormat:@"%@",dic[@"benefitPerson"]];
        cell.lab11.text=dic[@"company"];
        cell.lab12.hidden=YES;
    }

    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}


- (IBAction)deteleBtnClicked:(id)sender forEvent:(UIEvent *)event {
    
    NSSet*touches=[event allTouches];
    UITouch*touch=[touches anyObject];
    CGPoint point=[touch locationInView:_tableView];
    NSIndexPath*path=[_tableView indexPathForRowAtPoint:point];
    NSDictionary*dic=[_array objectAtIndex:path.row];
    
    NSString*strID=[dic objectForKey:@"id"];
    
    [_yunying deleteData:strID withType:_strTitle];
}

-(void)afternetwork2:(id)data
{
    [_yunying queryData:_strTitle];
}


- (IBAction)detailBtnClicked:(id)sender forEvent:(UIEvent *)event {
    
    
    
}


- (IBAction)downloadBtnClicked:(id)sender forEvent:(UIEvent *)event {
    
    NSSet*touches=[event allTouches];
    UITouch*touch=[touches anyObject];
    CGPoint point=[touch locationInView:_tableView];
    NSIndexPath*path=[_tableView indexPathForRowAtPoint:point];
    NSDictionary*dic=[_array objectAtIndex:path.row];
    
    NSString*strID=[dic objectForKey:@"id"];
    
    
    FilelistViewController*vc=[[FilelistViewController alloc]initView:strID withType:_strTitle];
    [self.navigationController pushViewController:vc animated:YES];
    
}















@end

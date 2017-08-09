//
//  DetailShiTiVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/9.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "DetailShiTiVC.h"

@interface DetailShiTiVC ()

@end

@implementation DetailShiTiVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*str=@"DetailShiTiCell";
    DetailShiTiCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell=[[DetailShiTiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    
//    NSDictionary*dic=[_array objectAtIndex:indexPath.row];
//    cell.lianxiren.text=[dic objectNotNullForKey:@"contact"];
//    cell.lianxifangshi.text=[dic objectNotNullForKey:@"contactType"];
//    cell.jigouName.text=[dic objectNotNullForKey:@"companyName"];
//    cell.hangye.text=[dic objectNotNullForKey:@"businessLine"];
//    cell.shenqingTime.text=[dic objectNotNullForKey:@"applyDate"];
//    cell.shenqingType.text=[dic objectNotNullForKey:@"applyStatus"];
//    cell.baodaoType.text=[dic objectNotNullForKey:@"inplace"];
//    cell.totalScore.text=[dic objectNotNullForKey:@"totalScore"];
//    
//    if ([cell.shenqingType.text isEqualToString:@"通过"]) {
//        cell.addBtn.hidden=YES;
//        cell.succBtn.hidden=YES;
//        cell.errorBtn.hidden=YES;
//        cell.deleteBtn.hidden=YES;
//    }else{
//        cell.addBtn.hidden=NO;
//        cell.succBtn.hidden=NO;
//        cell.errorBtn.hidden=NO;
//        cell.deleteBtn.hidden=NO;
//    }
    
    
    
    return cell;
}


- (IBAction)DetailBtnClicked:(id)sender forEvent:(UIEvent *)event {
    
    
    
    
    
}


- (IBAction)DeteleBtnClicked:(id)sender forEvent:(UIEvent *)event {
    
    
    
    
}



















@end

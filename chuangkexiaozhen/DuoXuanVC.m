//
//  DuoXuanVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/12.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "DuoXuanVC.h"

@interface DuoXuanVC ()

@end

@implementation DuoXuanVC
-(void)setArray:(NSArray*)array  btn:(UIButton*)btn
{
    _array=[NSMutableArray arrayWithArray:array];
    _btn=btn;

}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title=@"选择资产编号";
    self.view.backgroundColor=[UIColor whiteColor];
    
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
    _Mstr=[NSMutableString string];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*str=@"cell";
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.accessoryType= UITableViewCellAccessoryNone;
    cell.textLabel.text=[_array objectAtIndex:indexPath.row];
   
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell*cell=[tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.accessoryType==UITableViewCellAccessoryNone)
    {
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
        if ([_Mstr isEqualToString:@""]) {
             [_Mstr appendString:[_array objectAtIndex:indexPath.row]];
        }else{
            [_Mstr appendString:@","];
            [_Mstr appendString:[_array objectAtIndex:indexPath.row]];
        }
        NSLog(@"%@",_Mstr);
    }else{
        cell.accessoryType=UITableViewCellAccessoryNone;
        if ([_Mstr containsString:@","])
        {
        NSString*ss=@",";
        NSString*str= [ss stringByAppendingString:[_array objectAtIndex:indexPath.row]];
        [_Mstr replaceOccurrencesOfString:str withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, _Mstr.length)];
        }else{
         [_Mstr replaceOccurrencesOfString:[_array objectAtIndex:indexPath.row] withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, _Mstr.length)];
        }
         NSLog(@"%@",_Mstr);
    }
    
      [_btn setTitle:_Mstr forState:UIControlStateNormal];
}


//- (IBAction)btnclick:(id)sender {
//    UIButton* btn=(UIButton*)sender;
//    NSString* datas=btn.titleLabel.text;
//    if(datas!=nil && datas.length>0 && [datas containsString:@","])
//    {
//        datas=[datas stringByReplacingOccurrencesOfString:@"[" withString:@""];
//        datas=[datas stringByReplacingOccurrencesOfString:@"]" withString:@""];
//        NSArray* array=[datas componentsSeparatedByString:@","];
//    }
// }







@end

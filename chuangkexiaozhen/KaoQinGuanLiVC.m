//
//  KaoQinGuanLiVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/5.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "KaoQinGuanLiVC.h"
#import "KaoQinGuanLiCell.h"
@interface KaoQinGuanLiVC ()

@end

@implementation KaoQinGuanLiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _ary=[NSArray array];
    self.navigationController.title=@"考勤管理";
    _kaoQin=[[KaoQinGuanLi alloc]init];
    _kaoQin.delegate=self;


    
    
}



- (IBAction)startBtnClick:(id)sender {
    
    UIDatePicker*picker=[[UIDatePicker alloc]initWithFrame:CGRectMake(_startTime.frame.origin.x, _startTime.frame.origin.y+5, 200, 200)];
    picker.datePickerMode=UIDatePickerModeDate;
    [self.view addSubview:picker];
    [picker addTarget:self action:@selector(pickerStart:) forControlEvents:UIControlEventValueChanged];
}
-(void)pickerStart:(UIDatePicker*)picker
{
  _startTime.text= [NSString stringWithFormat:@"%@",picker.date];
}


- (IBAction)endBtnClick:(id)sender {
    UIDatePicker*picker=[[UIDatePicker alloc]initWithFrame:CGRectMake(_endTime.frame.origin.x, _endTime.frame.origin.y+5, 200, 200)];
    picker.datePickerMode=UIDatePickerModeDate;
    [self.view addSubview:picker];
    [picker addTarget:self action:@selector(pickerEnd:) forControlEvents:UIControlEventValueChanged];
}

-(void)pickerEnd:(UIDatePicker*)picker
{
 _endTime.text= [NSString stringWithFormat:@"%@",picker.date];
}

- (IBAction)ChaXunBtnClick:(id)sender {

 [_kaoQin KaoQinQueryStart:_startTime.text End:_endTime.text];
    
}

-(void)loadNetworkFinished:(id)data
{
    _ary=(NSArray*)data;
    
    [_tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _ary.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*str=@"KaoQinGuanLiCell";
    KaoQinGuanLiCell*cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell=[[KaoQinGuanLiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    NSDictionary*dic=[_ary objectAtIndex:indexPath.row];
    
    cell.shidao.text=[dic objectNotNullForKey:@""];
    cell.shidao.text=[dic objectNotNullForKey:@""];
    cell.shidao.text=[dic objectNotNullForKey:@""];
    cell.shidao.text=[dic objectNotNullForKey:@""];
    cell.shidao.text=[dic objectNotNullForKey:@""];
    
    
    return cell;
}



- (IBAction)DetailBtnClick:(id)sender forEvent:(UIEvent *)event {
    
    NSSet*touches=[event allTouches];
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableView];
    
    NSIndexPath*path=[_tableView indexPathForRowAtPoint:point];
    
    NSDictionary *dic=[_ary objectAtIndex:path.row];
    

    
}




@end

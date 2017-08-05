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
    
    UIDatePicker*picker=[[UIDatePicker alloc]initWithFrame:CGRectMake(_startTime.frame.origin.x, _startTime.frame.origin.y+5, self.view.frame.size.width, 200)];
    picker.backgroundColor=[UIColor whiteColor];
    picker.datePickerMode=UIDatePickerModeDate;
    [self.view addSubview:picker];
    [picker addTarget:self action:@selector(pickerStart:) forControlEvents:UIControlEventValueChanged];
}
-(void)pickerStart:(UIDatePicker*)picker
{
  _startTime.text= [NSString stringWithFormat:@"%@",picker.date];
    [picker removeFromSuperview];
}


- (IBAction)endBtnClick:(id)sender {
    UIDatePicker*picker=[[UIDatePicker alloc]initWithFrame:CGRectMake(_endTime.frame.origin.x, _endTime.frame.origin.y+5, self.view.frame.size.width, 200)];
    picker.backgroundColor=[UIColor whiteColor];
    picker.datePickerMode=UIDatePickerModeDate;
    [self.view addSubview:picker];
    [picker addTarget:self action:@selector(pickerEnd:) forControlEvents:UIControlEventValueChanged];
}

-(void)pickerEnd:(UIDatePicker*)picker
{
 _endTime.text= [NSString stringWithFormat:@"%@",picker.date];
    [picker removeFromSuperview];
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
    
    /*
     10.1 考勤统计查询
     请求 get  http://116.228.176.34:9002/chuangke-serve/userattendance/search?start=0&length=10000
     响应： [{"id":"58f9d2ea19eb8cbffbb87b23","actualCount"
     :0,"absentCount":1,"shouldCount":1,"rateOfAttend":"0.00%","companyName":"都步（上海）智能科技有限公司"},{"id":"58f5887219eb8cbffbb87aa0"
     ,"actualCount":0,"absentCount":1,"shouldCount":1,"rateOfAttend":"0.00%","companyName":"清基(上海）农业发展有限公
     司"},{"id":"597d7aba80ab5e6790d52d37","actualCount":0,"absentCount":1,"shouldCount":1,"rateOfAttend":"0
     .00%","companyName":"测试机构zhangxuan"}]
     */

    
    
    NSDictionary*dic=[_ary objectAtIndex:indexPath.row];
    
    cell.shidao.text=[dic objectNotNullForKey:@"actualCount"];
    cell.queqin.text=[dic objectNotNullForKey:@"absentCount"];
    cell.yingdao.text=[dic objectNotNullForKey:@"shouldCount"];
    cell.bilv.text=[dic objectNotNullForKey:@"rateOfAttend"];
    cell.company.text=[dic objectNotNullForKey:@"companyName"];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    
//}







- (IBAction)DetailBtnClick:(id)sender forEvent:(UIEvent *)event {
    
    NSSet*touches=[event allTouches];
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableView];
    
    NSIndexPath*path=[_tableView indexPathForRowAtPoint:point];
    
    /*
     10.2 查询考勤详情
     请求 get  http://116.228.176.34:9002/chuangke-serve/userattendance/user/search?start=0&length=1000
     响应 [{"id":"58f9d27d19eb8cbffbb87b1f","date"
     :"2017-08-04","username":"都步（上海）智能科技有限公司","status":null,"absence":"未出勤","startTime":null,"endTime":null
     }]
     */

    NSDictionary *dic=[_ary objectAtIndex:path.row];
    
    NSString*strId=[dic objectNotNullForKey:@"id"];

    UIStoryboard*board=[UIStoryboard storyboardWithName:@"KaoQinGuanLi" bundle:nil];
    KaoQinDetailVC*vc=[board instantiateViewControllerWithIdentifier:@"KaoQinDetailVC"];
    [self.navigationController pushViewController:vc animated:YES];
    
    
  //   [_kaoQin KaoQinDetailQuery:<#(NSString *)#> date:<#(NSString *)#>];
}




@end

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
    self.navigationItem.title=@"考勤统计";
    _kaoQin=[[KaoQinGuanLi alloc]init];
    _kaoQin.delegate=self;


    NSDate * date=[NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString*time=[dateFormatter stringFromDate:date];
    
    _startTime.text=time;
    NSString*start=[NSString stringWithFormat:@"%@ %@",time,@"00:00:00"];
    NSString*end=[NSString stringWithFormat:@"%@ %@",time,@"23:59:59"];
    
    [_kaoQin KaoQinQueryStart:start End:end];
    
}



- (IBAction)startBtnClick:(id)sender {
    
    UIDatePicker*picker=[[UIDatePicker alloc]initWithFrame:CGRectMake(_startTime.frame.origin.x, _startTime.frame.origin.y+5, self.view.frame.size.width, 200)];
    picker.backgroundColor=[UIColor whiteColor];
    picker.datePickerMode=UIDatePickerModeDate;
    picker.minimumDate=[NSDate dateWithTimeIntervalSince1970:0];
    picker.maximumDate=[NSDate date];
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文
    picker.locale = locale;
    
    [self.view addSubview:picker];
    [picker addTarget:self action:@selector(pickerStart:) forControlEvents:UIControlEventValueChanged];
}
-(void)pickerStart:(UIDatePicker*)picker
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    _startTime.text = [dateFormatter stringFromDate:picker.date];
    [picker removeFromSuperview];
    [self ChaXunKaoQin];
}

-(void)ChaXunKaoQin
{
    NSString*start=[NSString stringWithFormat:@"%@ %@",_startTime.text,@"00:00:00"];
    NSString*end=[NSString stringWithFormat:@"%@ %@",_startTime.text,@"23:59:59"];
    
    [_kaoQin KaoQinQueryStart:start End:end];
}



-(void)loadNetworkFinished:(id)data
{
    if(![_isadmin isEqualToString:@"Y"]){
        NSArray* tmparys=(NSArray*)data;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary*dic=[defaults dictionaryForKey:@"chuangkexiaozhen.userinfo"];
        NSString* companyname=[dic objectNotNullForKey:@"companytitle"];
        NSMutableArray* tmp=[NSMutableArray array];
        for (NSDictionary* data in tmparys) {
            if([[data objectNotNullForKey:@"companyName"] isEqualToString:companyname]){
                [tmp addObject:data];
                break;
            }
        }
        _ary=tmp;
    }else{
        _ary=(NSArray*)data;
    }


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

- (IBAction)DetailBtnClick:(id)sender forEvent:(UIEvent *)event {
    
    NSSet*touches=[event allTouches];
    UITouch*touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:_tableView];
    
    NSIndexPath*path=[_tableView indexPathForRowAtPoint:point];
    
    
    NSDictionary *dic=[_ary objectAtIndex:path.row];
    NSString*strId=[dic objectNotNullForKey:@"id"];

    UIStoryboard*board=[UIStoryboard storyboardWithName:@"KaoQinGuanLi" bundle:nil];
    KaoQinDetailVC*vc=[board instantiateViewControllerWithIdentifier:@"KaoQinDetailVC"];
    
    NSArray*array=[NSArray arrayWithObjects:strId,_startTime.text ,nil];
    [vc receiveArray:array];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}



@end

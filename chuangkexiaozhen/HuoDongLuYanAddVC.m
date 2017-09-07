//
//  HuoDongLuYanAddVC.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/9/7.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "HuoDongLuYanAddVC.h"

@interface HuoDongLuYanAddVC ()

@end

@implementation HuoDongLuYanAddVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"添加活动路演";
    self.rightbutton=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(tijiaoBtnClick:)];
    self.rightbutton.tintColor=[UIColor whiteColor];
    self.rightbutton.enabled=NO;
    self.navigationItem.rightBarButtonItem=self.rightbutton;
    _huodong=[[HuoDong alloc]init];
    _huodong.delegate=self;
    
    [_huodong HuoDongParamQuery];
    
    [self receiveCurrentViewController:self];
}

-(void)afternetwork6:(id)data
{
    _dic=(NSDictionary*)data;
}






- (IBAction)personBtnClick:(id)sender {
    
    NSDictionary*dic=_dic[@"noticeList"];
    NSArray*ary=[dic allKeys];
    
    DuoXuanVC*vc=[[DuoXuanVC alloc]init];
    [vc setArray:ary btn:_noticeList];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)shangchuanBtnClick:(id)sender {
    
    ImgeUpViewController* imgup=[[ImgeUpViewController alloc] initView];
    [imgup setNotifyName:@"ADDYUANQURENWUVCFileUp" AndTitle:@"文档上传"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getfile:) name:@"ADDYUANQURENWUVCFileUp" object:nil];
    [self.navigationController pushViewController:imgup animated:YES];
}

-(void)getfile:(id)data
{
    if(data!=nil){
        NSNotification* tmp=(NSNotification*)data;
        
        _photoIds=(NSString*)tmp.object;
    }
    
}


- (IBAction)dateBtnClick:(id)sender {
    
    UIDatePicker*picker=[[UIDatePicker alloc]initWithFrame:CGRectMake(60, 400, 300, 200)];
    picker.backgroundColor=[UIColor whiteColor];
    picker.datePickerMode=UIDatePickerModeDate;
    picker.minimumDate=[NSDate date];
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文
    picker.locale = locale;
    
    if([_time currentTitle]!=nil && [_time currentTitle].length>5){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSData* date1=[dateFormatter dateFromString:[_time currentTitle]];
        picker.date=date1;
    }
    
    [self.view addSubview:picker];
    [picker addTarget:self action:@selector(pickerStart:) forControlEvents:UIControlEventValueChanged];
}
-(void)pickerStart:(UIDatePicker*)picker
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString*time= [dateFormatter stringFromDate:picker.date];
    [_time setTitle:time forState:UIControlStateNormal];
    [picker removeFromSuperview];
    
}


- (IBAction)tijiaoBtnClick:(id)sender {
    
    /*
     添加任务通告
     参数：
     通告类型 category 整理内务
     通告内容 content xxxx
     截止时间 enddate 2017-08-14 14:38:31
     file
     紧急程度 levels 紧急
     通告主题 name ceshi
     文件id resourceIds 598ff39922637b17beb31415
     涉及人员 users 597d807680ab5e6790d52d45 users 597db39c80ab5e6790d52d6a
     workId
     */
    
    
    NSDictionary*dicC=_dic[@"noticeList"];
    
    NSMutableDictionary*dic=[NSMutableDictionary dictionary];
    [dic setNotNullStrObject:_address.text forKey:@"address"];
    [dic setNotNullStrObject:_content.text forKey:@"content"];
    [dic setNotNullStrObject:_name.text forKey:@"name"];
    [dic setNotNullStrObject:_organizationList.text forKey:@"organizationList"];
    [dic setNotNullStrObject:_photoIds forKey:@"resourceIds"];
    [dic setNotNullStrObject:[_time currentTitle] forKey:@"time"];
    [dic setNotNullStrObject:_url.text forKey:@"url"];
    NSArray*ary=[[_noticeList currentTitle] componentsSeparatedByString:@","];
    
    NSMutableArray*array=[NSMutableArray array];
    
    for (NSString*ss in ary)
    {
        NSString*value=[dicC objectNotNullForKey:ss];
        [array addObject:value];
    }
    
    [dic setNotNullObject:array forKey:@"noticeList"];

    
    [_huodong HuoDongLuYanAdd:dic];
}

-(void)afternetwork5:(id)data
{
    [self tiShiKuangDisplay:submitStr viewController:self];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ADDHUODONGGUANLI" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}




@end

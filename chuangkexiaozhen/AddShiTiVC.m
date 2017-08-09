//
//  AddShiTiVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/9.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "AddShiTiVC.h"

@interface AddShiTiVC ()

@end

@implementation AddShiTiVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _array=@[];
    _shiti=[[ShiTiRuZhuGuanLi alloc]init];
    _shiti.delegate=self;
     [_shiti DaBianZhuanJiaQuery];
}
-(void)loadNetworkFinished:(id)data
{
    _array=[NSArray arrayWithObject:data];
}

- (IBAction)btn1Clicked:(id)sender {
    
    /*
     2.4.2 获取评审专家列表
     get http://116.228.176.34:9002/chuangke-serve/user/getselect?code=evaluationexpert
     [{"id":"5875a60bee19799d1cc83824","name"
     :"王俊","loginName":"admin"},{"id":"58e5c52c19eb26b288dc9753","name":"顾一琳","loginName":"guyilin"},{"id"
     :"58e7316c19eb5e6b9401247e","name":"王博雅","loginName":"wangboya"}]
     */

    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComboViewController*vc=[storyboard instantiateViewControllerWithIdentifier:@"ComboViewController"];
   
    [vc setDatas:_array withBtn:sender];
    vc.navigationItem.title=@"评审专家列表";
    [self.navigationController pushViewController:vc animated:YES];

}


- (IBAction)seleteDateClick:(id)sender {
    
    UIDatePicker*datePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(_textField.frame.origin.x, _textField.frame.origin.y+20, self.view.frame.size.width, 200)];
    datePicker.backgroundColor=[UIColor whiteColor];
    datePicker.datePickerMode=UIDatePickerModeDate;
    datePicker.minimumDate=[NSDate dateWithTimeIntervalSince1970:0];
    datePicker.maximumDate=[NSDate date];
    datePicker.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"zh-CN"];

    [self.view addSubview:datePicker];
    [datePicker addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventValueChanged];
}

-(void)selectDate:(UIDatePicker*)picker
{
    NSDateFormatter*formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
   NSString*time=[formatter stringFromDate:picker.date];
    _textField.text=time;
    [picker removeFromSuperview];
}



- (IBAction)tijiaoClicked:(id)sender {
    
    /*
     2.4.1 提交答辩
     post http://116.228.176.34:9002/chuangke-serve/applytreat/save
     参数
     评审专家id userIds
     答辩时间 defenceDateStr
     答辩地点 addr
     */

    NSString*strID=@"";
    for (NSDictionary*dic in _array)
    {
        NSString*nameValue=[dic objectForKey:@"name"];
        
        if ([nameValue isEqualToString:_btn1.currentTitle])
        {
            strID=[dic objectForKey:@"id"];
        }
    }

    
    NSDictionary*dic=[NSDictionary dictionary];
     [dic setValue:strID forKey:@""];
    
     [dic setValue:_textField.text forKey:@"defenceDateStr"];
     [dic setValue:_address.text forKey:@"addr"];
    
    
    [_shiti TiJiaoDaBianShenQing:dic];
    
    
}

-(void)addData:(id)data
{
    
    
    
}







@end

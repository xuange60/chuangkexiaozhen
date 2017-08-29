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

-(void)setData:(NSString*)strId
{
    _strID=[NSString stringWithString:strId];
}

- (void)viewDidLoad {
    self.navigationItem.title=@"添加答辩";
    self.rightbutton=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(tijiaoClicked:)];
    self.rightbutton.tintColor=[UIColor whiteColor];
    self.rightbutton.enabled=NO;
    self.navigationItem.rightBarButtonItem=self.rightbutton;
    [super viewDidLoad];
   
    _array=@[];
    _shiti=[[ShiTiRuZhuGuanLi alloc]init];
    _shiti.delegate=self;
     [_shiti DaBianZhuanJiaQuery];
}
-(void)afternetwork4:(id)data
{
    _array=[NSArray arrayWithArray:(NSArray*)data];
}

- (IBAction)btn1Clicked:(id)sender {
    
    
    /*
     2.4.2 获取评审专家列表
     get http://116.228.176.34:9002/chuangke-serve/user/getselect?code=evaluationexpert
     [{"id":"5875a60bee19799d1cc83824","name"
     :"王俊","loginName":"admin"},{"id":"58e5c52c19eb26b288dc9753","name":"顾一琳","loginName":"guyilin"},{"id"
     :"58e7316c19eb5e6b9401247e","name":"王博雅","loginName":"wangboya"}]
     */

    NSMutableArray*array=[NSMutableArray array];
    for (NSDictionary*dic in _array)
    {
       NSString*str=[dic objectForKey:@"name"];
        [array addObject:str];
    }
    //数组里面是字典，字典里面是键值对
    
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComboViewController*vc=[storyboard instantiateViewControllerWithIdentifier:@"ComboViewController"];
   
    [vc setDatas:array withBtn:sender];
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
     记录id applyid
     评审专家id userIds
     答辩时间 defenceDateStr
     答辩地点 addr
     */

    NSString*str=@"";
    for (NSDictionary*dic in _array)
    {
        NSString*nameValue=[dic objectForKey:@"name"];
        
        if ([nameValue isEqualToString:_btn1.currentTitle])
        {
            str=[dic objectForKey:@"id"];
        }
    }

     NSMutableDictionary*dic=[NSMutableDictionary dictionary];
     [dic setNotNullStrObject: str forKey:@"userIds"];
     [dic setNotNullStrObject:_textField.text forKey:@"defenceDateStr"];
     [dic setNotNullStrObject:_address.text forKey:@"addr"];
     [dic setNotNullStrObject:_strID forKey:@"applyid"];

    [_shiti TiJiaoDaBianShenQing:dic];
}

-(void)afternetwork3:(id)data
{
    int result=[(NSNumber*)data intValue];
    
    if (result==1)
    {
      UIAlertController*alertCon=[UIAlertController alertControllerWithTitle:nil message:@"信息提交成功" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*action=[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
        [alertCon addAction:action];
        [self presentViewController:alertCon animated:YES completion:nil];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}







@end

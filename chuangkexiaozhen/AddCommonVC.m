//
//  AddCommonVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/21.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "AddCommonVC.h"

@interface AddCommonVC ()

@end

@implementation AddCommonVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _yunying=[[TuanDuiYunYing alloc]init];
    _yunying.delegate=self;
    
    [_yunying queryParam:_strTitle];
    
    if ([_strTitle isEqualToString:@"高学历人才"])
    {
        _lab1.text=@"人员名称";
        _lab2.text=@"毕业学校";
        _lab3.hidden=YES;
        _lab4.hidden=YES;
        _lab5.hidden=YES;
        _textF3.hidden=YES;
        _textF4.hidden=YES;
        _textF5.hidden=YES;
        _lab6.text=@"学校级别";
        _lab7.text=@"学位级别";
    }
    
    if ([_strTitle isEqualToString:@"社保缴纳"])
    {
        _lab1.text=@"职工人数:";
        _lab2.text=@"投保人数";
        _lab3.text=@"公司账号";
        _lab4.text=@"新增人员名称";
        _lab5.text=@"身份证号码";
        
        _lab6.hidden=YES;
        _lab7.hidden=YES;
        _btn1.hidden=YES;
        _btn2.hidden=YES;
    }

    
    
    
    

}

-(void)afternetwork6:(id)data
{
    _dic=(NSMutableDictionary*)data;

}

- (IBAction)shangchuan:(id)sender {
    
    ImgeUpViewController* imgup=[[ImgeUpViewController alloc] initView];
    [imgup setNotifyName:@"ADDCOMMONFileUp" AndTitle:@"文档上传"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getfile:) name:@"ADDCOMMONFileUp" object:nil];
    [self.navigationController pushViewController:imgup animated:YES];
}

-(void)getfile:(id)data
{
    if(data!=nil){
        NSNotification* tmp=(NSNotification*)data;
        self.photosIDS=(NSString*)tmp.object;
    }
    
}

- (IBAction)btn1Click:(id)sender {
    
    if ([_strTitle isEqualToString:@"高学历人才"])
    {
    NSDictionary*dic=_dic[@"schoolLevel"];
    NSArray*keyAry=[dic allKeys];
    DuoXuanVC*vc=[[DuoXuanVC alloc]init];
    [vc setDanXuan];
    [vc setArray:keyAry btn:(UIButton*)sender];
    [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
    
    
    
}

- (IBAction)btn2Click:(id)sender {
    
    if ([_strTitle isEqualToString:@"高学历人才"])
    {
    NSDictionary*dic=_dic[@"degreeLevel"];
    NSArray*keyAry=[dic allKeys];
    DuoXuanVC*vc=[[DuoXuanVC alloc]init];
    [vc setDanXuan];
    [vc setArray:keyAry btn:(UIButton*)sender];
    [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
    
    
}

- (IBAction)tijiao:(id)sender {
    
    NSMutableDictionary*dic=[NSMutableDictionary dictionary];
     [dic setNotNullObject:_textF1.text forKey:@"name"];
     [dic setNotNullObject:_textF2.text forKey:@"graduateSchool"];
     [dic setNotNullObject:_photosIDS  forKey:@""];
     NSString*str1=[_dic[@"schoolLevel"] objectForKey:_btn1.currentTitle];
     NSString*str2=[_dic[@"degreeLevel"] objectForKey:_btn2.currentTitle];
     [dic setNotNullObject:str1 forKey:@"schoolLevel"];
     [dic setNotNullObject:str2 forKey:@"degreeLevel"];
    
    [_yunying addData:dic withType:_strTitle];
}

-(void)afternetwork4:(id)data
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"COMMONVCADDSUCCESS" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
}










@end

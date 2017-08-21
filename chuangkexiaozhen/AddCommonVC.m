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

    
    
    
    

}

-(void)loadNetworkFinished:(id)data
{
    _dic=(NSMutableDictionary*)data;

}

- (IBAction)shangchuan:(id)sender {
    
    
    
}


- (IBAction)btn1Click:(id)sender {
    
    NSDictionary*dic=_dic[@"schoolLevel"];
    NSArray*keyAry=[dic allKeys];
    DuoXuanVC*vc=[[DuoXuanVC alloc]init];
    [vc setDanXuan];
    [vc setArray:keyAry btn:(UIButton*)sender];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)btn2Click:(id)sender {
    
    NSDictionary*dic=_dic[@"degreeLevel"];
    NSArray*keyAry=[dic allKeys];
    DuoXuanVC*vc=[[DuoXuanVC alloc]init];
    [vc setDanXuan];
    [vc setArray:keyAry btn:(UIButton*)sender];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)tijiao:(id)sender {
    
    NSMutableDictionary*dic=[NSMutableDictionary dictionary];
    
    
    
    
    [_yunying addData:dic withType:_strTitle];
}












@end

//
//  EditShiTiVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/9.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "EditShiTiVC.h"

@interface EditShiTiVC ()

@end

@implementation EditShiTiVC

-(void)setShuJu:(NSString*)strId infoAry:(NSArray *)ary
{
    _strID=[NSString stringWithString:strId];
// _array=[NSArray arrayWithObject:ary];//数组一个整体，当新数组的一个元素
   
     _array=[NSArray arrayWithArray:ary];//把原数组的5个元素直接复制给新数组
   
//    - (void)addObject:(ObjectType)anObject;object作为一个整体，做一个新元素
//    - (void)addObjectsFromArray:把原数组的元素个数直接复制给新数组
   
    
}


- (void)viewDidLoad {
    self.navigationItem.title=@"实体入驻";
    self.rightbutton=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(tijiaoClick:)];
    self.rightbutton.tintColor=[UIColor whiteColor];
    self.rightbutton.enabled=NO;
    self.navigationItem.rightBarButtonItem=self.rightbutton;
    [super viewDidLoad];
    
    
    _shiti=[[ShiTiRuZhuGuanLi alloc]init];
    _shiti.delegate=self;

    //显示对应的值
    _textF1.text=[_array objectAtIndex:0];
    _textF2.text=[_array objectAtIndex:1];
    _textF3.text=[_array objectAtIndex:2];
   
    NSString*str1=[_array objectAtIndex:3];
    NSString*str2=[_array objectAtIndex:4];

     [_btn1 setTitle:str1 forState:UIControlStateNormal];
     [_btn2 setTitle:str2 forState:UIControlStateNormal];
}





- (IBAction)btn1Click:(id)sender {
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComboViewController*vc=[storyboard instantiateViewControllerWithIdentifier:@"ComboViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"电子信息",@"生物医药",@"新材料",@"互联网和移动互联网",@"先进制造",@"新能源及节能环保",@"科技服务业",@"农业科技",@"艺术文化",@"电子商务",@"创投孵化", nil];
    [vc setDatas:array withBtn:sender];
    vc.navigationItem.title=@"所属行业";
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)btn2Click:(id)sender {
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComboViewController*vc=[storyboard instantiateViewControllerWithIdentifier:@"ComboViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"初创团队",@"小微企业",@"加速企业",nil];
    [vc setDatas:array withBtn:sender];
    vc.navigationItem.title=@"团队描述";
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)tijiaoClick:(id)sender {
    
    /*
     2.7 修改请求
     提交修改后的请求 http://116.228.176.34:9002/chuangke-serve/apply/update/apply
     参数：businessLine	电子信息
     companyName	克里斯蒂
     contact	浮动浮动
     contactType	354657648611
     description	初创团队
     id	597af69d80ab5e6790d5243d
     */

    NSMutableDictionary*dic=[NSMutableDictionary dictionary];
     [dic setNotNullStrObject:_textF1.text forKey:@"contact"];
     [dic setNotNullStrObject:_textF2.text forKey:@"contactType"];
     [dic setNotNullStrObject:_textF3.text forKey:@"companyName"];
     [dic setNotNullStrObject:_btn1.currentTitle forKey:@"businessLine"];
     [dic setNotNullStrObject:_btn2.currentTitle forKey:@"description"];
     [dic setNotNullStrObject:_strID forKey:@"id"];

    [_shiti ShiTiRuZhuModify:dic];
}

-(void)afternetwork7:(id)data
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"XIUGAIXINXISUCCESS" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}



@end

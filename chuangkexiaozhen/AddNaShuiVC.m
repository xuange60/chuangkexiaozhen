//
//  AddNaShuiVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/4.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "AddNaShuiVC.h"
#import "ImgeUpViewController.h"
@interface AddNaShuiVC ()

@end

@implementation AddNaShuiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"添加纳税管理";
    _mArray=[NSMutableArray array];//保存展示数据
    _Mstr=[NSMutableString string];//用于图片id连接
    _photosIDS=[NSString string];
    _fuHua=[[FuHusChengZhangGuanLi alloc]init];
    _fuHua.delegate=self;
    
}

- (IBAction)Btn2Click:(id)sender {
    
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComboViewController*vc=[storyboard instantiateViewControllerWithIdentifier:@"ComboViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"纳税季度级别",@"纳税年度级别",nil];
    [vc setDatas:array withBtn:sender];
    vc.navigationItem.title=@"纳税级别";
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)Btn3Click:(id)sender {
    
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComboViewController*vc=[storyboard instantiateViewControllerWithIdentifier:@"ComboViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"1000元级别",@"5000元级别",@"10000元级别", @"100000元级别",@"500000元级别",nil];
    [vc setDatas:array withBtn:sender];
    vc.navigationItem.title=@"纳税金额级别";
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)ShangChuan:(id)sender {
    
    ImgeUpViewController* imgup=[[ImgeUpViewController alloc] initView];
    [imgup setNotifyName:@"FuWuShenQingAddViewControllerFileUp" AndTitle:@"文档上传"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getfile:) name:@"FuWuShenQingAddViewControllerFileUp" object:nil];
    [self.navigationController pushViewController:imgup animated:YES];
}

-(void)getfile:(id)data
{
    if(data!=nil){
        NSNotification* tmp=(NSNotification*)data;
        
        self.photosIDS=(NSString*)tmp.object;
    }
    
}

- (IBAction)TiJiao:(id)sender {
    
    NSMutableDictionary*dic=[NSMutableDictionary dictionary];
    /*
     7.8.2 纳税管理添加
     请求 post    http://116.228.176.34:9002/chuangke-serve/market/tax/save
     参数：
     时间类别 dateType 纳税季度级别
     纳税金额级别 taxLevel 58c7c76a4c1aa99f4a904e8a
     纳税金额 taxPrice 100
     taxResourceIds 59809eeb80ab5e6790d536d7
     纳税对象 taxTarget 1111
     纳税类别 taxType 111
     */
    
    [dic setObject:_btn2Title.currentTitle forKey:@"dateType"];
    [dic setObject:_btn3Title.currentTitle forKey:@"taxLevel"];
    
    int value1=[_jinE.text intValue];
    NSNumber*jinE= [NSNumber numberWithInt:value1];
    [dic setObject:jinE forKey:@"taxPrice"];
    
    [dic setObject:_duiXiang.text forKey:@"taxTarget"];
    [dic setObject:_leiBie.text forKey:@"taxTarget"];

    [dic setObject:_photosIDS forKey:@"taxResourceIds"];
    
    [_fuHua NaShuiGuanLiSubmit:dic];
    
}

-(void)addData:(id)data
{
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ADDNASHUISUCCESS" object:nil];
    
}

@end

//
//  AddRenYuanVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/5.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "AddRenYuanVC.h"
#import "ImgeUpViewController.h"
@interface AddRenYuanVC ()

@end

@implementation AddRenYuanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"人员结构管理";
    self.rightbutton=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(TiJiao:)];
    self.rightbutton.tintColor=[UIColor whiteColor];
    self.rightbutton.enabled=NO;
    self.navigationItem.rightBarButtonItem=self.rightbutton;
    
    _mArray=[NSMutableArray array];//保存展示数据
    _Mstr=[NSMutableString string];//用于图片id连接
    _photosIDS=[NSString string];
    _fuHua=[[FuHusChengZhangGuanLi alloc]init];
    _fuHua.delegate=self;
    
    
    [self receiveCurrentViewController:self];
}

- (IBAction)ShangChuan:(id)sender {
    
    ImgeUpViewController* imgup=[[ImgeUpViewController alloc] initView];
    [imgup setNotifyName:@"ADDRENYUANJIEGOUVCFileUp" AndTitle:@"文档上传"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getfile:) name:@"ADDRENYUANJIEGOUVCFileUp" object:nil];
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
     7.10.2 人员结构添加
     请求 post http://116.228.176.34:9002/chuangke-serve/personaldistribution/save
     市场人员数 marketPerson 1
     市场人员占比 marketPersonPercent 50.00
     运营人员数 operatePerson 2
     运营人员占比 operatePersonPercent 100.00
     resourceIds 5980a57580ab5e6790d536dd,5980a57880ab5e6790d536de
     技术人员数 techniquePerson 1
     技术人员占比 techniquePersonPercent 50.00
     总人数 toltalPerson 2
     响应：{"actionid":"","result":1,"errorcode":null,"desc":"","obj":null,"objid":null,"action":null,"recordsTotal"
     :0,"recordsFiltered":0,"totalPages":0}
     */
    
    [dic setNotNullStrObject:_totalNum.text forKey:@"toltalPerson"];
    [dic setNotNullStrObject:_shichangNum.text forKey:@"marketPerson"];
    [dic setNotNullStrObject:_shichangPercent.text forKey:@"marketPersonPercent"];
    [dic setNotNullStrObject:_jishuNum.text forKey:@"techniquePerson"];
    [dic setNotNullStrObject:_jishuPercent.text forKey:@"techniquePersonPercent"];
    [dic setNotNullStrObject:_yunyingNum.text forKey:@"operatePerson"];
    [dic setNotNullStrObject:_yunyingPercent.text forKey:@"operatePersonPercent"];
    
    

    [dic setNotNullObject:_photosIDS forKey:@"resourceIds"];
    

    [_fuHua RenYuanJieGouSubmit:dic];
    
}

-(void)addData:(id)data
{
    
    NSNumber*num=(NSNumber*)data;
    int result=[num intValue];
    
    if (result==1)
    {
        [self tiShiKuangDisplay:submitStr viewController:self];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"ADDRENYUANJIEGOUSUCCESS" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

@end

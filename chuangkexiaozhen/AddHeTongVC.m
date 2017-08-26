//
//  AddHeTongVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/4.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "AddHeTongVC.h"
#import "ComboViewController.h"

@interface AddHeTongVC ()

@end

@implementation AddHeTongVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"添加销售合同";
    _mArray=[NSMutableArray array];//保存展示数据
    _Mstr=[NSMutableString string];//用于图片id连接
    _photosIDS=[NSString string];
    _fuHua=[[FuHusChengZhangGuanLi alloc]init];
    _fuHua.delegate=self;
    
}

- (IBAction)Btn1Click:(id)sender {
    
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComboViewController*vc=[storyboard instantiateViewControllerWithIdentifier:@"ComboViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"一级合作方",@"二级合作方",@"三级合作方", nil];
    [vc setDatas:array withBtn:sender];
    vc.navigationItem.title=@"合作方级别";
    [self.navigationController pushViewController:vc animated:YES];

}
- (IBAction)Btn2Click:(id)sender {
    
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComboViewController*vc=[storyboard instantiateViewControllerWithIdentifier:@"ComboViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"1万",@"10万",@"50万",@"100万",@"200万",@"500万",@"1000万",@"10000万", nil];
    [vc setDatas:array withBtn:sender];
    vc.navigationItem.title=@"合作金额级别";
    [self.navigationController pushViewController:vc animated:YES];

}
- (IBAction)Btn3Click:(id)sender {
    
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComboViewController*vc=[storyboard instantiateViewControllerWithIdentifier:@"ComboViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"100元级别",@"1000元级别",@"10000元级别", @"100000元级别",nil];
    [vc setDatas:array withBtn:sender];
    vc.navigationItem.title=@"合作社会效益级别";
    [self.navigationController pushViewController:vc animated:YES];

}

- (IBAction)ShangChuan:(id)sender {
    
    ImgeUpViewController* imgup=[[ImgeUpViewController alloc] initView];
    [imgup setNotifyName:@"ADDHETONGVCFileUp" AndTitle:@"文档上传"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getfile:) name:@"ADDHETONGVCFileUp" object:nil];
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
     7.7.2 销售合同添加
     请求 post http://116.228.176.34:9002/chuangke-serve/market/sale/save
     到账凭证 arrivalResourceIds 59809b8c80ab5e6790d536d1,59809b9080ab5e6790d536d2
     效益凭证 benefitResourceIds 59809b8880ab5e6790d536d0
     销售合同名称 pactName 销售合同1
     合作方级别 partnerLevel 58c7c4364c1ac54a5ee9d6cf
     合作金额 partnerPrice 10
     社会效益级别 saleBenefit 594b2a07d8937c61240af528
     金额级别 saleMoney 58c7c7324c1a83778c59df76
     社会效益 societyBenefit 100
*/
    [dic setNotNullStrObject:_name.text forKey:@"pactName"];
    [dic setNotNullStrObject:_btn1Title.currentTitle forKey:@"partnerLevel"];
    [dic setNotNullStrObject:_jinE.text forKey:@"partnerPrice"];
    [dic setNotNullStrObject:_btn3Title.currentTitle forKey:@"saleBenefit"];
    [dic setNotNullStrObject:_btn2Title.currentTitle forKey:@"saleMoney"];
    [dic setNotNullStrObject:_xiaoYi.text forKey:@"societyBenefit"];
    [dic setNotNullStrObject:_photosIDS forKey:@"arrivalResourceIds"];
    [dic setNotNullStrObject:@"" forKey:@"benefitResourceIds"];
    
    [_fuHua XiaoShouHeTongSubmit:dic];
    
    
}

-(void)addData:(id)data
{
    NSLog(@"%s",__func__);
    
    NSNumber*num=(NSNumber*)data;
    int result=[num intValue];
    
    if (result==1)
    {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ADDHETONGSUCCESS" object:nil];
    [self.navigationController popViewControllerAnimated:YES];

    }
    NSLog(@"%s",__func__);
}

@end

//
//  AddZhanYouLuVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/5.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "AddZhanYouLuVC.h"

@interface AddZhanYouLuVC ()

@end

@implementation AddZhanYouLuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"添加占有率管理";
    self.rightbutton=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(TiJiao:)];
    self.rightbutton.tintColor=[UIColor whiteColor];
    self.rightbutton.enabled=NO;
    self.navigationItem.rightBarButtonItem=self.rightbutton;
    
    _mArray=[NSMutableArray array];//保存展示数据
    _Mstr=[NSMutableString string];//用于图片id连接
    _photosIDS=[NSString string];
    _fuHua=[[FuHusChengZhangGuanLi alloc]init];
    _fuHua.delegate=self;
    [self paramsQuery:@"/market/market/new"];
    [self receiveCurrentViewController:self];
}

- (IBAction)Btn3Click:(id)sender {
    
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Commons" bundle:nil];
    ComboViewController*vc=[storyboard instantiateViewControllerWithIdentifier:@"ComboViewController"];
    NSArray* array=[[NSArray alloc]initWithObjects:@"占有率级别5%",@"占有率级别20%",@"占有率级别50%", @"占有率级别80%",nil];
    [vc setDatas:array withBtn:sender];
    vc.navigationItem.title=@"占有率级别";
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)ShangChuan:(id)sender {
    
    ImgeUpViewController* imgup=[[ImgeUpViewController alloc] initView];
    [imgup setNotifyName:@"ADDSHICHANGZHANYOUFileUp" AndTitle:@"文档上传"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getfile:) name:@"ADDSHICHANGZHANYOUFileUp" object:nil];
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
     7.9.2 市场占有率添加
     请求 post http://116.228.176.34:9002/chuangke-serve/market/market/save
     参数
     调查凭证 investigateResourceIds 5980a0f580ab5e6790d536d9,5980a0f980ab5e6790d536da
     细分市场 marketDetail 1111
     市场占有率 marketPercent 20
     调查机构 organizationName 1111
     市场占有率级别 percentLevel 58c7c79c4c1a0ef1bf3d5749
     
     */
    
    [dic setNotNullStrObject:[(NSDictionary*)[self.tmpparams objectForKey:@"percentLevel"] objectNotNullForKey:_btn3Title.currentTitle] forKey:@"percentLevel"];
    [dic setNotNullStrObject:_xifenshichang.text forKey:@"marketDetail"];
    [dic setNotNullStrObject:_zhanyoulu.text forKey:@"marketPercent"]; //录入数据时，20%要输如20
    [dic setNotNullStrObject:_renzhengjigou.text forKey:@"organizationName"];
    
    

    [dic setNotNullStrObject:_photosIDS forKey:@"investigateResourceIds"];
    
    [_fuHua ShiChangZhanYouSubmit:dic];
    
}

-(void)addData:(id)data
{
    
//    NSDictionary*dic;
//    [dic setValue:<#(nullable id)#> forKey:<#(nonnull NSString *)#>];
    
    NSNumber*num=(NSNumber*)data;
    int result=[num intValue];
    
    if (result==1)
    {
        [self tiShiKuangDisplay:submitStr viewController:self];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ADDSHICHANGZHANYOUSUCCESS" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
    }
}

@end

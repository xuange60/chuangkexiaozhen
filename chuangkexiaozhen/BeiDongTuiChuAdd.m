//
//  BeiDongTuiChuAdd.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/20.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BeiDongTuiChuAdd.h"

@interface BeiDongTuiChuAdd ()

@end

@implementation BeiDongTuiChuAdd

- (void)viewDidLoad {
    self.navigationItem.title=@"被动退出";
    self.rightbutton=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(tijiaoClicked:)];
    self.rightbutton.tintColor=[UIColor whiteColor];
    self.rightbutton.enabled=NO;
    self.navigationItem.rightBarButtonItem=self.rightbutton;
    
    [super viewDidLoad];
    _beidongtuichu=[[BeiDongTuiChu alloc] init];
    _beidongtuichu.delegate=self;
    [self tenantparamQuery];
    
    [self receiveCurrentViewController:self];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tijiaoClicked:(id)sender {
    NSMutableDictionary*dic=[NSMutableDictionary dictionary];
    NSString* tenatis=[_companys objectNotNullForKey:[_quitCompany currentTitle]];
    [dic setNotNullObject:tenatis forKey:@"tenants"];
    [dic setNotNullObject:_quitDate.text forKey:@"quitDateStr"];
    [dic setNotNullObject:_quitCause.text forKey:@"quitCause"];
    [dic setNotNullObject:@"unactive" forKey:@"quitProperty"];
    [dic setNotNullObject:[_quitType currentTitle] forKey:@"quitType"];
    [dic setNotNullObject:_resourceIds forKey:@"resourceIds"];
    
    [_beidongtuichu BeiDongTuiChuAdd:dic];
}

-(void)afternetwork4:(id)data
{
    int result=[(NSNumber*)data intValue];
    
    if (result==1)
    {
        [self tiShiKuangDisplay:submitStr viewController:self];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BeiDongTuiChuVC" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


-(void)tenantparamQuery
{
    if(_companys==nil || [[_companys allKeys] count]==0)
    {
        [_beidongtuichu BeiDongTuiChuParamQuery];
    }

}


-(void)afternetwork6:(id)data
{
    _companys=[(NSDictionary*)data objectForKey:@"tenants"];
    if(_companys==nil){
        _companys=[NSDictionary dictionary];
    }
}

- (IBAction)companyclick:(id)sender {
    DuoXuanVC* add=[[DuoXuanVC alloc] init];
    NSArray* keys=[_companys allKeys];
    [add setArray:keys btn:sender];
    [add setNavTitle:@"选择退出公司"];
    [add setDanXuan];
    NSString* curtitle=[_quitType currentTitle];
    if(curtitle!=nil){
        [add setSelectedData:[NSMutableArray arrayWithObject:curtitle]];
    }
    
    [self.navigationController pushViewController:add animated:YES];
}


- (IBAction)typeclick:(id)sender {
    DuoXuanVC* add=[[DuoXuanVC alloc] init];
    NSArray* keys=[NSArray arrayWithObjects:@"整体",@"局部", nil];
    [add setArray:keys btn:sender];
    [add setNavTitle:@"选择退出类型"];
    [add setDanXuan];
    NSString* curtitle=[_quitType currentTitle];
    if(curtitle!=nil){
        [add setSelectedData:[NSMutableArray arrayWithObject:curtitle]];
    }
    
    [self.navigationController pushViewController:add animated:YES];
}



//点击文件上传按钮 modify
- (IBAction)fileup:(id)sender {
    
    ImgeUpViewController* imgup=[[ImgeUpViewController alloc] initView];
    [imgup setNotifyName:@"ZhuDongTuiChuAddVCFileUp" AndTitle:@"文档上传"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getfile:) name:@"ZhuDongTuiChuAddVCFileUp" object:nil];
    [self.navigationController pushViewController:imgup animated:YES];
}

-(void)getfile:(id)data
{
    if(data!=nil){
        NSNotification* tmp=(NSNotification*)data;
        self.resourceIds=(NSString*)tmp.object;
    }
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

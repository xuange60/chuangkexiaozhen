//
//  ZhuDongTuiChuAddVC.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/16.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "ZhuDongTuiChuAddVC.h"

@interface ZhuDongTuiChuAddVC ()

@end

@implementation ZhuDongTuiChuAddVC

- (void)viewDidLoad {
    self.navigationItem.title=@"主动退出";
    self.rightbutton=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(tijiaoClicked:)];
    self.rightbutton.tintColor=[UIColor whiteColor];
    self.rightbutton.enabled=NO;
    self.navigationItem.rightBarButtonItem=self.rightbutton;
    
    [super viewDidLoad];
    _zhudongtuichu=[[ZhuDongTuiChu alloc] init];
    _zhudongtuichu.delegate=self;
    NSUserDefaults* userdefault=[NSUserDefaults standardUserDefaults];
    NSDictionary* userdic=[userdefault objectForKey:@"chuangkexiaozhen.userinfo"];
    _company=[userdic objectNotNullForKey:@"companytitle"];
    _tenants=[userdic objectNotNullForKey:@"companyid"];
    _quitCompany.text=_company;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tijiaoClicked:(id)sender {
    
    NSMutableDictionary*dic=[NSMutableDictionary dictionary];
    [dic setNotNullStrObject:_tenants forKey:@"tenants"];
    [dic setNotNullStrObject:_quitDate.text forKey:@"quitDateStr"];
    [dic setNotNullStrObject:_quitCause.text forKey:@"quitCause"];
    [dic setNotNullStrObject:@"active" forKey:@"quitProperty"];
    [dic setNotNullStrObject:[_quitType currentTitle] forKey:@"quitType"];
    [dic setNotNullStrObject:_resourceIds forKey:@"resourceIds"];

    
    [_zhudongtuichu ZhuDongTuiChuAdd:dic];
}

-(void)afternetwork4:(id)data
{
    int result=[(NSNumber*)data intValue];
    
    if (result==1)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ZhuDongTuiChuVC" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }

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

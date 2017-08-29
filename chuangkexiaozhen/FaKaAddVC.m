//
//  FaKaAddVC.m
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/14.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "FaKaAddVC.h"

@interface FaKaAddVC ()

@end

@implementation FaKaAddVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"发卡";
    self.rightbutton=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(add:)];
    self.rightbutton.tintColor=[UIColor whiteColor];
    self.rightbutton.enabled=NO;
    self.navigationItem.rightBarButtonItem=self.rightbutton;
    _fakaguanli=[[FaKaGuanli alloc] init];
    _fakaguanli.delegate=self;
    [self queryParam];
    // Do any additional setup after loading the view.
}

-(void)queryParam
{
    [_fakaguanli FaKaParamMapQuery];
}

-(void) afternetwork6:(id)data
{
    _tenanids=[(NSDictionary*)data objectForKey:@"tenantId"];
    NSLog(@"%@",_tenanids);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)teamclick:(id)sender {
 //   UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"ZiYuanPeiZhi" bundle:nil];
    _names=[NSDictionary dictionary];
    [_name setTitle:@"" forState:UIControlStateNormal];
    
    DuoXuanVC* add=[[DuoXuanVC alloc] init];
    NSArray* keys=[_tenanids allKeys];
    [add setArray:keys btn:sender];
    [add setNavTitle:@"选择企业团队"];
    [add setDanXuan];
    [self.navigationController pushViewController:add animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self QueryNames];
}


-(void)QueryNames
{
    NSString* tenaid=[_tenanids objectNotNullForKey:[_tena currentTitle]];
    if(tenaid!=nil && [tenaid length]>0){

        [_fakaguanli QueryUsers:tenaid];
    }

}

-(void)afternetwork8:(id)data
{
    _names=(NSDictionary*)data;
}


- (IBAction)nameclick:(id)sender {
    DuoXuanVC* add=[[DuoXuanVC alloc] init];
    NSArray* keys=[_names allKeys];
    [add setArray:keys btn:sender];
    [add setNavTitle:@"选择用户"];
    [add setDanXuan];
    [self.navigationController pushViewController:add animated:YES];
}


- (IBAction)add:(id)sender {
    NSString* userId=[_names objectNotNullForKey:[_name currentTitle]];
    NSString* tenantId=[_tenanids objectNotNullForKey:[_tena currentTitle]];
    NSString* cardNumber=_card.text;
    
    NSDictionary* param=[NSDictionary dictionaryWithObjectsAndKeys:userId,@"userId",tenantId,@"tenantId",cardNumber,@"cardNumber",@"",@"resourceIds", nil];
    [_fakaguanli FaKaAdd:param];
    
}

//modify
-(void)afternetwork4:(id)data
{
    NSNumber* num=(NSNumber*)data;
    int result=[num intValue];
    if(1==result){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FaKaGuanLiVC" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        UIAlertController*alertCon=[UIAlertController alertControllerWithTitle:@"提示" message:@"提交失败" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*action2=[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [alertCon addAction:action2];
        [self presentViewController:alertCon animated:YES completion:nil];
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

//
//  AddGenZong.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/21.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "AddGenZong.h"

@interface AddGenZong ()

@end

@implementation AddGenZong

- (void)viewDidLoad {
    self.navigationItem.title=@"成果跟踪";
    self.rightbutton=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(tijiao:)];
    self.rightbutton.tintColor=[UIColor whiteColor];
    self.rightbutton.enabled=NO;
    self.navigationItem.rightBarButtonItem=self.rightbutton;
    
    [super viewDidLoad];
    _genzong=[[ChengGuoGenZong alloc]init];
    _genzong.delegate=self;
    [_genzong ChengGuoGenZongParamQuery];
}

-(void)afternetwork6:(id)data
{
    _dic=(NSMutableDictionary*)data;
}




- (IBAction)luyanBtnClick:(id)sender {
    
    /*
     2.19.2 成果跟踪添加时参数查询
     http://116.228.176.34:9002/chuangke-serve/report/add
     {
     "roadshows" : {
     "123422" : "58e7555e11c7b2939aa7a0fa",
     "*********" : "5949ea52075910c2d60d08c6",
     "农创路演" : "593620bc075910c2d60d079a",
     "32" : "594b916c11c75eb6d41272f8",
     "扫除" : "594b8ffe11c740f6a57510b2",
     "123" : "58e7554611c7b2939aa7a0f9",
     "33" : "594b93eb11c7cca4e070230a",
     "12" : "58e75a0c11c7b2939aa7a0fb",
     "44" : "594b974611c7350a7bdac16e",
     "项目研讨会" : "596b820b80ab5e6790d4f05a",
     "122" : "58e75a4111c7b2939aa7a0fc",
     "三三枫会" : "595217ad07591472f0d1d054",
     "ff" : "594b924f11c79f358ae29fa2",
     "1234" : "594b6b9d075910c2d60d08e4",
     "ss" : "594b90c911c7dae9a86fb4b4"
     }
     }
     */

    
    NSDictionary*dic=[_dic objectForKey:@"roadshows"];
    NSArray*aryKey=[dic allKeys];
    DuoXuanVC*vc=[[DuoXuanVC alloc]init];
    [vc setDanXuan];
    [vc setArray:aryKey btn:(UIButton*)sender];
    [self.navigationController pushViewController:vc animated:YES];

}

- (IBAction)shangchuan:(id)sender {
    
    ImgeUpViewController* imgup=[[ImgeUpViewController alloc] initView];
    [imgup setNotifyName:@"ADDGENZONGFileUp" AndTitle:@"文档上传"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getfile:) name:@"ADDGENZONGFileUp" object:nil];
    [self.navigationController pushViewController:imgup animated:YES];
}
    
    -(void)getfile:(id)data
    {
        if(data!=nil){
            NSNotification* tmp=(NSNotification*)data;
            
            _photoIds=(NSString*)tmp.object;
        }
        
    }

- (IBAction)tijiao:(id)sender {
    
    
    /*
     2.19.3 成果跟踪提交
     http://116.228.176.34:9002/chuangke-serve/report/save
     name	1111
     resourceIds
     roadshows	58e7554611c7b2939aa7a0f9
     */
    
    NSMutableDictionary*dic=[NSMutableDictionary dictionary];
    
    [dic setNotNullObject:_baogaoName.text forKey:@"name"];

    NSString*str=[dic objectForKey:_luyanName.currentTitle];
    [dic setNotNullObject:str forKey:@"roadshows"];
    
    
    [dic setNotNullObject:_photoIds forKey:@"resourceIds"];

    [_genzong ChengGuoGenZongAdd:dic];

}

-(void)afternetwork4:(id)data
{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ADDGENZONGSUCCESS" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}












@end

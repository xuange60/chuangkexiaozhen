//
//  AddBaoXiaoVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/20.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "AddBaoXiaoVC.h"

@interface AddBaoXiaoVC ()

@end

@implementation AddBaoXiaoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"添加";
    self.rightbutton=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(tijiao:)];
    self.rightbutton.tintColor=[UIColor whiteColor];
    self.rightbutton.enabled=NO;
    self.navigationItem.rightBarButtonItem=self.rightbutton;
    
    [self receiveCurrentViewController:self];
    
    /*
     2.18.2 活动报销前查询所有活动，查询审批人，查询申请人
     http://116.228.176.34:9002/chuangke-serve/expense/add
     {
     "approver" : {
     "顾一琳" : "58e5c52c19eb26b288dc9753",
     "王俊" : "5875a60bee19799d1cc83824",
     "王博雅" : "58e7316c19eb5e6b9401247e"
     },
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
     },
     "proposer" : {
     "顾一琳" : "58e5c52c19eb26b288dc9753",
     "王俊" : "5875a60bee19799d1cc83824",
     "王博雅" : "58e7316c19eb5e6b9401247e"
     },
     "category" : {
     "其他" : "其他",
     "餐饮" : "餐饮",
     "场地" : "场地",
     "交通" : "交通",
     "住宿" : "住宿"
     }
     }
     
     */
  
    _baoxiao=[[HuoDongBaoXiao alloc]init];
    _baoxiao.delegate=self;
    
    [_baoxiao HuoDongBaoXiaoParamQuery];
    
}
-(void)afternetwork6:(id)data
{
    _dic=(NSMutableDictionary*)data;
}

- (IBAction)luyanBtnClick:(id)sender {
    
    NSDictionary*dic=[_dic objectForKey:@"roadshows"];
    NSArray*aryKey=[dic allKeys];
    DuoXuanVC*vc=[[DuoXuanVC alloc]init];
    [vc setDanXuan];
    [vc setArray:aryKey btn:(UIButton*)sender];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)leibieBtnClick:(id)sender {
    
    NSDictionary*dic=[_dic objectForKey:@"category"];
    NSArray*aryKey=[dic allKeys];
    DuoXuanVC*vc=[[DuoXuanVC alloc]init];
    [vc setDanXuan];
    [vc setArray:aryKey btn:(UIButton*)sender];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)shangchuan:(id)sender {
    ImgeUpViewController* imgup=[[ImgeUpViewController alloc] initView];
    [imgup setNotifyName:@"ADDBAOXIAOFileUp" AndTitle:@"文档上传"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getfile:) name:@"ADDBAOXIAOFileUp" object:nil];
    [self.navigationController pushViewController:imgup animated:YES];
}

-(void)getfile:(id)data
{
    if(data!=nil){
        NSNotification* tmp=(NSNotification*)data;
        
        __photoIds=(NSString*)tmp.object;
    }
    
}


- (IBAction)shenpiBtnClick:(id)sender {
    NSDictionary*dic=[_dic objectForKey:@"approver"];
    NSArray*aryKey=[dic allKeys];
    DuoXuanVC*vc=[[DuoXuanVC alloc]init];
    [vc setArray:aryKey btn:(UIButton*)sender];
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)shenqingBtnClick:(id)sender {
    
    NSDictionary*dic=[_dic objectForKey:@"proposer"];
    NSArray*aryKey=[dic allKeys];
    DuoXuanVC*vc=[[DuoXuanVC alloc]init];
    [vc setArray:aryKey btn:(UIButton*)sender];
    [self.navigationController pushViewController:vc animated:YES];
}



- (IBAction)tijiao:(id)sender {
    
    /*
     2.18.3 活动报销添加
     http://116.228.176.34:9002/chuangke-serve/expense/save
     审批人 approver	58e5c52c19eb26b288dc9753
     种类 category	住宿
     内容 content	2222
     申请人 proposer	5875a60bee19799d1cc83824
     resourceIds
     活动种类 roadshows	58e7555e11c7b2939aa7a0fa
     金额 totalPrice	300
     */
    NSMutableDictionary*dic=[NSMutableDictionary dictionary];
    
    
    [dic setNotNullObject:_mingxi.text forKey:@"content"];
    [dic setNotNullObject:_money.text forKey:@"totalPrice"];
    [dic setNotNullObject:__photoIds forKey:@"resourceIds"];
    NSDictionary*dicLu=[_dic objectForKey:@"roadshows"];
    [dic setNotNullObject:[dicLu objectForKey:_luyanBtn.currentTitle] forKey:@"roadshows"];
    
     NSDictionary*dicLei=[_dic objectForKey:@"category"];
    [dic setNotNullObject:[dicLei objectForKey:_baoxiaoLevel.currentTitle] forKey:@"category"];

    
    NSDictionary*dicPi=[_dic objectForKey:@"approver"];
    NSMutableArray*arry=[NSMutableArray array];
    NSArray*ary=[_shenpiBtn.currentTitle componentsSeparatedByString:@","];
    for (NSString*str in ary)
    {
       NSString*str2=[dicPi objectForKey:str];
        [arry addObject:str2];
    }
    [dic setNotNullObject:arry forKey:@"approver"];

    NSDictionary*dicQing=[_dic objectForKey:@"proposer"];
    NSMutableArray*arry2=[NSMutableArray array];
    NSArray*ary2=[_shenqingBtn.currentTitle componentsSeparatedByString:@","];
    for (NSString*str in ary2)
    {
        NSString*str2=[dicQing objectForKey:str];
        [arry2 addObject:str2];
    }
    [dic setNotNullObject:arry2 forKey:@"proposer"];

    
    [_baoxiao HuoDongBaoXiaoAdd:dic];
}

-(void)afternetwork4:(id)data
{
    
    [self tiShiKuangDisplay:submitStr viewController:self];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ADDBAOXIAOSUCCESS" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}





















@end

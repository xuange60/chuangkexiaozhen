//
//  EditZiYuanPeiZhiVC.m
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/12.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "EditZiYuanPeiZhiVC.h"

@interface EditZiYuanPeiZhiVC ()

@end

@implementation EditZiYuanPeiZhiVC

-(void)setStr:(NSString *)strId infoAry:(NSArray *)ary
{
    _strID=[NSString stringWithString:strId];
    _ary=[NSArray arrayWithArray:ary];
}

- (void)viewDidLoad {

    
    self.rightbutton=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(tijiaoClick:)];
    self.rightbutton.tintColor=[UIColor whiteColor];
    self.rightbutton.enabled=NO;
    self.navigationItem.rightBarButtonItem=self.rightbutton;
    [super viewDidLoad];
    
    
    [self receiveCurrentViewController:self];
    
    _ziyuan=[[ZiYuanPeiZhiGuanLi alloc]init];
    _ziyuan.delegate=self;
    
    if([_isInit isEqualToString:@"Y"]){
        self.navigationItem.title=@"资源配置初始化";
        [_ziyuan ZiYuanGuanLiInitQuery:_strID];
    }else{
        self.navigationItem.title=@"资源配置修改";
        [_ziyuan ZiYuanGuanLiDetailQuery:_strID];

    }
    
    

    
    _chushiDuiXiang.text=[_ary lastObject];
    
    _numberOfOffice.text=[_ary objectAtIndex:0];
    [_ofoCodes setTitle:[_ary objectAtIndex:1] forState:UIControlStateNormal];
    
    _numberOftc.text=[_ary objectAtIndex:2];
    [_TcCodes setTitle:[_ary objectAtIndex:3] forState:UIControlStateNormal];
    
    _numberOfoe.text=[_ary objectAtIndex:4];
    [_OeCodes setTitle:[_ary objectAtIndex:5] forState:UIControlStateNormal];
    
    _printAccount.text=[_ary objectAtIndex:6];
    _printPassword.text=[_ary objectAtIndex:7];
    
    _numberOfegc.text=[_ary objectAtIndex:8];
    [_EgcCodes setTitle:[_ary objectAtIndex:9] forState:UIControlStateNormal];
    
    _numberOfpl.text=[_ary objectAtIndex:10];
    [_PlCodes setTitle:[_ary objectAtIndex:11] forState:UIControlStateNormal];
    
    _name.text=[_ary objectAtIndex:12];
    _concatType.text=[_ary objectAtIndex:13] ;
}

-(void)afternetwork3:(id)data
{
    _dicM=(NSMutableDictionary*)data;
}

//办公位对应资产编号选择
- (IBAction)btnOFOclick:(id)sender {
//    "ofoCodes" : {
//        "KCXZ-GW0001" : "KCXZ-GW0001",
//        "KCXZ-GW0004" : "KCXZ-GW0004",
//        "Q1" : "Q1",
//        "KCXZ-GW0003" : "KCXZ-GW0003",
//        "KCXZ-GW0002" : "KCXZ-GW0002",
//        "KCXZ-GW0005" : "KCXZ-GW0005"
//    },
    
    NSDictionary*dicOFO=[_dicM objectForKey:@"ofoCodes"];
    NSArray*aryKeys=[dicOFO allKeys];
    DuoXuanVC*vc=[[DuoXuanVC alloc]init];
    [vc setArray:aryKeys btn:(UIButton*)sender];
    [self.navigationController pushViewController:vc animated:YES];
    
}

//桌椅对应资产编号选择
- (IBAction)btnTCclick:(id)sender {
    
//    "TcCodes" : {
//        "3" : "597d815980ab5e6790d52d51",
//        "1" : "597d814c80ab5e6790d52d4f",
//        "KCXZ-CW0005" : "58f58e5119eb8cbffbb87ad5",
//        "4" : "597d815f80ab5e6790d52d52",
//        "2" : "597d815480ab5e6790d52d50",
//        "5" : "597d816580ab5e6790d52d53"
//    },

    NSDictionary*dicTC=[_dicM objectForKey:@"TcCodes"];
    NSArray*aryKeys=[dicTC allKeys];
    DuoXuanVC*vc=[[DuoXuanVC alloc]init];
    [vc setArray:aryKeys btn:(UIButton*)sender];
    [self.navigationController pushViewController:vc animated:YES];
}

//设备对应资产编号选择
- (IBAction)btnOEclick:(id)sender {
//    "OeCodes" : {
//        "B2" : "597d817b80ab5e6790d52d55",
//        "KCXZ-BGSB0003" : "58e600f419eb64c4e6387604",
//        "B3" : "597d818280ab5e6790d52d56",
//        "***" : "594a15f6075910c2d60d08ca",
//        "KCXZ-BGSB0004" : "59361919075910c2d60d0789",
//        "B1" : "597d817480ab5e6790d52d54",
//        "B4" : "597d818980ab5e6790d52d57",
//        "KCXZ-BGSB0005" : "59361922075910c2d60d078a"

    NSDictionary*dicOE=[_dicM objectForKey:@"OeCodes"];
    NSArray*aryKeys=[dicOE allKeys];
    DuoXuanVC*vc=[[DuoXuanVC alloc]init];
    [vc setArray:aryKeys btn:(UIButton*)sender];
    [self.navigationController pushViewController:vc animated:YES];

}


//门禁卡对应资产编号选择
- (IBAction)btnEgcClick:(id)sender {
    
//    "EgcCodes" : {
//        "KCXZ-CYK0030" : "58f58da119eb8cbffbb87aca",
//        "KCXZ-CYK0020" : "58f58d2319eb8cbffbb87ac0",
//        "KCXZ-CYK0033" : "58f58dc019eb8cbffbb87acd",
//        "KCXZ-CYK0013" : "58f58ca719eb8cbffbb87ab8",
//        "KCXZ-CYK0003" : "58f58c0919eb8cbffbb87aae",
//        "KCXZ-CYK0036" : "58f58de219eb8cbffbb87ad0",
//        "KCXZ-CYK0026" : "58f58d6a19eb8cbffbb87ac6",
//        "KCXZ-CYK0016" : "58f58cce19eb8cbffbb87abb",
//        "KCXZ-CYK0006" : "58f58c2619eb8cbffbb87ab1",
//        "KCXZ-CYK-0001" : "58e6005f19eb64c4e63875fd",
//        "KCXZ-CYK00010" : "58f58c5819eb8cbffbb87ab5",
//        "KCXZ-CYK0019" : "58f58cf119eb8cbffbb87abe",
//        "KCXZ-CYK0009" : "58f58c4319eb8cbffbb87ab4",
//        "KCXZ-CYK0029" : "58f58d9719eb8cbffbb87ac9",
//        "KCXZ-CYK0032" : "58f58db619eb8cbffbb87acc",
//        "KCXZ-CYK0012" : "58f58c9919eb8cbffbb87ab7",
//        "KCXZ-CYK0002" : "58e6006f19eb64c4e63875fe",
//        "KCXZ-CYK0035" : "58f58dd819eb8cbffbb87acf",
//        "KCXZ-CYK0025" : "58f58d5f19eb8cbffbb87ac5",
//        "KCXZ-CYK0015" : "58f58cc219eb8cbffbb87aba",
//        "KCXZ-CYK0005" : "58f58c1f19eb8cbffbb87ab0",
//        "A1" : "597d819b80ab5e6790d52d59",
//        "A2" : "597d81a180ab5e6790d52d5a",
//        "KCXZ-CYK0038" : "58f58dfe19eb8cbffbb87ad2",
//        "KCXZ-CYK0028" : "58f58d8419eb8cbffbb87ac8",
//        "KCXZ-CYK0018" : "58f58ce619eb8cbffbb87abd",
//        "KCXZ-CYK0008" : "58f58c3b19eb8cbffbb87ab3",
//        "A3" : "597d81ab80ab5e6790d52d5b",
//        "KCXZ-CYK0031" : "58f58dab19eb8cbffbb87acb",
//        "KCXZ-CYK0011" : "58f58c6119eb8cbffbb87ab6",
//        "A4" : "597d81b180ab5e6790d52d5c",
//        "KCXZ-CYK0034" : "58f58dcd19eb8cbffbb87ace",
//        "KCXZ-CYK0014" : "58f58cb319eb8cbffbb87ab9",
//        "KCXZ-CYK0004" : "58f58c1319eb8cbffbb87aaf",
//        "KCXZ-CYK0037" : "58f58dee19eb8cbffbb87ad1",
//        "KCXZ-CYK0027" : "58f58d7619eb8cbffbb87ac7",
//        "KCXZ-CYK0017" : "58f58cda19eb8cbffbb87abc",
//        "KCXZ-CYK0007" : "58f58c3119eb8cbffbb87ab2"

    NSDictionary*dicEgc=[_dicM objectForKey:@"EgcCodes"];
    NSArray*aryKeys=[dicEgc allKeys];
    DuoXuanVC*vc=[[DuoXuanVC alloc]init];
    [vc setArray:aryKeys btn:(UIButton*)sender];
    [self.navigationController pushViewController:vc animated:YES];

}

//车位资产编号选择
- (IBAction)btnPLclick:(id)sender {
    
//    "PlCodes" : {
//        "Z1" : "597d81ba80ab5e6790d52d5d",
//        "KCXZ-CW0010" : "58f58e8219eb8cbffbb87ada",
//        "KCXZ-CW0007" : "58f58e6519eb8cbffbb87ad7",
//        "Z2" : "597d81c180ab5e6790d52d5e",
//        "KCXZ-CW0009" : "58f58e7719eb8cbffbb87ad9",
//        "KCXZ-CW0006" : "58f58e5b19eb8cbffbb87ad6",
//        "124124414" : "597d7c8f80ab5e6790d52d40",
//        "KCXZ-CW0008" : "58f58e6f19eb8cbffbb87ad8"
//    },

    
    NSDictionary*dicPL=[_dicM objectForKey:@"PlCodes"];
    NSArray*aryKeys=[dicPL allKeys];
    DuoXuanVC*vc=[[DuoXuanVC alloc]init];
    [vc setArray:aryKeys btn:(UIButton*)sender];
    [self.navigationController pushViewController:vc animated:YES];

}





//提交事件处理
- (IBAction)tijiaoClick:(id)sender {
    
    /*
     2.13.2 资源管理查询
     http://116.228.176.34:9002/chuangke-serve/resourceallocation/search?length=1000&start=0
     [
     {"id":"58f5892e19eb8cbffbb87aa5","officeArea"
     :null,"numberOfOffice":6,"numberOftc":6,"tcCodes":"","numberOfoe":0,"oeCodes":"","printAccount":"qjny01"
     ,"printPassword":"111111","numberOfegc":4,"egcCodes":"KCXZ-CYK0021,KCXZ-CYK0022,KCXZ-CYK0023,KCXZ-CYK0024"
     ,"numberOfpl":2,"plCodes":"KCXZ-CW0003,KCXZ-CW0004","companyName":"清基(上海）农业发展有限公司","name":"陈强","concatType"
     :"","desc":""}]
     */
    NSDictionary*dicEgc=[_dicM objectForKey:@"EgcCodes"];
    NSDictionary*dicPL=[_dicM objectForKey:@"PlCodes"];
    NSDictionary*dicTC=[_dicM objectForKey:@"TcCodes"];
    NSDictionary*dicOE=[_dicM objectForKey:@"OeCodes"];
    NSDictionary*dicOFO=[_dicM objectForKey:@"ofoCodes"];

    NSMutableDictionary*dic=[NSMutableDictionary dictionary];
    [dic setNotNullStrObject:_chushiDuiXiang.text forKey:@"companyName"];
    
    [dic setNotNullStrObject:_numberOfOffice.text forKey:@"numberOfOffice"];
//  [dic setNotNullObject:_ofoCodes.currentTitle forKey:@"ofoCodes"];
    
    
    [dic setNotNullStrObject:_numberOftc.text forKey:@"numberOftc"];
    NSArray*TcKey=[_TcCodes.currentTitle componentsSeparatedByString:@","];
    NSMutableArray*TcAry=[NSMutableArray array];
    for (NSString*ss in TcKey )
    {
       NSString*value=[dicTC objectNotNullForKey:ss];
       [TcAry addObject:value];
    }
    [dic setNotNullObject:TcAry forKey:@"tcCodes"];
    
    
    [dic setNotNullStrObject:_numberOfoe.text forKey:@"numberOfoe"];
    NSArray*OeKey=[_OeCodes.currentTitle componentsSeparatedByString:@","];
    NSMutableArray*OeAry=[NSMutableArray array];
    for (NSString*ss in OeKey )
    {
        NSString*value=[dicOE objectNotNullForKey:ss];
        [OeAry addObject:value];
    }
    [dic setNotNullObject:OeAry forKey:@"oeCodes"];
    
   
    [dic setNotNullStrObject:_printAccount.text forKey:@"printAccount"];
    [dic setNotNullStrObject:_printPassword.text forKey:@"printPassword"];
    
    
    [dic setNotNullStrObject:_numberOfegc.text forKey:@"numberOfegc"];
    NSArray*EgcKey=[_EgcCodes.currentTitle componentsSeparatedByString:@","];
    NSMutableArray*EgcAry=[NSMutableArray array];
    for (NSString*ss in EgcKey )
    {
        NSString*value=[dicEgc objectNotNullForKey:ss];
        [EgcAry addObject:value];
    }
    [dic setNotNullObject:EgcAry forKey:@"egcCodes"];

    /*
     2.13.2 资源管理查询
     http://116.228.176.34:9002/chuangke-serve/resourceallocation/search?length=1000&start=0
     [
     {"id":"58f5892e19eb8cbffbb87aa5",
     "officeArea":null,
     "numberOfOffice":6,
     "numberOftc":6,
     "tcCodes":"",
     "numberOfoe":0,
     "oeCodes":"",
     "printAccount":"qjny01",
     "printPassword":"111111",
     "numberOfegc":4,
     "egcCodes":"KCXZ-CYK0021,KCXZ-CYK0022,KCXZ-CYK0023,KCXZ-CYK0024",
     "numberOfpl":2,
     "numberOfpl":"KCXZ-CW0003,KCXZ-CW0004",
     "companyName":"清基(上海）农业发展有限公司",
     "name":"陈强",
     "concatType":"",
     "desc":""}]
     */
    
    [dic setNotNullStrObject:_numberOfpl.text forKey:@"numberOfpl"];
    NSArray*PLKey=[_PlCodes.currentTitle componentsSeparatedByString:@","];
    NSMutableArray*PLAry=[NSMutableArray array];
    for (NSString*ss in PLKey )
    {
        NSString*value=[dicPL objectNotNullForKey:ss];
        [PLAry addObject:value];
    }
    [dic setObject:PLAry forKey:@"plCodes"];

    [dic setNotNullStrObject:_name.text forKey:@"name"];
    [dic setNotNullStrObject:_concatType.text forKey:@"concatType"];
    [dic setNotNullStrObject: _beizhu.text forKey:@"desc"];
    [dic setNotNullStrObject:_strID forKey:@"id"];
    if([_isInit isEqualToString:@"Y"]){
        [_ziyuan ZiYuanGuanLiInit:dic];
    }else{
        [_ziyuan ZiYuanGuanLiModify:dic];
        
    }
    
    
}

-(void)afternetwork1:(id)data
{
    [self tiShiKuangDisplay:submitStr viewController:self];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"XIUGAIZIYUANSUCCESS" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}









@end

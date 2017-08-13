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
    [super viewDidLoad];
    
    
    _ziyuan=[[ZiYuanPeiZhiGuanLi alloc]init];
    _ziyuan.delegate=self;
    [_ziyuan ZiYuanGuanLiDetailQuery:_strID];
    
    //    cell.companyName.text=[dic objectNotNullForKey:@"companyName"];
    //    cell.workArea.text=[dic objectNotNullForKey:@"officeArea"];
    //    cell.zuoweiNum.text=[dic objectNotNullForKey:@"numberOfOffice"];
    
    //    cell.zhuoyiNum.text=[dic objectNotNullForKey:@"numberOftc"];
    //    cell.zhuoYiCode.text=[dic objectNotNullForKey:@"tcCodes"];
    //    cell.shebeiNum.text=[dic objectNotNullForKey:@"numberOfoe"];
    //    cell.sheBeiCode.text=[dic objectNotNullForKey:@"oeCodes"];
    //    cell.wenyinAccount.text=[dic objectNotNullForKey:@"printAccount"];
    //    cell.wenyinPsw.text=[dic objectNotNullForKey:@"printPassword"];
    //    cell.menjinkaNum.text=[dic objectNotNullForKey:@"numberOfegc"];
    //    cell.menjinkaCode.text=[dic objectNotNullForKey:@"egcCodes"];
    //    cell.carstopNum.text=[dic objectNotNullForKey:@"numberOfpl"];
    //    cell.carstopCode.text=[dic objectNotNullForKey:@"plCodes"];
    //    cell.witerName.text=[dic objectNotNullForKey:@"name"];
    //    cell.witerPhone.text=[dic objectNotNullForKey:@"concatType"];
    
//    _numberOfOffice.text=[_ary objectAtIndex:0];
//    [_ofoCodes setTitle:[_ary objectAtIndex:1] forState:UIControlStateNormal];
    
    
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


//- (IBAction)btnclick:(id)sender {
//    UIButton* btn=(UIButton*)sender;
//    NSString* datas=btn.titleLabel.text;
//    if(datas!=nil && datas.length>0 && [datas containsString:@","])
//    {
//        datas=[datas stringByReplacingOccurrencesOfString:@"[" withString:@""];
//        datas=[datas stringByReplacingOccurrencesOfString:@"]" withString:@""];
//        NSArray* array=[datas componentsSeparatedByString:@","];
//    }
// }


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
    
  NSDictionary*dicOFO=[_dicM objectNotNullForKey:@"ofoCodes"];
    
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

    NSDictionary*dicTC=[_dicM objectNotNullForKey:@"TcCodes"];
    
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

    NSDictionary*dicOE=[_dicM objectNotNullForKey:@"OeCodes"];

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

    
    
    NSDictionary*dicEgc=[_dicM objectNotNullForKey:@"EgcCodes"];
    
    NSArray*aryKeys=[dicEgc allKeys];
    
    DuoXuanVC*vc=[[DuoXuanVC alloc]init];
    [vc setArray:aryKeys btn:(UIButton*)sender];
    [self.navigationController pushViewController:vc animated:YES];

}

//车位对应资产编号选择
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

    
    NSDictionary*dicPL=[_dicM objectNotNullForKey:@"PlCodes"];
    
    NSArray*aryKeys=[dicPL allKeys];
    
    DuoXuanVC*vc=[[DuoXuanVC alloc]init];
    [vc setArray:aryKeys btn:(UIButton*)sender];
    [self.navigationController pushViewController:vc animated:YES];

}





//提交事件处理
- (IBAction)tijiaoClick:(id)sender {
    
    
    /*
     2.13.0 在修改资源时，可以下拉选择资产编号；查询到所有的资产编号
     http://116.228.176.34:9002/chuangke-serve/resourceallocation/edit?id=59361b09075910c2d60d0790
     查询到数据为：
     {
     "EgcCodes" : {
     "KCXZ-CYK0030" : "58f58da119eb8cbffbb87aca",
     "KCXZ-CYK0020" : "58f58d2319eb8cbffbb87ac0",
     "KCXZ-CYK0033" : "58f58dc019eb8cbffbb87acd",
     "KCXZ-CYK0013" : "58f58ca719eb8cbffbb87ab8",
     "KCXZ-CYK0003" : "58f58c0919eb8cbffbb87aae",
     "KCXZ-CYK0036" : "58f58de219eb8cbffbb87ad0",
     "KCXZ-CYK0026" : "58f58d6a19eb8cbffbb87ac6",
     "KCXZ-CYK0016" : "58f58cce19eb8cbffbb87abb",
     "KCXZ-CYK0006" : "58f58c2619eb8cbffbb87ab1",
     "KCXZ-CYK-0001" : "58e6005f19eb64c4e63875fd",
     "KCXZ-CYK00010" : "58f58c5819eb8cbffbb87ab5",
     "KCXZ-CYK0019" : "58f58cf119eb8cbffbb87abe",
     "KCXZ-CYK0009" : "58f58c4319eb8cbffbb87ab4",
     "KCXZ-CYK0029" : "58f58d9719eb8cbffbb87ac9",
     "KCXZ-CYK0032" : "58f58db619eb8cbffbb87acc",
     "KCXZ-CYK0012" : "58f58c9919eb8cbffbb87ab7",
     "KCXZ-CYK0002" : "58e6006f19eb64c4e63875fe",
     "KCXZ-CYK0035" : "58f58dd819eb8cbffbb87acf",
     "KCXZ-CYK0025" : "58f58d5f19eb8cbffbb87ac5",
     "KCXZ-CYK0015" : "58f58cc219eb8cbffbb87aba",
     "KCXZ-CYK0005" : "58f58c1f19eb8cbffbb87ab0",
     "A1" : "597d819b80ab5e6790d52d59",
     "A2" : "597d81a180ab5e6790d52d5a",
     "KCXZ-CYK0038" : "58f58dfe19eb8cbffbb87ad2",
     "KCXZ-CYK0028" : "58f58d8419eb8cbffbb87ac8",
     "KCXZ-CYK0018" : "58f58ce619eb8cbffbb87abd",
     "KCXZ-CYK0008" : "58f58c3b19eb8cbffbb87ab3",
     "A3" : "597d81ab80ab5e6790d52d5b",
     "KCXZ-CYK0031" : "58f58dab19eb8cbffbb87acb",
     "KCXZ-CYK0011" : "58f58c6119eb8cbffbb87ab6",
     "A4" : "597d81b180ab5e6790d52d5c",
     "KCXZ-CYK0034" : "58f58dcd19eb8cbffbb87ace",
     "KCXZ-CYK0014" : "58f58cb319eb8cbffbb87ab9",
     "KCXZ-CYK0004" : "58f58c1319eb8cbffbb87aaf",
     "KCXZ-CYK0037" : "58f58dee19eb8cbffbb87ad1",
     "KCXZ-CYK0027" : "58f58d7619eb8cbffbb87ac7",
     "KCXZ-CYK0017" : "58f58cda19eb8cbffbb87abc",
     "KCXZ-CYK0007" : "58f58c3119eb8cbffbb87ab2"
     },
     "PlCodes" : {
     "Z1" : "597d81ba80ab5e6790d52d5d",
     "KCXZ-CW0010" : "58f58e8219eb8cbffbb87ada",
     "KCXZ-CW0007" : "58f58e6519eb8cbffbb87ad7",
     "Z2" : "597d81c180ab5e6790d52d5e",
     "KCXZ-CW0009" : "58f58e7719eb8cbffbb87ad9",
     "KCXZ-CW0006" : "58f58e5b19eb8cbffbb87ad6",
     "124124414" : "597d7c8f80ab5e6790d52d40",
     "KCXZ-CW0008" : "58f58e6f19eb8cbffbb87ad8"
     },
     "TcCodes" : {
     "3" : "597d815980ab5e6790d52d51",
     "1" : "597d814c80ab5e6790d52d4f",
     "KCXZ-CW0005" : "58f58e5119eb8cbffbb87ad5",
     "4" : "597d815f80ab5e6790d52d52",
     "2" : "597d815480ab5e6790d52d50",
     "5" : "597d816580ab5e6790d52d53"
     },
     "ofoCodes" : {
     "KCXZ-GW0001" : "KCXZ-GW0001",
     "KCXZ-GW0004" : "KCXZ-GW0004",
     "Q1" : "Q1",
     "KCXZ-GW0003" : "KCXZ-GW0003",
     "KCXZ-GW0002" : "KCXZ-GW0002",
     "KCXZ-GW0005" : "KCXZ-GW0005"
     },
     "OeCodes" : {
     "B2" : "597d817b80ab5e6790d52d55",
     "KCXZ-BGSB0003" : "58e600f419eb64c4e6387604",
     "B3" : "597d818280ab5e6790d52d56",
     "***" : "594a15f6075910c2d60d08ca",
     "KCXZ-BGSB0004" : "59361919075910c2d60d0789",
     "B1" : "597d817480ab5e6790d52d54",
     "B4" : "597d818980ab5e6790d52d57",
     "KCXZ-BGSB0005" : "59361922075910c2d60d078a"
    
    */
    
    
    NSDictionary*dicEgc=[_dicM objectNotNullForKey:@"EgcCodes"];
    NSDictionary*dicPL=[_dicM objectNotNullForKey:@"PlCodes"];
    NSDictionary*dicTC=[_dicM objectNotNullForKey:@"TcCodes"];
    NSDictionary*dicOE=[_dicM objectNotNullForKey:@"OeCodes"];
    NSDictionary*dicOFO=[_dicM objectNotNullForKey:@"ofoCodes"];
    
    
    
    
    DuoXuanVC*vc=[[DuoXuanVC alloc]init];
//    [vc setArray:<#(NSArray *)#> btn:<#(UIButton *)#>];
    [self.navigationController pushViewController:vc animated:YES];
}











@end

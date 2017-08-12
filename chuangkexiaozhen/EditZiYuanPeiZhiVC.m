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

- (IBAction)btnclick:(id)sender {
    UIButton* btn=(UIButton*)sender;
    NSString* datas=btn.titleLabel.text;
    if(datas!=nil && datas.length>0 && [datas containsString:@","]){
        datas=[datas stringByReplacingOccurrencesOfString:@"[" withString:@""];
        datas=[datas stringByReplacingOccurrencesOfString:@"]" withString:@""];
        NSArray* array=[datas componentsSeparatedByString:@","];
        if([array count]>1){
            
//            ComboViewController*vc=[[ComboViewController alloc] initView];
//            [vc setDatas:array];
//            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
    
    
}



- (IBAction)tijiaoClick:(id)sender {
    
    DuoXuanVC*vc=[[DuoXuanVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}











@end

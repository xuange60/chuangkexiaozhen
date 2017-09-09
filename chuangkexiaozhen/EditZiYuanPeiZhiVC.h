//
//  EditZiYuanPeiZhiVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/12.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "DuoXuanVC.h"
#import "ZiYuanPeiZhiGuanLi.h"
@interface EditZiYuanPeiZhiVC : BaseViewController<BussinessApiDelegate>

-(void)setStr:(NSString*)strId infoAry:(NSArray*)ary;
@property(nonatomic,strong)NSString*strID;
@property(nonatomic,strong)NSArray*ary;
@property(nonatomic,strong)ZiYuanPeiZhiGuanLi*ziyuan;
@property(nonatomic,strong)NSMutableDictionary*dicM;

@property (strong, nonatomic) IBOutlet UITextField *chushiDuiXiang;

@property (strong, nonatomic) IBOutlet UITextField *numberOfOffice;
@property (strong, nonatomic) IBOutlet UIButton *ofoCodes;

@property (strong, nonatomic) IBOutlet UITextField *numberOftc;

@property (strong, nonatomic) IBOutlet UIButton *TcCodes;


@property (strong, nonatomic) IBOutlet UITextField *numberOfoe;
@property (strong, nonatomic) IBOutlet UIButton *OeCodes;

@property (strong, nonatomic) IBOutlet UITextField *printAccount;

@property (strong, nonatomic) IBOutlet UITextField *printPassword;

@property (strong, nonatomic) IBOutlet UITextField *numberOfegc;

@property (strong, nonatomic) IBOutlet UIButton *EgcCodes;

@property (strong, nonatomic) IBOutlet UITextField *numberOfpl;
@property (strong, nonatomic) IBOutlet UIButton *PlCodes;

@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *concatType;


@property (strong, nonatomic) IBOutlet UITextView *beizhu;


@property (strong,nonatomic) NSString* isInit;



@end

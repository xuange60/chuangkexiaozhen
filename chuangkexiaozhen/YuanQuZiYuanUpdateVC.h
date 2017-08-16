//
//  YuanQuZiYuanUpdateVC.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/16.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "YuanQuZiYuanGuanLi.h"
#import "DuoXuanVC.h"
@interface YuanQuZiYuanUpdateVC : BaseViewController<BussinessApiDelegate>

@property (strong,nonatomic) YuanQuZiYuanGuanLi* yuanquziyuanguanli;

@property (strong, nonatomic) IBOutlet UIButton *category;


@property (strong, nonatomic) IBOutlet UITextField *code;


@property (strong, nonatomic) IBOutlet UITextField *content;



@property (strong,nonatomic) NSString* isModify;
@property (strong,nonatomic) NSDictionary* curdata;

@property (strong,nonatomic) NSDictionary* categorys;
@end

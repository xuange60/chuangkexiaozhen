//
//  KaoQinLuoJiUpdateVC.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/16.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "KaoQinLuoJi.h"
#import "DuoXuanVC.h"
@interface KaoQinLuoJiUpdateVC : BaseViewController<BussinessApiDelegate>

@property (nonatomic,strong) KaoQinLuoJi* kaoqinluoji;



@property (strong, nonatomic) IBOutlet UIButton *company;

@property (strong, nonatomic) IBOutlet UITextField *starttime;

@property (strong, nonatomic) IBOutlet UITextField *endtime;

@property (strong, nonatomic) IBOutlet UIButton *startpicker;

@property (strong, nonatomic) IBOutlet UIButton *endpicker;

@property (strong,nonatomic) NSDictionary* tenantids;


@property (strong,nonatomic) NSString* isModify;
@property (strong,nonatomic) NSDictionary* curdata;

@end

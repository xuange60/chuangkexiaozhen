//
//  BeiDongTuiChuAdd.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/20.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "BeiDongTuiChu.h"
#import "ImgeUpViewController.h"
#import "DuoXuanVC.h"
@interface BeiDongTuiChuAdd : BaseViewController<BussinessApiDelegate>

@property (strong, nonatomic) IBOutlet UIButton *quitCompany;

@property (strong, nonatomic) IBOutlet UITextField *quitCause;


@property (strong, nonatomic) IBOutlet UITextField *quitDate;

@property (strong, nonatomic) IBOutlet UIButton *quitType;


@property (strong,nonatomic) NSDictionary* companys;



@property (strong,nonatomic) NSString* resourceIds;
@property (strong,nonatomic) BeiDongTuiChu* beidongtuichu;


@end

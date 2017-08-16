//
//  ZhuDongTuiChuAddVC.h
//  chuangkexiaozhen
//ceshigai
//  Created by zx on 2017/8/16.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "ZhuDongTuiChu.h"
#import "ImgeUpViewController.h"
#import "DuoXuanVC.h"
@interface ZhuDongTuiChuAddVC : BaseViewController<BussinessApiDelegate>

@property (strong, nonatomic) IBOutlet UITextField *quitCompany;

@property (strong, nonatomic) IBOutlet UITextField *quitCause;


@property (strong, nonatomic) IBOutlet UITextField *quitDate;

@property (strong, nonatomic) IBOutlet UIButton *quitType;




@property (strong,nonatomic) NSString* company;
@property (strong,nonatomic) NSString* tenants;
@property (strong,nonatomic) NSString* resourceIds;
@property (strong,nonatomic) ZhuDongTuiChu* zhudongtuichu;


@end

//
//  YuanGongLieBiaoModifyVC.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/22.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "YuanGongXinXi.h"
@interface YuanGongLieBiaoModifyVC : BaseViewController<BussinessApiDelegate>


@property (strong, nonatomic) IBOutlet UITextField *LoginName;


@property (strong, nonatomic) IBOutlet UITextField *name;


@property (strong, nonatomic) IBOutlet UITextField *department;


@property (strong, nonatomic) IBOutlet UITextField *rank;



@property (strong, nonatomic) IBOutlet UITextField *MobilePhone;



@property (strong, nonatomic) IBOutlet UITextField *email;


@property (strong,nonatomic) NSDictionary* datas;
@property (strong,nonatomic) YuanGongXinXi* yuangongxinxi;

@end

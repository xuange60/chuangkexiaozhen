//
//  YongHuModPwdVC.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/21.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "YongHuXinXi.h"
@interface YongHuModPwdVC : BaseViewController<BussinessApiDelegate>


@property (strong, nonatomic) IBOutlet UITextField *username;


@property (strong, nonatomic) IBOutlet UITextField *newpassword;


@property (strong, nonatomic) IBOutlet UITextField *newpassword2;

@property (strong,nonatomic) NSDictionary* datas;

@property (strong,nonatomic) YongHuXinXi* yonghuxinxi;

@end

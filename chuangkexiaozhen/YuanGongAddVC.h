//
//  YuanGongAddVC.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/22.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "YuanGongXinXi.h"
@interface YuanGongAddVC : BaseViewController<BussinessApiDelegate>
@property (strong,nonatomic) YuanGongXinXi* yuangongxinxi;

@property (strong, nonatomic) IBOutlet UITextField *loginName;

@property (strong, nonatomic) IBOutlet UITextField *password;


@property (strong, nonatomic) IBOutlet UITextField *name;

@property (strong, nonatomic) IBOutlet UITextField *department;

@property (strong, nonatomic) IBOutlet UITextField *rank;


@property (strong, nonatomic) IBOutlet UITextField *mobilePhone;

@property (strong, nonatomic) IBOutlet UITextField *email;


@property (strong, nonatomic) IBOutlet UITextView *remark;





@end

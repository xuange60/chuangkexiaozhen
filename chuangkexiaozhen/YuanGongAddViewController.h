//
//  YuanGongAddViewController.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/4.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "YuanGongGuanLi.h"

@interface YuanGongAddViewController : BaseViewController<BussinessApiDelegate>
@property (strong,nonatomic) YuanGongGuanLi* yuangongguanli;

@property (strong, nonatomic) IBOutlet UITextField *loginName;

@property (strong, nonatomic) IBOutlet UITextField *password;


@property (strong, nonatomic) IBOutlet UITextField *name;

@property (strong, nonatomic) IBOutlet UITextField *department;

@property (strong, nonatomic) IBOutlet UITextField *rank;


@property (strong, nonatomic) IBOutlet UITextField *mobilePhone;

@property (strong, nonatomic) IBOutlet UITextField *email;


@property (strong, nonatomic) IBOutlet UITextView *remark;





@end

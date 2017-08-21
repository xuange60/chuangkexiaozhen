//
//  YongHuModifyVC.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/21.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "YongHuXinXi.h"
#import "DuoXuanVC.h"
@interface YongHuModifyVC : BaseViewController<BussinessApiDelegate>

@property (strong, nonatomic) IBOutlet UITextField *comanyname;

@property (strong, nonatomic) IBOutlet UIButton *companytype;

@property (strong, nonatomic) IBOutlet UITextField *department;


@property (strong, nonatomic) IBOutlet UITextField *email;


@property (strong, nonatomic) IBOutlet UITextField *mobile;



@property (strong, nonatomic) IBOutlet UITextField *rank;


@property (strong, nonatomic) IBOutlet UITextField *name;


@property (strong, nonatomic) IBOutlet UIButton *roleIds;

@property (strong, nonatomic) IBOutlet UITextField *username;

@property (strong,nonatomic) YongHuXinXi* yonghuxinxi;

@property (strong,nonatomic) NSDictionary* roles;
@property (strong,nonatomic) NSDictionary* selectedroles;

@property (strong,nonatomic) NSDictionary* companytypes;
@property (strong,nonatomic) NSDictionary* selectedcompanytype;
@property (strong,nonatomic) NSDictionary* datas;

@end

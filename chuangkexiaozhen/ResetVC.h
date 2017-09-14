//
//  ResetVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/24.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import <UIKit/UIKit.h>
#import "BussinessApi.h"
#import "CustomButton.h"
#import  "MBProgressHUD.h"
@interface ResetVC : BaseViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *userName;

@property (strong, nonatomic) IBOutlet UITextField *mobile;

@property (strong, nonatomic) IBOutlet UITextField *yanZhengMa;

@property (strong, nonatomic) IBOutlet UITextField *pwd;

@property (strong, nonatomic) IBOutlet UITextField *pwd2;
@property (strong, nonatomic) IBOutlet CustomButton *yzmBtn;


@property (strong, nonatomic) IBOutlet UIButton *zhuceBtn;

@property(nonatomic,strong)NSTimer*timer;
@property(nonatomic)int i;
@property(nonatomic,strong)UIGestureRecognizer*ges;


@property (nonatomic) BOOL check;

@end

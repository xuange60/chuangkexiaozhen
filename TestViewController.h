//
//  TestViewController.h
//  chuangkexiaozhen
//
//  Created by zx on 17/7/26.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BussinessApi.h"
#import "FuHusChengZhangGuanLi.h"
#import "YuanQuFuWuShenQing.h"
#import "YuanGongGuanLi.h"
#import "HuoDong.h"
#import "KaoQinGuanLi.h"

//接口测试文件
@interface TestViewController : UIViewController


@property (strong,nonatomic) BussinessApi* bussinessapi;
@property (strong,nonatomic) FuHusChengZhangGuanLi* fuhuachengzguanli;
@property (strong,nonatomic) YuanQuFuWuShenQing* yuanqufuwushenqing;
@property (strong,nonatomic) YuanGongGuanLi* yuangongguanli;
@property (strong,nonatomic) HuoDong* huodong;
@property (strong,nonatomic) KaoQinGuanLi* kaoqinguanli;

@end

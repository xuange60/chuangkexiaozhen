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
#import "GenZongFuWu.h"
#import "PaiHangBang.h"
#import "DaBianGuanLi.h"
#import "ShiTiRuZhuGuanLi.h"
#import "DianZiHeTongGuanLi.h"
#import "XuNiRuZhuGuanLi.h"
#import "KaiTongZhuXianGuanLi.h"
#import "ShenSuShenQingGuanLi.h"
#import "ZiYuanPeiZhiGuanLi.h"
#import "YuanQuFuWuGuanLi.h"
#import "YuanQuRenWuTongGao.h"
#import "QianDaoTongJi.h"
#import "HuoDongBaoXiao.h"
#import "ChengGuoGenZong.h"
#import "YongHuXinXi.h"
#import "YuanGongXinXi.h"
//接口测试文件
@interface TestViewController : UIViewController<BussinessApiDelegate>


@property (strong,nonatomic) BussinessApi* bussinessapi;
@property (strong,nonatomic) FuHusChengZhangGuanLi* fuhuachengzguanli;
@property (strong,nonatomic) YuanQuFuWuShenQing* yuanqufuwushenqing;
@property (strong,nonatomic) YuanGongGuanLi* yuangongguanli;
@property (strong,nonatomic) HuoDong* huodong;
@property (strong,nonatomic) KaoQinGuanLi* kaoqinguanli;
@property (strong,nonatomic) GenZongFuWu* genzongfuwu;
@property (strong,nonatomic) PaiHangBang* paihangbang;
@property (strong,nonatomic) DaBianGuanLi* dabianguanli;
@property (strong,nonatomic) ShiTiRuZhuGuanLi* shitiruzhuguanli;
@property (strong,nonatomic) DianZiHeTongGuanLi* dianzihetongguanli;
@property (strong,nonatomic) XuNiRuZhuGuanLi* xuniruzhuguanli;

@property (strong,nonatomic) KaiTongZhuXianGuanLi* kaitongzhuxianguanli;
@property (strong,nonatomic) ShenSuShenQingGuanLi* shensushenqingguanli;

@property (strong,nonatomic) ZiYuanPeiZhiGuanLi* ziyuanpeizhiguanli;

@property(strong,nonatomic) YuanQuFuWuGuanLi* yuanqufuwuguanli;

@property (strong,nonatomic) YuanQuRenWuTongGao* yuanqurenwutonggao;

@end

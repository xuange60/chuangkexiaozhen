//
//  zhuyeVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/18.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShiChangXiaoShouVC.h"
#import "TuanDuiGuanLiVC.h"
#import "TuanDuiGuanLiVC.h"
#import "KaoQinGuanLiVC.h"
#import "DaBianGuanLiVC.h"
#import "ShiTiRuZhuGuanLivc.h"
#import "XuNiRuZhuVC.h"
#import "KaiTongZhuXianVC.h"
#import "ShenSuShenQingVC.h"
#import "ZiYuanPeiZhiVC.h"
#import "YuanQuRenWuVC.h"
#import "FaKaGuanLiVC.h"
#import "QianDaoTongJiVC.h"
#import "YuanQuZiYuanVC.h"
#import "ZhuDongTuiChuVC.h"
#import "BaoXiaoVC.h"
#import "BeiDongTuiChuVC.h"
#import "GenZongVC.h"
#import "YongHuVC.h"
#import "YuanGongLieBiaoVC.h"
#import "ViewController.h"
@interface zhuyeVC : UIViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>


@property (strong, nonatomic) IBOutlet UITableView *tableview;

@property (strong, nonatomic) NSArray* datas;

@property (strong,nonatomic) NSString* isadmin;


@property (strong, nonatomic) IBOutlet UIImageView *imgview;

@property (strong,nonatomic) NSTimer* timer;

@property (nonatomic) int count;

@end

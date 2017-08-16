//
//  YuanQuZiYuanVC.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/16.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "YuanQuZiYuanUpdateVC.h"
#import "YuanQuZiYuanGuanLi.h"
#import "YuanQuZiYuanCell.h"
#import "DuoXuanVC.h"
@interface YuanQuZiYuanVC : BaseViewController<UITableViewDelegate,UITableViewDataSource,BussinessApiDelegate>

@property (nonatomic,strong) YuanQuZiYuanGuanLi* yuanquziyuanguanli;

@property (nonatomic,strong) NSArray* datas;
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@property (strong,nonatomic) NSDictionary* categorys;

@property (strong, nonatomic) IBOutlet UIButton *category;


@end

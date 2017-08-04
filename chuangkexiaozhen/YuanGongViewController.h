//
//  YuanGongViewController.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/4.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "BussinessApi.h"
#import "YuanGongGuanLi.h"
#import "YuanGongCell.h"
#import "YuanGongDetailViewController.h"
@interface YuanGongViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,BussinessApiDelegate>

@property (strong,nonatomic) YuanGongGuanLi* yuangongguanli;
@property (nonatomic,strong) NSArray* datas;

@property (strong, nonatomic) IBOutlet UITableView *tableview;


@end

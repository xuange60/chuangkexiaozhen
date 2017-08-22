//
//  YuanGongLieBiaoVC.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/22.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "YuanGongXinXi.h"
#import "YuanGongLieBiaoCell.h"
#import "YuanGongLieBiaoModifyVC.h"
#import "YuanGongAddVC.h"
@interface YuanGongLieBiaoVC:BaseViewController<UITableViewDelegate,UITableViewDataSource,BussinessApiDelegate>

@property (nonatomic,strong) YuanGongXinXi* yuangongxinxi;

@property (nonatomic,strong) NSArray* datas;

@property (strong, nonatomic) IBOutlet UITableView *tableview;


@end

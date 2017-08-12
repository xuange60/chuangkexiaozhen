//
//  JiangLiGuanLiVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/3.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "JiangLiGuanLiCell.h"
#import "AddJiangLiVC.h"
#import "BussinessApi.h"
#import "FilelistViewController.h"
#import "JiaFenCaiLiaoShenHe.h"
#import "JiangLiGuanDetailVC.h"
@interface JiangLiGuanLiVC : BaseViewController<UITableViewDelegate,UITableViewDataSource,BussinessApiDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)BussinessApi*api;
@property(nonatomic,strong)NSArray*ary;

//modify
@property(nonatomic,strong) JiaFenCaiLiaoShenHe* jiafencailiaoshenhe;
@property(nonatomic,strong) NSString* isadmin;
@end

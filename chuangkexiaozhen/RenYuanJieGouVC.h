//
//  RenYuanJieGouVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/5.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "FuHusChengZhangGuanLi.h"
#import "RenYuanJieGouCell.h"
#import "AddRenYuanVC.h"
#import "FilelistViewController.h"
@interface RenYuanJieGouVC : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)BussinessApi*api;
@property(nonatomic,strong)NSArray*ary;
@property(nonatomic,strong)FuHusChengZhangGuanLi*FuHua;






@end
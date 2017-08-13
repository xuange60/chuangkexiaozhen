//
//  ActiveGuanLiVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/1.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BussinessApi.h"
#import "ActiveGuanLiCell.h"

#import "AddActiveVC.h"
#import "FilelistViewController.h"
#import "HuoDongGuanLiDetailVC.h"
#import "JiaFenCaiLiaoShenHe.h"
@interface ActiveGuanLiVC : BaseViewController<UITableViewDelegate,UITableViewDataSource,BussinessApiDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)BussinessApi*api;
@property (nonatomic,strong) JiaFenCaiLiaoShenHe* jiafencailiaoshenhe;
@property(nonatomic,strong)NSArray*ary;


@property(nonatomic,strong) NSString* isadmin;



@end

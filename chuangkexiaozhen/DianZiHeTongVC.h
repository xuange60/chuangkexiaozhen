//
//  DianZiHeTongVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/10.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "FilelistViewController.h"
#import "DianZiHeTongGuanLi.h"
#import "DianZiHeTongCell.h"
@interface DianZiHeTongVC : BaseViewController<BussinessApiDelegate,UITableViewDelegate,UITableViewDataSource>


@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSMutableArray*aryM;
@property(nonatomic,strong)DianZiHeTongGuanLi*hetong;






@end

//
//  BaoXiaoVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/20.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "HuoDongBaoXiao.h"
#import "BaoXiaoCell.h"
#import "FilelistViewController.h"
#import "AddBaoXiaoVC.h"
@interface BaoXiaoVC : BaseViewController<BussinessApiDelegate,UITableViewDelegate,UITableViewDataSource>


@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)HuoDongBaoXiao*baoxiao;

@property(nonatomic,strong)NSMutableArray*array;






@end

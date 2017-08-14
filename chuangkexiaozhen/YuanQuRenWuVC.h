//
//  YuanQuRenWuVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/14.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "YuanQuRenWuTongGao.h"
#import "AddYuanQuRenWuVC.h"
#import "DetailYuanQuRenWuVC.h"
#import "YuanQuRenWuCell.h"
@interface YuanQuRenWuVC : BaseViewController<UITableViewDelegate,UITableViewDataSource,BussinessApiDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)YuanQuRenWuTongGao*tonggao;


@property(nonatomic,strong)NSMutableArray*aryM;

@end

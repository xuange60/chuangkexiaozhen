//
//  ZiYuanPeiZhiVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/12.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "ZiYuanPeiZhiCell.h"
#import "EditZiYuanPeiZhiVC.h"
#import "ZiYuanPeiZhiGuanLi.h"

@interface ZiYuanPeiZhiVC : BaseViewController<BussinessApiDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)ZiYuanPeiZhiGuanLi*ziyuan;

@property(nonatomic,strong)NSMutableArray*array;












@end

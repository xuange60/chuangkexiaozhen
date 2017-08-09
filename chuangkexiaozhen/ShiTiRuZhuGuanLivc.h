//
//  ShiTiRuZhuGuanLivc.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/8.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "ShiTiRuZhuGuanLi.h"
#import "ShiTiRuZhuGuanLiCell.h"
#import "FilelistViewController.h"
#import "EditShiTiVC.h"
#import "AddShiTiVC.h"
@interface ShiTiRuZhuGuanLivc : BaseViewController<UITableViewDelegate,UITableViewDataSource,BussinessApiDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)ShiTiRuZhuGuanLi*shiti;

@property(nonatomic,strong)NSArray*array;




@end

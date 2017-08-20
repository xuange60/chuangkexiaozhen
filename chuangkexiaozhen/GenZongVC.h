//
//  GenZongVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/21.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "ChengGuoGenZongCell.h"
#import "FilelistViewController.h"
#import "AddGenZong.h"
#import "ChengGuoGenZong.h"
@interface GenZongVC : BaseViewController<BussinessApiDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)ChengGuoGenZong*genzong;

@property(nonatomic,strong)NSMutableArray*array;



@end

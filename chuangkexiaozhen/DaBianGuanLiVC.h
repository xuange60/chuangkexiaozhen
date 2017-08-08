//
//  DaBianGuanLiVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/8.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "BussinessApi.h"
#import "DaBianGuanLi.h"
#import "MarkScoreVC.h"
@interface DaBianGuanLiVC : BaseViewController<UITableViewDelegate,UITableViewDataSource,BussinessApiDelegate>


@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)BussinessApi*api;
@property(nonatomic,strong)DaBianGuanLi*dabian;

@property(nonatomic,strong)NSArray*array;











@end

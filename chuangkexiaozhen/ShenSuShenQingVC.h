//
//  ShenSuShenQingVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/12.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "ShenSuShenQingGuanLi.h"
#import "ShenSuShenQingCell.h"
#import "DetailShenSuVC.h"

@interface ShenSuShenQingVC : BaseViewController<UITableViewDelegate,UITableViewDataSource,BussinessApiDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)ShenSuShenQingGuanLi*shensu;

@property(nonatomic,strong)NSArray*array;

@property(nonatomic,strong)NSArray*InfoAry;



@end

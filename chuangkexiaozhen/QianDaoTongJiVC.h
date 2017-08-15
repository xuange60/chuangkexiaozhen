//
//  QianDaoTongJiVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/15.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "QianDaoTongJi.h"
#import "QianDaoTongJiCell.h"
#import "AddQianDaoTongJiVC.h"
#import "FilelistViewController.h"
@interface QianDaoTongJiVC : BaseViewController<UITableViewDelegate,UITableViewDataSource,BussinessApiDelegate>


@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)QianDaoTongJi*qiandao;

@property(nonatomic,strong)NSMutableArray*aryM;









@end

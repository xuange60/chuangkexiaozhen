//
//  KaoQinDetailVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/5.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"

@interface KaoQinDetailVC : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end
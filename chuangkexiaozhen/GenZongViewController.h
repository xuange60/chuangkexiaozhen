//
//  TuiChuViewController.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/5.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "GenZongFuWu.h"
#import "GenZongCell.h"
#import "BussinessApi.h"
#import "GenZongFuWuAddViewController.h"
@interface GenZongViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,BussinessApiDelegate>

@property (strong,nonatomic) GenZongFuWu* genzongfuwu;
@property (nonatomic,strong) NSArray* datas;

@property (strong, nonatomic) IBOutlet UITableView *tableview;

@end

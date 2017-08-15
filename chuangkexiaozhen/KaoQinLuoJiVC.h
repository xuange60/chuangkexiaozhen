//
//  KaoQinLuoJiVC.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/16.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "KaoQinLuoJi.h"
#import "KaoQinLuoJiUpdateVC.h"
#import "KaoQinLuoJiCell.h"
@interface KaoQinLuoJiVC : BaseViewController<UITableViewDelegate,UITableViewDataSource,BussinessApiDelegate>

@property (nonatomic,strong) KaoQinLuoJi* kaoqinluoji;

@property (nonatomic,strong) NSArray* datas;
@property (strong, nonatomic) IBOutlet UITableView *tableview;


@end

//
//  HuoDongLuYanViewController.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/6.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "BussinessApi.h"
#import "HuoDong.h"
#import "HuoDongLuYanCell.h"
#import "FilelistViewController.h"
#import "HuoDongLuYanDetailViewController.h"
#import "HuoDongLuYanAddVC.h"
@interface HuoDongLuYanViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,BussinessApiDelegate>

@property (strong,nonatomic) HuoDong* huodong;
@property (nonatomic,strong) NSArray* datas;

@property (strong, nonatomic) IBOutlet UITableView *tableview;



@end

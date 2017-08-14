//
//  FaKaGuanLiVC.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/14.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "FaKaGuanli.h"
#import "FaKaGuanLiCell.h"
#import "FaKaAddVC.h"
@interface FaKaGuanLiVC : BaseViewController<UITableViewDelegate,UITableViewDataSource,BussinessApiDelegate>

@property (nonatomic,strong) FaKaGuanli* fakaguanli;

@property (nonatomic,strong) NSArray* datas;
@property (strong, nonatomic) IBOutlet UITableView *tableview;


@end

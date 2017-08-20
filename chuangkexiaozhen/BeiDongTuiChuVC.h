//
//  BeiDongTuiChuVC.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/20.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "BeiDongTuiChu.h"
#import "BeiDongTuiChuAdd.h"
#import "BeiDongTuiChuCell.h"
#import "FilelistViewController.h"
@interface BeiDongTuiChuVC : BaseViewController<UITableViewDelegate,UITableViewDataSource,BussinessApiDelegate>

@property (nonatomic,strong) BeiDongTuiChu* beidongtuichu;

@property (nonatomic,strong) NSArray* datas;
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@property (strong,nonatomic)  UIBarButtonItem *rightBtnItem;
@property (strong,nonatomic) NSString* isadmin;

@end

//
//  ZhuDongTuiChuVC.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/16.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "ZhuDongTuiChu.h"
#import "ZhuDOngTuiChuCell.h"
#import "ZhuDongTuiChuAddVC.h"
#import "FilelistViewController.h"
@interface ZhuDongTuiChuVC : BaseViewController<UITableViewDelegate,UITableViewDataSource,BussinessApiDelegate>

@property (nonatomic,strong) ZhuDongTuiChu* zhudongtuichu;

@property (nonatomic,strong) NSArray* datas;
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@property (strong,nonatomic)  UIBarButtonItem *rightBtnItem;
@property (strong,nonatomic) NSString* isadmin;
@end

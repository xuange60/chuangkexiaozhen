//
//  PingFenDetailViewController.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/6.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "PaiHangBang.h"
#import "PingFenDetailCell.h"
@interface PingFenDetailViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,BussinessApiDelegate>

@property (strong,nonatomic) PaiHangBang* paihangbang;
@property (strong,nonatomic) NSString* ids;

@property (nonatomic,strong) NSArray* datas;

@property (nonatomic,strong) NSString* paihangbangtype;

@property (strong, nonatomic) IBOutlet UITableView *tableview;



@end

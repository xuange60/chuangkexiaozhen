//
//  ZongHeNengLiViewController.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/5.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "PaiHangBang.h"
#import "PaiHangBangCell.h"
#import "PingFenDetailViewController.h"
@interface PaiHangBangViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,BussinessApiDelegate>

@property (strong,nonatomic) PaiHangBang* paihangbang;
@property (nonatomic,strong) NSArray* datas;

@property (nonatomic,strong) NSString* paihangbangtype;

@property (strong, nonatomic) IBOutlet UITableView *tableview;



@end

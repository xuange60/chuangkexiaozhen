//
//  FuWuViewController.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/2.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "YuanQuFuWuShenQing.h"
#import "FuWuShenQingCell.h"
#import "FuWuShenQingAddViewController.h"
#import "FilelistViewController.h"
#import "FuWuShenQingDetailViewController.h"
@interface FuWuViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,BussinessApiDelegate>

@property (strong,nonatomic) YuanQuFuWuShenQing* yuanqufuwushenqing;
@property (nonatomic,strong) NSArray* datas;

@property (strong, nonatomic) IBOutlet UITableView *tableview;


@end

//
//  ActiveGuanLiVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/1.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BussinessApi.h"
#import "ActiveGuanLiCell.h"

#import "ActivePhotoVC.h"
#import "AddActiveVC.h"
#import "FilelistViewController.h"

@interface ActiveGuanLiVC : UIViewController<UITableViewDelegate,UITableViewDataSource,BussinessApiDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)BussinessApi*api;
@property(nonatomic,strong)NSArray*ary;






@end

//
//  KaoQinGuanLiVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/5.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "KaoQinGuanLi.h"
#import "KaoQinDetailVC.h"
@interface KaoQinGuanLiVC : BaseViewController<UIPickerViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)KaoQinGuanLi*kaoQin;

@property (strong, nonatomic) IBOutlet UITextField *startTime;
@property (strong, nonatomic) IBOutlet UITextField *endTime;


@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSArray*ary;




@end

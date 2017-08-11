//
//  XuNiRuZhuVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/11.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "XuNiRuZhuGuanLi.h"
#import "XuNiRuZhuCell.h"
#import "AddXuNiVC.h"
@interface XuNiRuZhuVC : BaseViewController<UITableViewDelegate,UITableViewDataSource,BussinessApiDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)XuNiRuZhuGuanLi*XuNi;

@property(nonatomic,strong)NSArray*array;

@property(nonatomic,strong)NSArray*InfoAry;













@end

//
//  KaiTongZhuXianVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/12.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "KaiTongZhuXianGuanLi.h"
#import "KaiTongZhuXianCell.h"
#import "AddKaiTongVC.h"
#import "EditZiYuanPeiZhiVC.h"
@interface KaiTongZhuXianVC : BaseViewController<UITableViewDelegate,UITableViewDataSource,BussinessApiDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)KaiTongZhuXianGuanLi*zhuxian;

@property(nonatomic,strong)NSMutableArray*array;


- (IBAction)editBtnClick:(id)sender forEvent:(UIEvent *)event;

- (IBAction)deleteBtnClick:(id)sender forEvent:(UIEvent *)event;






@end

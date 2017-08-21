//
//  YongHuVC.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/21.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "YongHuXinXi.h"
#import "YongHuModifyVC.h"
#import "YongHuModPwdVC.h"
#import "YongHuCell.h"
@interface YongHuVC : BaseViewController<UITableViewDelegate,UITableViewDataSource,BussinessApiDelegate>

@property (nonatomic,strong) YongHuXinXi* yonghuxinxi;

@property (nonatomic,strong) NSArray* datas;
@property (strong, nonatomic) IBOutlet UITableView *tableview;


@end

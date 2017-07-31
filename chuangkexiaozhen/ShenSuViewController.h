//
//  ShenSuViewController.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/7/31.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"

@interface ShenSuViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray* datas;

@property (strong, nonatomic) IBOutlet UITableView *tableview;

-(void)shenSuShenQingQuery;

@end

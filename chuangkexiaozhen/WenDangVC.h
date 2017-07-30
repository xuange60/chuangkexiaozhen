//
//  WengDangVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/27.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "xiazaiPhotoVC.h"
@interface WenDangVC : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray*Marray;
@property(nonatomic)NSInteger num;

@property (strong, nonatomic) IBOutlet UITableView *tableView;



@end

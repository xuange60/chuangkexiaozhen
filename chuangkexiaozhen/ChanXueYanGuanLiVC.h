//
//  ChanXueYanGuanLiVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/31.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "ChanXueYanPhotoVC.h"

@interface ChanXueYanGuanLiVC : BaseViewController<UITableViewDelegate,UITableViewDataSource>


@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSArray*array;
-(void)ReceiveShuJu;




@end

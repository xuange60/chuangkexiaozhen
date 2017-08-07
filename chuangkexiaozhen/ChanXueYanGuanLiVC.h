//
//  ChanXueYanGuanLiVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/31.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "ChanXueYanPhotoVC.h"
#import "BussinessApi.h"
#import "FilelistViewController.h"
@interface ChanXueYanGuanLiVC : BaseViewController<UITableViewDelegate,UITableViewDataSource,BussinessApiDelegate>


@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSArray*array;
@property(nonatomic,strong)BussinessApi*api;
-(void)ReceiveShuJu;




@end

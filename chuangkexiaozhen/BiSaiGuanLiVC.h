//
//  BiSaiGuanLiVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/30.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "bisaiPhotoVC.h"
#import "BussinessApi.h"
#import "FilelistViewController.h"
@interface BiSaiGuanLiVC : BaseViewController<UITableViewDelegate,UITableViewDataSource,BussinessApiDelegate>


@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSArray*array;
@property(nonatomic,strong)BussinessApi*api;
-(void)ReceiveShuJu;



@end

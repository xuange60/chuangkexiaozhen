//
//  JiangLiPhotoVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/3.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "JiangLiPhotoCell.h"
#import "xiazaiPhotoVC.h"

@interface JiangLiPhotoVC : BaseViewController<UITableViewDelegate,UITableViewDataSource,BussinessApiDelegate>

@property(nonatomic,strong)NSMutableArray*Marray;
@property(nonatomic)NSInteger num;
@property(nonatomic,strong)NSString*entryID;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)BussinessApi*api;
-(void)ReceiveShuJuPhoto:(NSString*)str;
@end

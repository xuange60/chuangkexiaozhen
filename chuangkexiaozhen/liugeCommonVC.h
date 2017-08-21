//
//  liugeCommonVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/21.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "liugeCommonCell.h"
#import "TuanDuiYunYing.h"
#import "FilelistViewController.h"
@interface liugeCommonVC : BaseViewController<UITableViewDelegate,UITableViewDataSource,BussinessApiDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)TuanDuiYunYing*yunying;
@property(nonatomic,strong)NSString*strTitle;
@property(nonatomic,strong)NSArray*ary;
@property(nonatomic,strong)NSArray*array;

-(void)setStr:(NSString*)str array:(NSArray*)ary  shujuAry:(NSArray*)array;











@end

//
//  DuoXuanVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/12.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"

@interface DuoXuanVC : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray*array;
@property(nonatomic,strong)UIButton*btn;
@property(nonatomic,strong)NSMutableString*Mstr;

@property (strong, nonatomic) IBOutlet UITableView *tableView;



-(void)setArray:(NSArray*)array  btn:(UIButton*)btn;




@end

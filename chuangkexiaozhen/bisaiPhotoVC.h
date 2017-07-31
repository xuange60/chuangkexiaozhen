//
//  bisaiPhotoVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/31.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface bisaiPhotoVC : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray*Marray;
@property(nonatomic)NSInteger num;
@property(nonatomic,strong)NSString*entryID;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

-(void)ReceiveShuJuPhoto:(NSString*)str;

@end

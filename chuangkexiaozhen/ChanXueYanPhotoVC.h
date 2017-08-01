//
//  ChanXueYanPhotoVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/1.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"

@interface ChanXueYanPhotoVC : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray*Marray;
@property(nonatomic)NSInteger num;
@property(nonatomic,strong)NSString*entryID;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

-(void)ReceiveShuJuPhoto:(NSString*)str;
@end

//
//  BiSaiGuanLiVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/30.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface BiSaiGuanLiVC : BaseViewController<UITableViewDelegate,UITableViewDataSource>



@property(nonatomic,strong)NSArray*array;
-(void)ReceiveShuJu;



@end

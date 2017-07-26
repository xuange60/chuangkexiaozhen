//
//  jieshaoVC.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/7/18.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface jieshaoVC : UIViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>



@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(strong,nonatomic) NSMutableArray*array;




@end

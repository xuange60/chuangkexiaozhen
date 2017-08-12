//
//  ShenSuShenQingCell.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/12.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShenSuShenQingCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *team;
@property (strong, nonatomic) IBOutlet UILabel *type;

@property (strong, nonatomic) IBOutlet UILabel *content;
@property (strong, nonatomic) IBOutlet UILabel *reason;

@property (strong, nonatomic) IBOutlet UILabel *time;

@property (strong, nonatomic) IBOutlet UILabel *statue;

@property (strong, nonatomic) IBOutlet UIButton *shouLiBtn;

@property (strong, nonatomic) IBOutlet UIButton *detailBtn;


@property (strong, nonatomic) IBOutlet UIButton *deleteBtn;







@end

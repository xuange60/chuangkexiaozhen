//
//  ZhuDOngTuiChuCell.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/16.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZhuDOngTuiChuCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIView *MyView;


@property (strong, nonatomic) IBOutlet UILabel *quitCompany;

@property (strong, nonatomic) IBOutlet UILabel *quitCause;


@property (strong, nonatomic) IBOutlet UILabel *quitDate;

@property (strong, nonatomic) IBOutlet UILabel *quitType;

@property (strong, nonatomic) IBOutlet UILabel *status;



@property (strong, nonatomic) IBOutlet UIButton *download;

@property (strong, nonatomic) IBOutlet UIButton *deletebtn;


@property (strong, nonatomic) IBOutlet UIButton *succ;


@property (strong, nonatomic) IBOutlet UIButton *nobtn;


@end

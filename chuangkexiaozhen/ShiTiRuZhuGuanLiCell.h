//
//  ShiTiRuZhuGuanLiCell.h
//  chuangkexiaozhen
//
//  Created by 小灰灰 on 2017/8/8.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShiTiRuZhuGuanLiCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lianxiren;

@property (strong, nonatomic) IBOutlet UILabel *lianxifangshi;

@property (strong, nonatomic) IBOutlet UILabel *jigouName;

@property (strong, nonatomic) IBOutlet UILabel *hangye;

@property (strong, nonatomic) IBOutlet UILabel *shenqingTime;

@property (strong, nonatomic) IBOutlet UILabel *shenqingType;

@property (strong, nonatomic) IBOutlet UILabel *baodaoType;

@property (strong, nonatomic) IBOutlet UILabel *totalScore;


@property (strong, nonatomic) IBOutlet UIButton *editBtn;
@property (strong, nonatomic) IBOutlet UIButton *addBtn;

@property (strong, nonatomic) IBOutlet UIButton *succBtn;
@property (strong, nonatomic) IBOutlet UIButton *detailBtn;

@property (strong, nonatomic) IBOutlet UIButton *errorBtn;
@property (strong, nonatomic) IBOutlet UIButton *deleteBtn;
@property (strong, nonatomic) IBOutlet UIButton *downloadBtn;
















@end

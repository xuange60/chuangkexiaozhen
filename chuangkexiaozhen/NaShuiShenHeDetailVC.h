//
//  NaShuiShenHeDetailVC.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/13.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "JiaFenCaiLiaoShenHe.h"
#import "ComboViewController.h"
@interface NaShuiShenHeDetailVC :BaseViewController<BussinessApiDelegate>

@property (strong, nonatomic) IBOutlet UITextField *dateType;

@property (strong, nonatomic) IBOutlet UITextField *taxLevel;

@property (strong, nonatomic) IBOutlet UITextField *taxPrice;

@property (strong, nonatomic) IBOutlet UITextField *taxType;
@property (strong, nonatomic) IBOutlet UITextField *taxTarget;




@property (strong, nonatomic) IBOutlet UITextField* score;
@property (strong, nonatomic) IBOutlet UILabel *scorelabel;



@property (strong, nonatomic) IBOutlet UITextField *status;




@property (strong, nonatomic) IBOutlet UIButton *approvecombo;

@property (strong, nonatomic) IBOutlet UIView *approveview;




@property (strong,nonatomic) NSString* isadmin;

@property (strong,nonatomic) NSDictionary* data;

@property (strong,nonatomic) JiaFenCaiLiaoShenHe* jiafencailiaoshenhe;


@property (strong,nonatomic) NSDictionary* detaildata;


@end

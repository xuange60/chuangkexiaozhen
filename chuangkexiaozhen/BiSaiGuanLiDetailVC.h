//
//  BiSaiGuanLiDetailVC.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/12.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "ComboViewController.h"
#import "JiaFenCaiLiaoShenHe.h"
@interface BiSaiGuanLiDetailVC : BaseViewController<BussinessApiDelegate>

@property (strong, nonatomic) IBOutlet UITextField *company;

@property (strong, nonatomic) IBOutlet UITextField *hornerName;

@property (strong, nonatomic) IBOutlet UITextField *orgnizationUnit;



@property (strong, nonatomic) IBOutlet UITextField *competeLevel;

@property (strong, nonatomic) IBOutlet UITextField* prizeAwarded;

@property (strong, nonatomic) IBOutlet UITextField *status;


@property (strong, nonatomic) IBOutlet UITextField *score;
@property (strong, nonatomic) IBOutlet UILabel *scorelabel;


@property (strong, nonatomic) IBOutlet UIButton *approvecombo;

@property (strong, nonatomic) IBOutlet UIView *approveview;

@property (strong, nonatomic) UIBarButtonItem* rightbutton;


@property (strong,nonatomic) NSString* isadmin;

@property (strong,nonatomic) NSDictionary* data;

@property (strong,nonatomic) JiaFenCaiLiaoShenHe* jiafencailiaoshenhe;

@end

//
//  ShiChangZhanYouLvDetailVC.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/13.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "JiaFenCaiLiaoShenHe.h"
#import "ComboViewController.h"
@interface ShiChangZhanYouLvDetailVC :BaseViewController<BussinessApiDelegate>

@property (strong, nonatomic) IBOutlet UITextField *percentLevel;

@property (strong, nonatomic) IBOutlet UITextField *marketPercent;

@property (strong, nonatomic) IBOutlet UITextField *marketDetail;

@property (strong, nonatomic) IBOutlet UITextField *organizationName;





@property (strong, nonatomic) IBOutlet UITextField* score;
@property (strong, nonatomic) IBOutlet UILabel *scorelabel;



@property (strong, nonatomic) IBOutlet UITextField *status;




@property (strong, nonatomic) IBOutlet UIButton *approvecombo;

@property (strong, nonatomic) IBOutlet UIView *approveview;

@property (strong, nonatomic) IBOutlet UIButton *approvesubmit;


@property (strong,nonatomic) NSString* isadmin;

@property (strong,nonatomic) NSDictionary* data;

@property (strong,nonatomic) JiaFenCaiLiaoShenHe* jiafencailiaoshenhe;


@property (strong,nonatomic) NSDictionary* detaildata;


@end

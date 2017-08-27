//
//  RenYuanJieGouDetailVC.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/13.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "BussinessApi.h"
#import "JiaFenCaiLiaoShenHe.h"
#import "ComboViewController.h"
@interface RenYuanJieGouDetailVC :BaseViewController<BussinessApiDelegate>

@property (strong, nonatomic) IBOutlet UITextField *toltalPerson;

@property (strong, nonatomic) IBOutlet UITextField *marketPerson;

@property (strong, nonatomic) IBOutlet UITextField *marketPersonPercent;

@property (strong, nonatomic) IBOutlet UITextField *techniquePerson;
@property (strong, nonatomic) IBOutlet UITextField *techniquePersonPercent;

@property (strong, nonatomic) IBOutlet UITextField *operatePerson;

@property (strong, nonatomic) IBOutlet UITextField *operatePersonPercent;

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

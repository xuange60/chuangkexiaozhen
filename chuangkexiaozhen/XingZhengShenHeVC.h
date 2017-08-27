//
//  XingZhengShenHeVC.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/22.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "TuanDuiYunYing.h"
#import "ComboViewController.h"
@interface XingZhengShenHeVC : BaseViewController<BussinessApiDelegate>

@property (strong, nonatomic) IBOutlet UILabel *lab1;

@property (strong, nonatomic) IBOutlet UILabel *lab2;

@property (strong, nonatomic) IBOutlet UILabel *lab3;

@property (strong, nonatomic) IBOutlet UILabel *lab4;

@property (strong, nonatomic) IBOutlet UILabel *lab5;

@property (strong, nonatomic) IBOutlet UILabel *lab6;





@property (strong, nonatomic) IBOutlet UILabel *lab11;

@property (strong, nonatomic) IBOutlet UILabel *lab12;

@property (strong, nonatomic) IBOutlet UILabel *lab13;

@property (strong, nonatomic) IBOutlet UILabel *lab14;

@property (strong, nonatomic) IBOutlet UILabel *lab15;

@property (strong, nonatomic) IBOutlet UILabel *lab16;


@property (strong, nonatomic) IBOutlet UIButton *approvecombo;

@property (strong, nonatomic) IBOutlet UIView *approveview;




@property (strong,nonatomic) TuanDuiYunYing* tuanduiyunying;
@property(nonatomic,strong)NSString*strTitle;
@property (nonatomic,strong) NSString* strid;

@property (nonatomic,strong) NSDictionary* data;


-(void)shuJu:(NSArray*)ary   array:(NSArray*)array;

@property(nonatomic,strong)NSArray*ary;
@property(nonatomic,strong)NSArray*array;


@end

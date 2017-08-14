//
//  FaKaAddVC.h
//  chuangkexiaozhen
//
//  Created by zx on 2017/8/14.
//  Copyright © 2017年 小灰灰. All rights reserved.
//

#import "BaseViewController.h"
#import "FaKaAddVC.h"
#import "FaKaGuanli.h"
#import "DuoXuanVC.h"
@interface FaKaAddVC : BaseViewController<BussinessApiDelegate>


@property (strong, nonatomic) IBOutlet UIButton *tena;


@property (strong, nonatomic) IBOutlet UIButton *name;

@property (strong, nonatomic) IBOutlet UITextField *card;

@property (strong,nonatomic) NSDictionary* tenanids;
@property (strong,nonatomic) NSDictionary* names;

@property FaKaGuanli* fakaguanli;

@end
